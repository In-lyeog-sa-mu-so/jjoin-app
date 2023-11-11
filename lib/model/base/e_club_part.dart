enum EClubPart implements Comparable<EClubPart> {
  DEPARTMENT(name: "학과"),
  UNION(name: "연합"),
  CENTRAL(name: "중앙");

  final String name;
  const EClubPart({required this.name});

  String get nameStr => name;

  @override
  int compareTo(EClubPart other) {
    return name.compareTo(other.name);
  }
}
