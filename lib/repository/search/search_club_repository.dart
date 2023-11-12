import '../../model/search/search_club.dart';
import '../../model/search/search_tag.dart';
import '../../provider/search/search_local_provider.dart';
import '../../provider/search/search_remote_provider.dart';

class SearchRepository {
  final SearchLocalProvider searchLocalProvider;
  final SearchRemoteProvider searchRemoteProvider;

  SearchRepository(
      {required this.searchLocalProvider, required this.searchRemoteProvider})
      : assert(searchLocalProvider != null || searchRemoteProvider != null);

  List<SearchClub> getSearchClubs() {
    return searchLocalProvider.getDummyClubs();
  }

  List<Tag> getTags() {
    return searchLocalProvider.getDummyTags();
  }
}
