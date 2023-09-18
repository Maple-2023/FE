class RecommandCourse {
  final int minute;
  final double distance;
  final List<List<num>> routes;

  RecommandCourse(this.minute, this.distance, this.routes);

  // 추천 코스는 get으로 받아오기만 하니깐
  RecommandCourse.fromJson(Map<String, dynamic> json)
      : minute = json['minute'],
        distance = json['distance'],
        routes = json['routes'];
}
