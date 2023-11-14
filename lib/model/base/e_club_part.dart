enum EClubPart implements Comparable<EClubPart> {
  NONE(name: "없음"),
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

  factory EClubPart.fromString(String part) {
    switch (part) {
      case "없음":
        return EClubPart.NONE;
      case "학과":
        return EClubPart.DEPARTMENT;
      case "연합":
        return EClubPart.UNION;
      case "중앙":
        return EClubPart.CENTRAL;
      default:
        return EClubPart.DEPARTMENT;
    }
  }
}
