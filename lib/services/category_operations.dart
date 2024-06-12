import 'package:mobile/data/model/category.dart';
import 'package:mobile/services/music_operations.dart';

class CategoryOperations {
  CategoryOperations._();

  static Future<List<Category>> getCategories() async {
    // Replace this with the actual data fetching logic
    List<Category> categories = [
      Category(
        'Top Songs',
        'https://is1-ssl.mzstatic.com/image/thumb/Purple123/v4/0e/09/c4/0e09c462-c0cd-0a6c-d748-ea69b70442b7/source/256x256bb.jpg',
        await MusicOperations.getMusicDetails([
          '6rWblGW0pBcB3uygxBuWZV',
          '32Pdf9eyXDEMoClEJW6yYP',
          '2S2laN33BdttxJ8yyv4VbX',
        ]),
      ),
      Category(
        'MJ Hits',
        'https://is1-ssl.mzstatic.com/image/thumb/Purple71/v4/d1/ba/85/d1ba8582-972e-7e02-6f3b-cc47adfc055f/source/256x256bb.jpg',
        await MusicOperations.getMusicDetails([
          '6rWblGW0pBcB3uygxBuWZV',
        ]),
      ),
    ];

    print("Categories loaded: $categories");
    return categories;
  }
}
