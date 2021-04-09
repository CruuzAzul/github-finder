part of 'profiles_bloc.dart';

@immutable
abstract class ProfilesState extends Equatable {
  final List<Profile>? profiles;
  final bool hasReachedMax;
  final int pageNumber;

  const ProfilesState({
    this.profiles,
    this.hasReachedMax = false,
    this.pageNumber = 1,
  });

  @override
  List<Object?> get props => [pageNumber];
}

class ProfilesInitialeState extends ProfilesState {
  const ProfilesInitialeState();
}

class ProfilesFetchInProgressState extends ProfilesState {
  const ProfilesFetchInProgressState();
}

class ProfilesFetchSuccessState extends ProfilesState {
  final List<Profile>? profiles;
  final bool hasReachedMax;
  final int pageNumber;

  const ProfilesFetchSuccessState({this.profiles, required this.hasReachedMax, required this.pageNumber});

  ProfilesFetchSuccessState copyWith(
      {List<Profile>? profiles, required bool hasReachedMax, required int pageNumber}) {
    return ProfilesFetchSuccessState(
      profiles: profiles ?? this.profiles,
      hasReachedMax: hasReachedMax,
      pageNumber: pageNumber,
    );
  }

  @override
  List<Object?> get props => [profiles, hasReachedMax, pageNumber];
}

class ProfilesFetchErrorState extends ProfilesState {
  const ProfilesFetchErrorState();
}
