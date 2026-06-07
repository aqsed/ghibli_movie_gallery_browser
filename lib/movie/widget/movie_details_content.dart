import 'package:flutter/material.dart';
import 'package:ghibli_movie_gallery_browser/core/extension/time_format_string_extension.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/dto/movie_dto.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/movie_details.dart';
import 'package:ghibli_movie_gallery_browser/movie/widget/expandable_record_section.dart';
import 'package:ghibli_movie_gallery_browser/movie/widget/favorite_button.dart';
import 'package:ghibli_movie_gallery_browser/movie/widget/labelled_value.dart';
import 'package:ghibli_movie_gallery_browser/movie/widget/movie_detail_header.dart';
import 'package:ghibli_movie_gallery_browser/movie/widget/movie_rating_stars.dart';
import 'package:ghibli_movie_gallery_browser/movie/widget/rotten_tomatoes_score_container.dart';

class MovieDetailsContent extends StatelessWidget {
  final MovieDetails details;
  final ValueChanged<bool> onFavoriteChanged;
  final ValueChanged<int?> onRatingChanged;
  final bool isWorldDetailsLoading;

  const MovieDetailsContent({
    super.key,
    required this.details,
    required this.onFavoriteChanged,
    required this.onRatingChanged,
    this.isWorldDetailsLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final movie = details.movie;

    return CustomScrollView(
      slivers: [
        _buildHeader(movie),
        SliverToBoxAdapter(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 920),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (movie.rottenTomatoesRating.isNotEmpty) ...[
                      RottenTomatoesScoreContainer(score: movie.rottenTomatoesRating),
                      const SizedBox(height: 16),
                    ],
                    _buildRating(theme),
                    const SizedBox(height: 22),
                    Text(movie.description, style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 28),
                    _buildFactsCard(theme, movie),
                    const SizedBox(height: 28),
                    Text('World details', style: theme.textTheme.headlineSmall),
                    const SizedBox(height: 12),
                    if (isWorldDetailsLoading)
                      const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()))
                    else ...[
                      _buildPeopleSection(),
                      const SizedBox(height: 10),
                      _buildSpeciesSection(),
                      const SizedBox(height: 10),
                      _buildLocationsSection(),
                      const SizedBox(height: 10),
                      _buildVehiclesSection(),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(MovieDto movie) {
    return MovieDetailHeader(
      imageUrl: movie.movieBanner.isEmpty ? movie.image : movie.movieBanner,
      title: movie.title,
      subtitle: movie.originalTitleRomanised,
      heroTag: movie.id,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: FavoriteButton(isFavorite: details.isFavorite, onChanged: onFavoriteChanged),
        ),
      ],
    );
  }

  Widget _buildRating(ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Your rating', style: theme.textTheme.labelLarge),
        const SizedBox(width: 8),
        MovieRatingStars(rating: details.userRating, onChanged: onRatingChanged, iconSize: 28),
      ],
    );
  }

  Widget _buildFactsCard(ThemeData theme, MovieDto movie) {
    final facts = <LabelledFact>[
      ('Original title', movie.originalTitleRomanised),
      ('Director', movie.director),
      ('Producer', movie.producer),
      ('Release date', movie.releaseDate),
      ('Running time', movie.runningTime.formatMinutesToHourAndMinute()),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline_rounded, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Film facts', style: theme.textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = constraints.maxWidth < 680 ? constraints.maxWidth : (constraints.maxWidth - 12) / 2;

                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: facts
                      .map(
                        (fact) => SizedBox(
                          width: itemWidth,
                          child: LabelledValue(label: fact.$1, value: fact.$2),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeopleSection() {
    return ExpandableRecordSection(
      title: 'People',
      icon: Icons.groups_rounded,
      emptyText: 'No people are listed for this film.',
      records: details.people
          .map(
            (person) => (
              title: person.name,
              subtitle: null,
              facts: <LabelledFact>[
                ('Gender', person.gender),
                ('Age', person.age),
                ('Eye color', person.eyeColor),
                ('Hair color', person.hairColor),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget _buildSpeciesSection() {
    return ExpandableRecordSection(
      title: 'Species',
      icon: Icons.pets_rounded,
      emptyText: 'No species are listed for this film.',
      records: details.species
          .map(
            (item) => (
              title: item.name,
              subtitle: null,
              facts: <LabelledFact>[
                ('Classification', item.classification),
                ('Eye colors', item.eyeColors),
                ('Hair colors', item.hairColorDescription),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget _buildLocationsSection() {
    return ExpandableRecordSection(
      title: 'Locations',
      icon: Icons.map_rounded,
      emptyText: 'No locations are listed for this film.',
      records: details.locations
          .map(
            (location) => (
              title: location.name,
              subtitle: null,
              facts: <LabelledFact>[
                ('Climate', location.climate),
                ('Terrain', location.terrain),
                ('Surface water', location.surfaceWater),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget _buildVehiclesSection() {
    return ExpandableRecordSection(
      title: 'Vehicles',
      icon: Icons.directions_car_rounded,
      emptyText: 'No vehicles are listed for this film.',
      records: details.vehicles
          .map(
            (vehicle) => (
              title: vehicle.name,
              subtitle: vehicle.description,
              facts: <LabelledFact>[('Class', vehicle.vehicleClass), ('Length', vehicle.length)],
            ),
          )
          .toList(),
    );
  }
}
