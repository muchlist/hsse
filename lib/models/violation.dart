class Violation {
  final String id;
  final String detail;
  final DateTime date;
  final String location;
  final String imgUrl;
  final bool approved;
  final DateTime approvedDate;
  final String approver;

  Violation(
      {required this.id,
      required this.detail,
      required this.date,
      required this.location,
      required this.imgUrl,
      required this.approved,
      required this.approvedDate,
      required this.approver});
}
