class FilterTruck {
  final String? branch;
  final String? identity;
  final String? owner;
  final int? active; // -1 0 1
  final int? block; // -1 0 1

  FilterTruck({
    this.branch,
    this.identity,
    this.owner,
    this.active,
    this.block,
  });
}
