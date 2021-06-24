class FilterTruck {
  final String? branch;
  final String? identity;
  final String? owner;
  final int? active; // -1 0 1
  final int? block; // -1 0 1

  FilterTruck({
    required this.branch,
    required this.identity,
    required this.owner,
    required this.active,
    required this.block,
  });
}
