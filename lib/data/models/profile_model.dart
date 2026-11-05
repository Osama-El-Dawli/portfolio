import 'package:portfolio/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.name,
    required super.title,
    required super.email,
    required super.phone,
    required super.location,
    required super.bio,
    required super.linkedinUrl,
    required super.githubUrl,
    required super.avatarUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] as String,
      title: json['title'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      location: json['location'] as String,
      bio: json['bio'] as String,
      linkedinUrl: json['linkedin_url'] as String,
      githubUrl: json['github_url'] as String,
      avatarUrl: json['avatar_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'email': email,
      'phone': phone,
      'location': location,
      'bio': bio,
      'linkedin_url': linkedinUrl,
      'github_url': githubUrl,
      'avatar_url': avatarUrl,
    };
  }
}
