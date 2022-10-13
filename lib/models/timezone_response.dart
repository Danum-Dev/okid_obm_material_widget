// To parse this JSON data, do
//
//     final timezoneResponse = timezoneResponseFromJson(jsonString);

import 'dart:convert';

TimezoneResponse timezoneResponseFromJson(String str) =>
    TimezoneResponse.fromJson(json.decode(str));

String timezoneResponseToJson(TimezoneResponse data) =>
    json.encode(data.toJson());

class TimezoneResponse {
  TimezoneResponse({
    this.timeZone,
    this.currentLocalTime,
    this.currentUtcOffset,
    this.standardUtcOffset,
    this.hasDayLightSaving,
    this.isDayLightSavingActive,
    this.dstInterval,
  });

  String? timeZone;
  DateTime? currentLocalTime;
  UtcOffset? currentUtcOffset;
  UtcOffset? standardUtcOffset;
  bool? hasDayLightSaving;
  bool? isDayLightSavingActive;
  dynamic dstInterval;

  factory TimezoneResponse.fromJson(Map<String, dynamic> json) =>
      TimezoneResponse(
        timeZone: json["timeZone"],
        currentLocalTime: json["currentLocalTime"] == null
            ? null
            : DateTime.parse(json["currentLocalTime"]),
        currentUtcOffset: json["currentUtcOffset"] == null
            ? null
            : UtcOffset.fromJson(json["currentUtcOffset"]),
        standardUtcOffset: json["standardUtcOffset"] == null
            ? null
            : UtcOffset.fromJson(json["standardUtcOffset"]),
        hasDayLightSaving: json["hasDayLightSaving"],
        isDayLightSavingActive: json["isDayLightSavingActive"],
        dstInterval: json["dstInterval"],
      );

  Map<String, dynamic> toJson() => {
        "timeZone": timeZone,
        "currentLocalTime": currentLocalTime == null
            ? null
            : currentLocalTime!.toIso8601String(),
        "currentUtcOffset":
            currentUtcOffset == null ? null : currentUtcOffset!.toJson(),
        "standardUtcOffset":
            standardUtcOffset == null ? null : standardUtcOffset!.toJson(),
        "hasDayLightSaving": hasDayLightSaving,
        "isDayLightSavingActive": isDayLightSavingActive,
        "dstInterval": dstInterval,
      };
}

class UtcOffset {
  UtcOffset({
    this.seconds,
    this.milliseconds,
    this.ticks,
    this.nanoseconds,
  });

  int? seconds;
  int? milliseconds;
  int? ticks;
  int? nanoseconds;

  factory UtcOffset.fromJson(Map<String, dynamic> json) => UtcOffset(
        seconds: json["seconds"],
        milliseconds: json["milliseconds"],
        ticks: json["ticks"],
        nanoseconds: json["nanoseconds"],
      );

  Map<String, dynamic> toJson() => {
        "seconds": seconds,
        "milliseconds": milliseconds,
        "ticks": ticks,
        "nanoseconds": nanoseconds,
      };
}
