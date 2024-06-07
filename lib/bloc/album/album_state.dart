import 'package:mobile/data/model/album.dart';

abstract class AlbumState {}

class AlbumInitState extends AlbumState {}

class AlbumListResponseState extends AlbumState {
  Album album;

  AlbumListResponseState(this.album);
}
