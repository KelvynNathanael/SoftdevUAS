import 'package:mobile/data/model/music.dart';

class Category {
  String name;
  String imageURL;
  List<Music> songs;
  Category(this.name, this.imageURL, this.songs);
}
