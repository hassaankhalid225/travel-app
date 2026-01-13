import 'package:equatable/equatable.dart';

/// Trip entity representing a complete travel journey
class Trip extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final String? coverImage;
  final String destination;
  final DateTime startDate;
  final DateTime? endDate;
  final String status; // 'planning', 'ongoing', 'completed'
  final double? totalDistance; // in kilometers
  final double? totalExpense;
  final String? currency;
  final List<String>? tags;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Trip({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.coverImage,
    required this.destination,
    required this.startDate,
    this.endDate,
    required this.status,
    this.totalDistance,
    this.totalExpense,
    this.currency,
    this.tags,
    this.metadata,
    required this.createdAt,
    this.updatedAt,
  });

  Trip copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? coverImage,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    double? totalDistance,
    double? totalExpense,
    String? currency,
    List<String>? tags,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Trip(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      coverImage: coverImage ?? this.coverImage,
      destination: destination ?? this.destination,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      totalDistance: totalDistance ?? this.totalDistance,
      totalExpense: totalExpense ?? this.totalExpense,
      currency: currency ?? this.currency,
      tags: tags ?? this.tags,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isOngoing => status == 'ongoing';
  bool get isCompleted => status == 'completed';
  bool get isPlanning => status == 'planning';

  int get durationInDays {
    if (endDate == null) return 0;
    return endDate!.difference(startDate).inDays + 1;
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        description,
        coverImage,
        destination,
        startDate,
        endDate,
        status,
        totalDistance,
        totalExpense,
        currency,
        tags,
        metadata,
        createdAt,
        updatedAt,
      ];
}
