class Category {
  /// unique id (not repeat)
  final String id ;

  final int iconId;
  /// name for category 8 - 12 character not more
  final String categoryName;

  Category({
    required this.id,
    required this.iconId,
    required this.categoryName,
  });
}
