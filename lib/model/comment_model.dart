class CommentModel {
  String? fullName;
  String? profileImg;
  String? comment;
  String? bookId;
  String? date;

  CommentModel({
    this.fullName,
    this.profileImg,
    this.comment,
    this.bookId,
    this.date,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      fullName: json['full_name'],
      profileImg: json['profile_pic'],
      comment: json['comment'],
      bookId: json['book_id'],
      date: json['date'],
    );
  }
}
