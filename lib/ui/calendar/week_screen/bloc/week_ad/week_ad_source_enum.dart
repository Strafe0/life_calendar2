enum WeekAdSource {
  goals,
  events,
  photos;

  bool get isGoals => this == goals;
  bool get isEvents => this == events;
  bool get isPhotos => this == photos;
}
