import 'package:json_annotation/json_annotation.dart';

part 'timeclock.g.dart';

@JsonSerializable()
class TimeClock {
  final bool isTracking;

  @JsonKey(
      name: 'start-time',
      fromJson: _dateTimeFromEpochUs,
      toJson: _dateTimeToEpochUs)
  final DateTime startTime;

  List<PunchCycle> timeCard;

  TimeClock(this.isTracking, this.startTime,
      List<PunchCycle> timeCard)
      : timeCard = timeCard ?? <PunchCycle>[];

  factory TimeClock.fromJson(Map<String, dynamic> json) => _$TimeClockFromJson(json);

  Map<String, dynamic> toJson() => _$TimeClockToJson(this);

  static DateTime _dateTimeFromEpochUs(int us) =>
      us == null ? null : DateTime.fromMicrosecondsSinceEpoch(us);

  static int _dateTimeToEpochUs(DateTime dateTime) =>
      dateTime?.microsecondsSinceEpoch;
}

@JsonSerializable(includeIfNull: false)
class PunchCycle {

  @JsonKey(
      name: 'time-worked',
      fromJson: _durationFromMilliseconds,
      toJson: _durationToMilliseconds)
  Duration timeWorked;

  @JsonKey(
      name: 'start-time',
      fromJson: _dateTimeFromEpochUs,
      toJson: _dateTimeToEpochUs)
  final DateTime startTime;

  @JsonKey(
      name: 'stop-time',
      fromJson: _dateTimeFromEpochUs,
      toJson: _dateTimeToEpochUs)
  final DateTime stopTime;

  PunchCycle(this.timeWorked, this.startTime, this.stopTime);

  factory PunchCycle.fromJson(Map<String, dynamic> json) => _$PunchCycleFromJson(json);

  Map<String, dynamic> toJson() => _$PunchCycleToJson(this);

  static Duration _durationFromMilliseconds(int milliseconds) =>
      milliseconds == null ? null : Duration(milliseconds: milliseconds);

  static int _durationToMilliseconds(Duration duration) =>
      duration?.inMilliseconds;

  static DateTime _dateTimeFromEpochUs(int us) =>
      us == null ? null : DateTime.fromMicrosecondsSinceEpoch(us);

  static int _dateTimeToEpochUs(DateTime dateTime) =>
      dateTime?.microsecondsSinceEpoch;
}
