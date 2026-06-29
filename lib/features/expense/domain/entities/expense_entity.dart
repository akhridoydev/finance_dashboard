import 'package:equatable/equatable.dart';

/// Expense Entity
/// Represents expense/cost transactions in the system
class ExpenseEntity extends Equatable {
  final String id;
  final String userId;
  final String? vendorId;
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
  final String status; // pending, approved, rejected
  final String? approvedBy;
  final DateTime? approvedAt;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ExpenseEntity({
    required this.id,
    required this.userId,
    this.vendorId,
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
    this.status = 'pending',
    this.approvedBy,
    this.approvedAt,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        vendorId,
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
        approvedBy,
        approvedAt,
        createdAt,
        updatedAt,
      ];

  ExpenseEntity copyWith({
    String? id,
    String? userId,
    String? vendorId,
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
    String? approvedBy,
    DateTime? approvedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ExpenseEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      vendorId: vendorId ?? this.vendorId,
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
      approvedBy: approvedBy ?? this.approvedBy,
      approvedAt: approvedAt ?? this.approvedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}