# Ghibli Movie Gallery Browser

A small Flutter app that browses Studio Ghibli films from the public
[Ghibli API](https://ghibliapi.vercel.app). It shows a gallery of films, a
detail page for each film, including related people, species, locations and
vehicles), and lets the user mark favorites and give a personal 1–5 rating that
is persisted locally.

## Requirements

- Flutter `3.35+, Dart SDK `^3.9.2`
- A connected ios or android device or simulator

Check your toolchain with:

```bash
flutter --version
flutter doctor
```

## How to Run

```bash
# 1. Install dependencies
flutter pub get

# 2. Generate .g.dart
dart run build_runner build --delete-conflicting-outputs

# 3. Run the app
flutter run
```

## Architecture

Feature-first layout under `lib/`:

```
lib/
  app/theme/
  core/
    extension/          # Small String/time-formatting helper
    provider/           # Dio + SharedPreferences Riverpod providers
  movie/
    api/                # GhibliApiConnector — thin Dio wrapper over the REST API
    model/dto/          # API DTOs (json_serializable, *.g.dart generated)
    model/              # UI/domain models (MovieListItem, MovieDetails, gallery mode)
    repository/         # MovieRepository — merges API data with user data
    provider/           # Riverpod providers wiring the above together
    page/               # Browsing page + detail page
    widget/             # Gallery, cards, filter bar, rating stars, sections, etc.
  user_data/
    model/              # UserMovieData (favorite + rating)
    repository/         # UserMovieDataRepository — persists to SharedPreferences
    provider/           # Provider wiring
```

**Data flow.** `GhibliApiConnector` fetches raw DTOs → `MovieRepository`
combines film data with the locally-stored `UserMovieData` and exposes reactive
`Stream`s → Riverpod `StreamProvider`s expose those to the UI → widgets render
loading / error / data states.

The repository layer is the single source of truth: it joins remote film data
with the user's favorites/ratings stream so the UI updates immediately when the
user toggles a favorite or changes a rating, while persistence happens in the
background (with optimistic update + rollback on failure).

## Decisions worth noting
These are choices made on top of the bare requirement:

- **State management — Riverpod (`flutter_riverpod` 3.x).** All app state, data
  fetching and dependency wiring go through providers. `StreamProvider` /
  `StreamProvider.autoDispose.family` drive the reactive UI.
- **Dependency injection — Riverpod as the composition root.** The data/domain
  layer (`GhibliApiConnector`, `MovieRepository`, `UserMovieDataRepository`) uses
  plain **constructor injection** so each class is testable in isolation. The `provider/` files are the only place that knows how
  to build the graph and push instances in. The one instance locator is 
  `ref.read(...)`.
- **Networking — Dio.** Configured once in `dioProvider` with base URL and
  10s timeouts, plus a `LogInterceptor` for development visibility.
- **Local persistence — SharedPreferences.** Favorites and personal ratings are
  stored as a single JSON map keyed by movie id, surfaced as a broadcast
  `Stream` so the whole UI reacts to changes. Updates are optimistic and roll
  back if writing fails.
- **DTO / domain separation.** API responses are parsed into DTOs via
  `json_serializable`; the UI consumes purpose-built models
  (`MovieListItem`, `MovieDetails`) rather than raw DTOs.
- **Rich detail page (beyond the basic list).** The detail page resolves and
  displays the film's related **people, species, locations and vehicles** by
  fetching the referenced sub-resources in parallel (Dart record destructuring +
  `Future.wait`). The Ghibli API returns a placeholder URL when a relation is
  empty, so those are filtered out before fetching.
- **Extra UX features:**
  - Favorites filter and a personal-rating filter (segmented buttons with live
    counts) on the gallery.
  - Personal star rating, editable from both the gallery card and the detail
    page.
  - Rotten Tomatoes score display, "film facts" card, expandable world-detail
    sections, collapsing banner app bar.
  - Loading, error (with retry) and graceful image-fallback states.
## Known shortcuts / things done sub-optimally (for context)
- **No tests.** 
  The repository/connector layers are written to be testable (constructor
  injection of Dio and SharedPreferences) but I did not add unit tests.
- **Light theme only.** No dark mode / theming via `ThemeExtension`.
- **No app-level routing package.** Plain `Navigator.push` is enough for two
  screens; `go_router` or alternative would be the choice if the project grew.