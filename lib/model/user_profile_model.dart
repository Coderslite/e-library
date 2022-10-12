class UserProfileModel {
  String? id;
  String? fullName;
  String? email;
  String? profileImg;
  String? department;
  UserProfileModel({
    this.id,
    this.fullName,
    this.email,
    this.profileImg,
    this.department,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      profileImg: json['profile_pic'],
      department: json['department'],
    );
  }
}
