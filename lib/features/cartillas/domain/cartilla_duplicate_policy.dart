class DuplicatePolicy {
  final bool copyHeader;
  final List<String> copyBodyKeys;
  final List<String> resetBodyKeys;

  const DuplicatePolicy({
    this.copyHeader = true,
    this.copyBodyKeys = const [],
    this.resetBodyKeys = const [],
  });
}
