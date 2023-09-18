String weatherCondition(int code) {
  String weatherTxt = "";
  switch (code ~/ 100) {
    case 2:
      weatherTxt = "뇌우 및 비";
      break;
    case 3:
      weatherTxt = "약한 비";
      break;
    case 5:
      weatherTxt = "비";
      break;
    case 6:
      weatherTxt = "눈";
      break;
    case 7:
      weatherTxt = "흐림";
      break;
    case 8:
      if (code == 800) {
        weatherTxt = "맑음";
      } else {
        weatherTxt = "흐림";
      }
      break;
    default:
      weatherTxt = "알 수 없음";
  }
  return weatherTxt;
}
