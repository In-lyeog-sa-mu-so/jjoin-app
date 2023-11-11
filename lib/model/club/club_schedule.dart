class ClubEvent {
  final int id;
  final String title;
  final String date;
  final bool? isParticipate;

  ClubEvent({
    required this.id,
    required this.title,
    required this.date,
    this.isParticipate,
  });
}
