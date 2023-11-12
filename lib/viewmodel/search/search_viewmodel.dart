import 'package:get/get.dart';

import '../../model/search/search_club.dart';
import '../../model/search/search_tag.dart';
import '../../repository/search/search_club_repository.dart';

class SearchViewModel extends GetxController {
  final SearchRepository searchRepository;

  SearchViewModel({required this.searchRepository})
      : assert(searchRepository != null);

  final RxList<SearchClub> _clubs = RxList();
  final RxBool _isLoadingSearchClubs = false.obs;
  List<SearchClub> get clubs => _clubs;
  bool get isLoadingSearchClubs => _isLoadingSearchClubs.value;

  final RxList<Tag> _tags = RxList();
  final RxBool _isLoadingTags = false.obs;
  List<Tag> get tags => _tags;
  bool get isLoadingTags => _isLoadingTags.value;

  final RxString _searchQuery = "".obs;
  String get searchQuery => _searchQuery.value;
  set searchQuery(String value) => _searchQuery.value = value;

  @override
  void onInit() {
    super.onInit();

    fetchSearchClubs();

    fetchTags();
  }

  void fetchSearchClubs() async {
    _isLoadingSearchClubs.value = true;
    try {
      var result = await searchRepository.getSearchClubs();
      _clubs.assignAll(result); // Make sure to use assignAll
    } catch (e) {
      // Handle errors appropriately
      print("Error fetching clubs: $e");
    } finally {
      _isLoadingSearchClubs.value = false;
    }
  }

  void fetchTags() {
    _isLoadingTags.value = true;
    _tags.value = searchRepository.getTags();
    _isLoadingTags.value = false;
  }

  // RxList to hold the selected tags
  final RxList<String> _selectedTags = RxList<String>();
  RxList<String> get selectedTags => _selectedTags;

  // Method to update selected tags
  void toggleTagSelection(String tagName) {
    if (_selectedTags.contains(tagName)) {
      _selectedTags.remove(tagName);
    } else {
      _selectedTags.add(tagName);
    }
    _selectedTags.refresh();
  }

  void clearSelectedTags() {
    _selectedTags.clear();
  }
}
