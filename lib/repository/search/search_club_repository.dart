import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../model/search/search_club.dart';
import '../../model/search/search_tag.dart';
import '../../provider/search/search_local_provider.dart';
import '../../provider/search/search_provider.dart';

class SearchRepository {
  static final String _imageUrl = dotenv.env['JJOIN_IMAGE_SERVER_URL']!;
  final SearchLocalProvider searchLocalProvider;
  final SearchProvider searchProvider;

  SearchRepository(
      {required this.searchLocalProvider, required this.searchProvider})
      : assert(searchLocalProvider != null || searchProvider != null);

  Future<List<Tag>> readAllTags() async {
    Map<String, dynamic> data = await searchProvider.getAllTags();
    List<Tag> result =
        data["data"].map<Tag>((json) => Tag.fromJson(json)).toList();
    if (result.isEmpty) {
      result.add(Tag.empty());
    }
    return result;
  }

  Future<List<SearchClub>> readSearchClubsByQuery(
      String searchQuery, List<String> tags) async {
    Map<String, dynamic> data =
        await searchProvider.searchClubsByQuery(searchQuery, tags);
    var result = data["clubs"]
        .map<SearchClub>(
            (json) => SearchClub.fromJson(json: json, imageUrl: _imageUrl))
        .toList();
    if (result.length == 0) {
      result.add(SearchClub.empty());
    }
    return result;
  }

  Future<List<SearchClub>> readAllClubs() async {
    Map<String, dynamic> data = await searchProvider.getAllClubs();
    var result = data["clubs"]
        .map<SearchClub>(
            (json) => SearchClub.fromJson(json: json, imageUrl: _imageUrl))
        .toList();
    if (result.isEmpty) {
      result.add(SearchClub.empty());
    }
    return result;
  }
}
