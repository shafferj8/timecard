// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worktime.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeClock _$TimeClockFromJson(Map<String, dynamic> json) {
  return TimeClock(
    json['isTracking'] as bool,
    TimeClock._dateTimeFromEpochUs(json['start-time'] as int),
    (json['timeCard'] as List)
        ?.map((e) =>
            e == null ? null : PunchCycle.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TimeClockToJson(TimeClock instance) => <String, dynamic>{
      'isTracking': instance.isTracking,
      'start-time': TimeClock._dateTimeToEpochUs(instance.startTime),
      'timeCard': instance.timeCard,
    };

PunchCycle _$PunchCycleFromJson(Map<String, dynamic> json) {
  return PunchCycle(
    PunchCycle._durationFromMilliseconds(json['time-worked'] as int),
    PunchCycle._dateTimeFromEpochUs(json['start-time'] as int),
    PunchCycle._dateTimeFromEpochUs(json['stop-time'] as int),
  );
}

Map<String, dynamic> _$PunchCycleToJson(PunchCycle instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'time-worked', PunchCycle._durationToMilliseconds(instance.timeWorked));
  writeNotNull('start-time', PunchCycle._dateTimeToEpochUs(instance.startTime));
  writeNotNull('stop-time', PunchCycle._dateTimeToEpochUs(instance.stopTime));
  return val;
}
