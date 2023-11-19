import 'package:get/get.dart';

import '../../model/search/search_club.dart';
import '../../model/search/search_tag.dart';
import '../../repository/search/search_club_repository.dart';

class SearchViewModel extends GetxController {
  final SearchRepository searchRepository;

  SearchViewModel({required this.searchRepository})
      : assert(searchRepository != null);

  late final RxList<SearchClub> _clubs;
  late final RxBool _isLoadingSearchClubs;
  List<SearchClub> get clubs => _clubs;
  bool get isLoadingSearchClubs => _isLoadingSearchClubs.value;

  late final RxList<Tag> _tags;
  late final RxBool _isLoadingTags;
  List<Tag> get tags => _tags;
  bool get isLoadingTags => _isLoadingTags.value;

  final RxString _searchQuery = "".obs;
  String get searchQuery => _searchQuery.value;
  set searchQuery(String value) => _searchQuery.value = value;

  @override
  void onInit() {
    _isLoadingSearchClubs = false.obs;
    _isLoadingTags = false.obs;

    super.onInit();

    initTags();
    initSearchClubs();
  }

  void initSearchClubs() {
    _isLoadingSearchClubs.value = true;
    searchRepository
        .readAllClubs()
        .then((value) => _clubs = value.obs)
        .then((value) => _isLoadingSearchClubs.value = false);
  }

  void initTags() {
    _isLoadingTags.value = true;
    searchRepository
        .readAllTags()
        .then((value) => _tags = value.obs)
        .then((_) => _isLoadingTags.value = false);
  }

  void fetchSearchClubs() async {
    _isLoadingSearchClubs.value = true;
    searchRepository
        .readSearchClubsByQuery(searchQuery, selectedTags.toList())
        .then((value) => _clubs.addAll(value))
        .then((_) => _isLoadingSearchClubs.value = false);
  }

  void sendSearchRequest() async {
    _isLoadingSearchClubs.value = true;
    try {
      List<SearchClub> response;
      if (selectedTags.isEmpty && searchQuery.isEmpty) {
        response = await searchRepository.readAllClubs();
        print("all");
        print(response);
      } else {
        response = await searchRepository.readSearchClubsByQuery(
          searchQuery,
          selectedTags.toList(),
        );
        print("search");
        print(response[0].clubName);
      }

      _clubs.value = response;
    } catch (e) {
      print('Error fetching search results: $e');
    } finally {
      _isLoadingSearchClubs.value = false;
    }
  }

  final RxList<String> _selectedTags = RxList<String>();
  RxList<String> get selectedTags => _selectedTags;

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
