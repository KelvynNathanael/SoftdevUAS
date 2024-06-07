import 'package:mobile/DI/service_locator.dart';
import 'package:mobile/data/datasource/artist_datasource.dart';
import 'package:mobile/data/model/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> artistList();
}

class ArtistLocalRepository extends ArtistRepository {
  final ArtistDatasource _datasource = locator.get();
  @override
  Future<List<Artist>> artistList() async {
    return await _datasource.getArtistList();
  }
}
