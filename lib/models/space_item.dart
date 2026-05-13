class SpaceItem {
  final int id;
  final String title;
  final String summary;
  final String imageUrl;
  final String url;
  final String newsSite;
  final DateTime? publishedAt;

  const SpaceItem({
    required this.id,
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.url,
    required this.newsSite,
    required this.publishedAt,
  });

  factory SpaceItem.fromMap(Map<String, dynamic> map) {
    final String? publishedAtRaw = map['published_at'] as String?;
    return SpaceItem(
      id: map['id'] as int? ?? 0,
      title: map['title'] as String? ?? '',
      summary: map['summary'] as String? ?? '',
      imageUrl: map['image_url'] as String? ?? '',
      url: map['url'] as String? ?? '',
      newsSite: map['news_site'] as String? ?? '',
      publishedAt:
          publishedAtRaw == null ? null : DateTime.tryParse(publishedAtRaw),
    );
  }
}
