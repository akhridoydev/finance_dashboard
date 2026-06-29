import '../../domain/entities/income_entity.dart';

/// Income Model
/// Data Transfer Object for Appwrite integration
class IncomeModel {
  final String $id;
  final String userId;
  final String? clientId;
  final double amount;
  final String category;
  final String transactionDate;
  final String? description;
  final String? invoiceId;
  final String? paymentMethod;
  final String? reference;
  final bool isRecurring;
  final String? recurringPeriod;
  final String? recurringEndDate;
  final String status;
  final String createdAt;
  final String? updatedAt;

  const IncomeModel({
    required this.$id,
    required this.userId,
    this.clientId,
    required this.amount,
    required this.category,
    required this.transactionDate,
    this.description,
    this.invoiceId,
    this.paymentMethod,
    this.reference,
    this.isRecurring = false,
    this.recurringPeriod,
    this.recurringEndDate,
    this.status = 'completed',
    required this.createdAt,
    this.updatedAt,
  });

  /// Create IncomeModel from Appwrite document
  factory IncomeModel.fromMap(Map<String, dynamic> map) {
    return IncomeModel(
      $id: map['\$id'] as String? ?? map['id'] as String,
      userId: map['userId'] as String,
      clientId: map['clientId'] as String?,
      amount: (map['amount'] is num ? (map['amount'] as num).toDouble() : double.tryParse(map['amount'].toString())) ?? 0.0,
      category: map['category'] as String,
      transactionDate: map['transactionDate'] as String,
      description: map['description'] as String?,
      invoiceId: map['invoiceId'] as String?,
      paymentMethod: map['paymentMethod'] as String?,
      reference: map['reference'] as String?,
      isRecurring: map['isRecurring'] as bool? ?? false,
      recurringPeriod: map['recurringPeriod'] as String?,
      recurringEndDate: map['recurringEndDate'] as String?,
      status: map['status'] as String? ?? 'completed',
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String?,
    );
  }

  /// Convert from IncomeEntity to IncomeModel
  factory IncomeModel.fromEntity(IncomeEntity entity) {
    return IncomeModel(
      $id: entity.id.isEmpty ? 'unique()' : entity.id,
      userId: entity.userId,
      clientId: entity.clientId,
      amount: entity.amount,
      category: entity.category,
      transactionDate: entity.transactionDate.toIso8601String(),
      description: entity.description,
      invoiceId: entity.invoiceId,
      paymentMethod: entity.paymentMethod,
      reference: entity.reference,
      isRecurring: entity.isRecurring,
      recurringPeriod: entity.recurringPeriod,
      recurringEndDate: entity.recurringEndDate?.toIso8601String(),
      status: entity.status,
      createdAt: entity.createdAt.toIso8601String(),
      updatedAt: entity.updatedAt?.toIso8601String(),
    );
  }

  /// Convert to IncomeEntity
  IncomeEntity toEntity() {
    return IncomeEntity(
      id: $id,
      userId: userId,
      clientId: clientId,
      amount: amount,
      category: category,
      transactionDate: DateTime.parse(transactionDate),
      description: description,
      invoiceId: invoiceId,
      paymentMethod: paymentMethod,
      reference: reference,
      isRecurring: isRecurring,
      recurringPeriod: recurringPeriod,
      recurringEndDate: recurringEndDate != null ? DateTime.parse(recurringEndDate!) : null,
      status: status,
      createdAt: DateTime.parse(createdAt),
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
    );
  }

  /// Convert to Map for Appwrite storage
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      if (clientId != null) 'clientId': clientId,
      'amount': amount,
      'category': category,
      'transactionDate': transactionDate,
      if (description != null) 'description': description,
      if (invoiceId != null) 'invoiceId': invoiceId,
      if (paymentMethod != null) 'paymentMethod': paymentMethod,
      if (reference != null) 'reference': reference,
      'isRecurring': isRecurring,
      if (recurringPeriod != null) 'recurringPeriod': recurringPeriod,
      if (recurringEndDate != null) 'recurringEndDate': recurringEndDate,
      'status': status,
      'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
    };
  }

  /// Create a copy with modified fields
  IncomeModel copyWith({
    String? $id,
    String? userId,
    String? clientId,
    double? amount,
    String? category,
    String? transactionDate,
    String? description,
    String? invoiceId,
    String? paymentMethod,
    String? reference,
    bool? isRecurring,
    String? recurringPeriod,
    String? recurringEndDate,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return IncomeModel(
      $id: $id ?? this.$id,
      userId: userId ?? this.userId,
      clientId: clientId ?? this.clientId,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      transactionDate: transactionDate ?? this.transactionDate,
      description: description ?? this.description,
      invoiceId: invoiceId ?? this.invoiceId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      reference: reference ?? this.reference,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringPeriod: recurringPeriod ?? this.recurringPeriod,
      recurringEndDate: recurringEndDate ?? this.recurringEndDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}