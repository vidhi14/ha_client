part of '../main.dart';

class TimerEntity extends Entity {
  TimerEntity(Map rawData) : super(rawData);

  Duration duration;

  @override
  void update(Map rawData) {
    super.update(rawData);
    String durationSource = "${attributes["duration"]}";
    List<String> durationList = durationSource.split(":");
    if (durationList.length == 1) {
      duration = Duration(seconds: int.tryParse(durationList[0] ?? 0));
    } else if (durationList.length == 2) {
      duration = Duration(
          hours: int.tryParse(durationList[0]) ?? 0,
          minutes: int.tryParse(durationList[1]) ?? 0
      );
    } else if (durationList.length == 3) {
      duration = Duration(
          hours: int.tryParse(durationList[0]) ?? 0,
          minutes: int.tryParse(durationList[1]) ?? 0,
        seconds: int.tryParse(durationList[2]) ?? 0
      );
    } else {
      Logger.e("Cann't parse $entityId duration: $durationSource");
      duration = Duration(seconds: 0);
    }
  }

  @override
  Widget _buildStatePart(BuildContext context) {
    return TimerState();
  }
}