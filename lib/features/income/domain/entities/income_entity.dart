import 'package:equatable/equatable.dart';

/// Income Entity
/// Represents income transactions in the system
class IncomeEntity extends Equatable {
  final String id;
  final String userId;
  final String? clientId;
  final double amount;
  final String category;
  final DateTime transactionDate;
  final String? description;
  final String? invoiceId;
  final String? paymentMethod;
  final String? reference;
  final bool isRecurring;
  final String? recurringPeriod;
  final DateTime? recurringEndDate;
  final String status; // pending, completed, cancelled
  final DateTime createdAt;
  final DateTime? updatedAt;

  const IncomeEntity({
    required this.id,
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

  @override
  List<Object?> get props => [
        id,
        userId,
        clientId,
        amount,
        category,
        transactionDate,
        description,
        invoiceId,
        paymentMethod,
        reference,
        isRecurring,
        recurringPeriod,
        recurringEndDate,
        status,
        createdAt,
        updatedAt,
      ];

  IncomeEntity copyWith({
    String? id,
    String? userId,
    String? clientId,
    double? amount,
    String? category,
    DateTime? transactionDate,
    String? description,
    String? invoiceId,
    String? paymentMethod,
    String? reference,
    bool? isRecurring,
    String? recurringPeriod,
    DateTime? recurringEndDate,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return IncomeEntity(
      id: id ?? this.id,
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