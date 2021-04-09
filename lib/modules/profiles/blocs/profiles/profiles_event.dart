part of 'profiles_bloc.dart';

@immutable
abstract class ProfilesEvent {
  const ProfilesEvent();

  List<Object> get props => [];
}

class FetchProfilesEvent extends ProfilesEvent {
  final String? searchText;
  final ProfileSort? sort;
  final int pageNumber;

  FetchProfilesEvent({this.searchText, this.sort, required this.pageNumber});
}

class FetchProfilesAdditionalDataEvent extends ProfilesEvent {
  final List<Profile> profileToUpdate;
  final List<Profile> profileUpdated;

  FetchProfilesAdditionalDataEvent({required this.profileToUpdate, required this.profileUpdated});
}
