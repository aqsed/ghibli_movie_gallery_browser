import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_movie_gallery_browser/core/provider/dio_provider.dart';
import 'package:ghibli_movie_gallery_browser/movie/api/ghibli_api_connector.dart';

final ghibliApiConnectorProvider = Provider<GhibliApiConnector>((ref) => GhibliApiConnector(ref.read(dioProvider)));
