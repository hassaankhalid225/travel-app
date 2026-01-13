import 'package:equatable/equatable.dart';

/// Media entity for photos and videos
class Media extends Equatable {
  final String id;
  final String tripId;
  final String? journalEntryId;
  final String userId;
  final String type; // 'photo', 'video'
  final String localPath;
  final String? remoteUrl;
  final String? thumbnailPath;
  final String? thumbnailUrl;
  final DateTime capturedAt;
  final double? latitude;
  final double? longitude;
  final String? locationName;
  final int? width;
  final int? height;
  final int? duration; // For videos in seconds
  final int? fileSize; // In bytes
  final String? caption;
  final List<String>? tags;
  final bool isSynced;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Media({
    required this.id,
    required this.tripId,
    this.journalEntryId,
    required this.userId,
    required this.type,
    required this.localPath,
    this.remoteUrl,
    this.thumbnailPath,
    this.thumbnailUrl,
    required this.capturedAt,
    this.latitude,
    this.longitude,
    this.locationName,
    this.width,
    this.height,
    this.duration,
    this.fileSize,
    this.caption,
    this.tags,
    required this.isSynced,
    this.metadata,
    required this.createdAt,
    this.updatedAt,
  });

  Media copyWith({
    String? id,
    String? tripId,
    String? journalEntryId,
    String? userId,
    String? type,
    String? localPath,
    String? remoteUrl,
    String? thumbnailPath,
    String? thumbnailUrl,
    DateTime? capturedAt,
    double? latitude,
    double? longitude,
    String? locationName,
    int? width,
    int? height,
    int? duration,
    int? fileSize,
    String? caption,
    List<String>? tags,
    bool? isSynced,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Media(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      journalEntryId: journalEntryId ?? this.journalEntryId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      localPath: localPath ?? this.localPath,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      capturedAt: capturedAt ?? this.capturedAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationName: locationName ?? this.locationName,
      width: width ?? this.width,
      height: height ?? this.height,
      duration: duration ?? this.duration,
      fileSize: fileSize ?? this.fileSize,
      caption: caption ?? this.caption,
      tags: tags ?? this.tags,
      isSynced: isSynced ?? this.isSynced,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isPhoto => type == 'photo';
  bool get isVideo => type == 'video';
  bool get hasLocation => latitude != null && longitude != null;
  bool get hasRemoteUrl => remoteUrl != null;

  String get fileSizeFormatted {
    if (fileSize == null) return 'Unknown';
    final kb = fileSize! / 1024;
    if (kb < 1024) return '${kb.toStringAsFixed(1)} KB';
    final mb = kb / 1024;
    return '${mb.toStringAsFixed(1)} MB';
  }

  @override
  List<Object?> get props => [
        id,
        tripId,
        journalEntryId,
        userId,
        type,
        localPath,
        remoteUrl,
        thumbnailPath,
        thumbnailUrl,
        capturedAt,
        latitude,
        longitude,
        locationName,
        width,
        height,
        duration,
        fileSize,
        caption,
        tags,
        isSynced,
        metadata,
        createdAt,
        updatedAt,
      ];
}
