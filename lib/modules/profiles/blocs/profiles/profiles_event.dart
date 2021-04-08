part of 'profiles_bloc.dart';

@immutable
abstract class ProfilesEvent {
  const ProfilesEvent();

  List<Object> get props => [];
}

class FetchProfilesEvent extends ProfilesEvent {
  final String? searchText;
  final ProfileSort? sort;

  FetchProfilesEvent({this.searchText, this.sort});
}

class FetchProfilesAdditionalDataEvent extends ProfilesEvent {
  final List<Profile> profiles;

  FetchProfilesAdditionalDataEvent({required this.profiles});
}
