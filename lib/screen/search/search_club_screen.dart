import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../provider/search/search_local_provider.dart';
import '../../provider/search/search_provider.dart';
import '../../repository/search/search_club_repository.dart';
import '../../viewmodel/search/search_viewmodel.dart';
import '../../widget/base/default_appbar.dart';
import '../../widget/search/search_club_card_list_widget.dart';
import '../../widget/search/search_field_widget.dart';

class SearchClubScreen extends StatefulWidget {
  const SearchClubScreen({Key? key}) : super(key: key);

  @override
  _SearchClubScreenState createState() => _SearchClubScreenState();
}

class _SearchClubScreenState extends State<SearchClubScreen> {
  late final SearchViewModel _searchViewModel;

  @override
  void initState() {
    super.initState();
    // Initialize the SearchViewModel
    _searchViewModel = Get.put<SearchViewModel>(SearchViewModel(
      searchRepository: SearchRepository(
        searchLocalProvider: Get.put(SearchLocalProvider()),
        searchProvider: Get.put(SearchProvider()),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: DefaultAppBar(title: "동아리 찾기"),
      ),
      body: Column(
        children: [
          SearchFieldWidget(
            onQueryChanged: (value) {
              _searchViewModel.searchQuery = value;
            },
            onSearchPressed: () {
              _searchViewModel.sendSearchRequest();
            },
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(
              () => _searchViewModel.isLoadingTags
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: _searchViewModel.tags
                            .map(
                              (tag) => FilterChip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                side: BorderSide(
                                    color: Colors.grey.withOpacity(0.03),
                                    width: 0),
                                showCheckmark: false,
                                label: Text(tag.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400)),
                                selected: _searchViewModel.selectedTags
                                    .contains(tag.name),
                                selectedColor:
                                    Color(0xFF56D57F).withOpacity(0.5),
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                onSelected: (bool selected) {
                                  _searchViewModel.toggleTagSelection(tag.name);
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (_searchViewModel.isLoadingSearchClubs) {
                return Center(child: CircularProgressIndicator());
              }
              if (_searchViewModel.clubs.isEmpty) {
                return Center(child: Text('No clubs found.'));
              } else {
                return ClubCardListWidget(clubs: _searchViewModel.clubs);
              }
            }),
          ),
        ],
      ),
    );
  }
}
