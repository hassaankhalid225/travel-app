import 'package:equatable/equatable.dart';

/// Expense entity for tracking travel costs
class Expense extends Equatable {
  final String id;
  final String tripId;
  final String userId;
  final String category; // From AppConstants.expenseCategories
  final double amount;
  final String currency;
  final String? title;
  final String? description;
  final String? receiptImage;
  final DateTime date;
  final double? latitude;
  final double? longitude;
  final String? locationName;
  final String? paymentMethod; // 'cash', 'card', 'digital'
  final List<String>? tags;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Expense({
    required this.id,
    required this.tripId,
    required this.userId,
    required this.category,
    required this.amount,
    required this.currency,
    this.title,
    this.description,
    this.receiptImage,
    required this.date,
    this.latitude,
    this.longitude,
    this.locationName,
    this.paymentMethod,
    this.tags,
    this.metadata,
    required this.createdAt,
    this.updatedAt,
  });

  Expense copyWith({
    String? id,
    String? tripId,
    String? userId,
    String? category,
    double? amount,
    String? currency,
    String? title,
    String? description,
    String? receiptImage,
    DateTime? date,
    double? latitude,
    double? longitude,
    String? locationName,
    String? paymentMethod,
    List<String>? tags,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Expense(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      userId: userId ?? this.userId,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      title: title ?? this.title,
      description: description ?? this.description,
      receiptImage: receiptImage ?? this.receiptImage,
      date: date ?? this.date,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationName: locationName ?? this.locationName,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      tags: tags ?? this.tags,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get hasLocation => latitude != null && longitude != null;
  bool get hasReceipt => receiptImage != null;

  @override
  List<Object?> get props => [
        id,
        tripId,
        userId,
        category,
        amount,
        currency,
        title,
        description,
        receiptImage,
        date,
        latitude,
        longitude,
        locationName,
        paymentMethod,
        tags,
        metadata,
        createdAt,
        updatedAt,
      ];
}
