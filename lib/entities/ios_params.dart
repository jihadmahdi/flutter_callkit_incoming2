import 'package:json_annotation/json_annotation.dart';

part 'ios_params.g.dart';

/// Object config for iOS.
@JsonSerializable(explicitToJson: true)
class IOSParams {
  /// App's Icon. using for display inside Callkit(iOS)
  final String? iconName;

  /// Type handle call `generic`, `number`, `email`
  final String? handleType;
  final bool? supportsVideo;
  final int? maximumCallGroups;
  final int? maximumCallsPerCallGroup;
  final String? audioSessionMode;
  final bool? audioSessionActive;
  final double? audioSessionPreferredSampleRate;
  final double? audioSessionPreferredIOBufferDuration;
  final bool? configureAudioSession;
  final bool? supportsDTMF;
  final bool? supportsHolding;
  final bool? supportsGrouping;
  final bool? supportsUngrouping;

  /// Whether to include this call in the iOS Phone app's Recents list.
  /// Set to false when CallKit is used purely as a UI alert (not a real voice call).
  final bool? includesCallsInRecents;

  /// Add file to root project xcode /ios/Runner/Ringtone.caf and Copy Bundle Resources(Build Phases) -> value: "Ringtone.caf"
  final String? ringtonePath;

  const IOSParams({
    this.iconName,
    this.handleType,
    this.supportsVideo,
    this.maximumCallGroups,
    this.maximumCallsPerCallGroup,
    this.audioSessionMode,
    this.audioSessionActive,
    this.audioSessionPreferredSampleRate,
    this.audioSessionPreferredIOBufferDuration,
    this.configureAudioSession,
    this.supportsDTMF,
    this.supportsHolding,
    this.supportsGrouping,
    this.supportsUngrouping,
    this.includesCallsInRecents,
    this.ringtonePath,
  });

  factory IOSParams.fromJson(Map<String, dynamic> json) =>
      _$IOSParamsFromJson(json);

  Map<String, dynamic> toJson() => _$IOSParamsToJson(this);
}
