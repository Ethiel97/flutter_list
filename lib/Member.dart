class Member {
  final String login;
  final String avatarUrl;
  bool isFavorite;

  Member(this.login, this.avatarUrl, {this.isFavorite = false}) {
    if (login == null) {
      throw new ArgumentError(
          "login of Member cannot be null. " "Received: '$login'");
    }

    if (avatarUrl == null) {
      throw new ArgumentError(
          "avatarUrl of Member cannot be null. " "Received: '$avatarUrl'");
    }

  }

    //  set isFavorite(bool val) {
    //   isFavorite = val;
    //  }
}
