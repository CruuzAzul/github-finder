import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/modules/profiles/widgets/bottom_loader.dart';

import '../blocs/blocs.dart';
import '../widgets/profile_api_card.dart';

class ProfilesList extends StatefulWidget {
  const ProfilesList({Key? key}) : super(key: key);

  @override
  _ProfilesListState createState() => _ProfilesListState();
}

class _ProfilesListState extends State<ProfilesList> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  late ProfilesBloc _profilesBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _profilesBloc = BlocProvider.of<ProfilesBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<ProfilesBloc, ProfilesState>(
        builder: (context, state) {
          if (state is ProfilesInitialeState) {
            return _Status(
              imageURL: 'assets/images/img_home.png',
              label: 'Enter a name in the search bar to start !',
            );
          }

          if (state is ProfilesFetchErrorState) {
            return _Status(
              imageURL: 'assets/images/img_empty.png',
              label: 'An error occurred ! Please retry later !',
            );
          }

          if (state is ProfilesFetchInProgressState) {
            return Column(
              children: [
                SizedBox(height: 200),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }

          final profiles = (state as ProfilesFetchSuccessState).profiles!;

          if (profiles.isEmpty) {
            return _Status(
              imageURL: 'assets/images/img_empty.png',
              label: 'No results found !',
            );
          }

          return Flexible(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<ProfilesBloc>().add(
                      FetchProfilesEvent(
                        searchText: context.read<SearchBloc>().state.text,
                        sort: context.read<FiltersBloc>().state.filter,
                        pageNumber: 1,
                      ),
                    );
              },
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (_, index) {
                  return index >= state.profiles!.length
                      ? BottomLoader()
                      : Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: ProfileApiCard(
                            key: Key(profiles[index].login),
                            profile: profiles[index],
                          ));
                },
                itemCount: state.hasReachedMax
                    ? state.profiles!.length
                    : state.profiles!.length + 1,
                controller: _scrollController,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _profilesBloc.add(FetchProfilesEvent(
          searchText: context.read<SearchBloc>().state.text,
          pageNumber: context.read<ProfilesBloc>().state.pageNumber));
    }
  }
}

class _Status extends StatelessWidget {
  final String imageURL;
  final String label;

  _Status({required this.imageURL, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(height: 100),
      Image.asset(imageURL),
      SizedBox(height: 40),
      Text(
        label,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
      ),
    ]);
  }
}
