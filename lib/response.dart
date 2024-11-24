class PostResponse {
  const PostResponse({required this.id});

  final int id;

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(id: json['id'] as int);
  }
}
