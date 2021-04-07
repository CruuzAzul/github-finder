enum ProfileSort {
  joined,
  repositories,
  followers,
  nothing,
}

extension ProfileSortToString on ProfileSort {
  String displayProfileSort() {
    switch (this) {
      case ProfileSort.joined:
        return 'Creation date';
      case ProfileSort.repositories:
        return 'Number of repositories';
      case ProfileSort.followers:
        return 'Number of followers';
      case ProfileSort.nothing:
        return 'Nothing';
      default:
        return '';
    }
  }

  String profileSortToString() {
    switch (this) {
      case ProfileSort.joined:
        return 'joined';
      case ProfileSort.repositories:
        return 'repositories';
      case ProfileSort.followers:
        return 'followers';
      default:
        return '';
    }
  }
}
