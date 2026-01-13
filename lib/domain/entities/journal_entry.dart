import 'package:equatable/equatable.dart';

/// Journal entry entity representing a single travel memory/experience
class JournalEntry extends Equatable {
  final String id;
  final String tripId;
  final String userId;
  final String? title;
  final String content; // AI-generated or user-written content
  final String? rawVoiceText; // Original speech-to-text output
  final String? voiceAudioPath; // Path to voice recording
  final DateTime timestamp;
  final double? latitude;
  final double? longitude;
  final String? locationName;
  final String? placeName; // Restaurant, landmark, etc.
  final List<String>? mediaUrls; // Photos and videos
  final List<String>? tags;
  final String? mood; // 'happy', 'excited', 'relaxed', etc.
  final int? rating; // 1-5 stars
  final bool isAiGenerated;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const JournalEntry({
    required this.id,
    required this.tripId,
    required this.userId,
    this.title,
    required this.content,
    this.rawVoiceText,
    this.voiceAudioPath,
    required this.timestamp,
    this.latitude,
    this.longitude,
    this.locationName,
    this.placeName,
    this.mediaUrls,
    this.tags,
    this.mood,
    this.rating,
    required this.isAiGenerated,
    this.metadata,
    required this.createdAt,
    this.updatedAt,
  });

  JournalEntry copyWith({
    String? id,
    String? tripId,
    String? userId,
    String? title,
    String? content,
    String? rawVoiceText,
    String? voiceAudioPath,
    DateTime? timestamp,
    double? latitude,
    double? longitude,
    String? locationName,
    String? placeName,
    List<String>? mediaUrls,
    List<String>? tags,
    String? mood,
    int? rating,
    bool? isAiGenerated,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return JournalEntry(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      rawVoiceText: rawVoiceText ?? this.rawVoiceText,
      voiceAudioPath: voiceAudioPath ?? this.voiceAudioPath,
      timestamp: timestamp ?? this.timestamp,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationName: locationName ?? this.locationName,
      placeName: placeName ?? this.placeName,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      tags: tags ?? this.tags,
      mood: mood ?? this.mood,
      rating: rating ?? this.rating,
      isAiGenerated: isAiGenerated ?? this.isAiGenerated,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get hasLocation => latitude != null && longitude != null;
  bool get hasMedia => mediaUrls != null && mediaUrls!.isNotEmpty;
  bool get hasVoice => voiceAudioPath != null;
  int get mediaCount => mediaUrls?.length ?? 0;

  @override
  List<Object?> get props => [
        id,
        tripId,
        userId,
        title,
        content,
        rawVoiceText,
        voiceAudioPath,
        timestamp,
        latitude,
        longitude,
        locationName,
        placeName,
        mediaUrls,
        tags,
        mood,
        rating,
        isAiGenerated,
        metadata,
        createdAt,
        updatedAt,
      ];
}
