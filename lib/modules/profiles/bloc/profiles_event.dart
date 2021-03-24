part of 'profiles_bloc.dart';

@immutable
abstract class ProfilesEvent {
  const ProfilesEvent();

  @override
  List<Object> get props => [];
}

class FetchProfilesEvent extends ProfilesEvent {
  final String searchText;

  FetchProfilesEvent(this.searchText);
}