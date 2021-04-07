part of 'profiles_bloc.dart';

@immutable
abstract class ProfilesState extends Equatable {
  const ProfilesState();

  @override
  List<Object> get props => [];
}

class ProfilesInitialeState extends ProfilesState {
  const ProfilesInitialeState();
}

class ProfilesFetchInProgressState extends ProfilesState {
  const ProfilesFetchInProgressState();
}

class ProfilesFetchSuccessState extends ProfilesState {
  final List<Profile> profiles;

  const ProfilesFetchSuccessState({this.profiles});

  @override
  List<Object> get props => [profiles];
}

class ProfilesFetchErrorState extends ProfilesState {
  const ProfilesFetchErrorState();
}
