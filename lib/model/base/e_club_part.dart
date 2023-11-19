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
      case "NONE":
        return EClubPart.NONE;
      case "MAJOR":
        return EClubPart.DEPARTMENT;
      case "UNION":
        return EClubPart.UNION;
      case "CENTER":
        return EClubPart.CENTRAL;
      default:
        return EClubPart.NONE; // 기본값을 NONE으로 변경했습니다.
    }
  }
}
