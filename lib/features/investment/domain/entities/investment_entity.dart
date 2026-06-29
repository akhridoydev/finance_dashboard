import 'package:equatable/equatable.dart';

/// Investment Entity
/// Represents investment records in the system
class InvestmentEntity extends Equatable {
  final String id;
  final String userId;
  final String investmentName;
  final String investmentType; // stocks, bonds, mutual_fund, real_estate, fd, crypto, ppf, epf, other
  final double initialAmount;
  final double? currentValue;
  final DateTime investmentDate;
  final String? broker;
  final String? accountNumber;
  final double? expectedReturn;
  final double? actualReturn;
  final DateTime? maturityDate;
  final String? description;
  final String status; // active, matured, sold, inactive
  final DateTime createdAt;
  final DateTime? updatedAt;

  const InvestmentEntity({
    required this.id,
    required this.userId,
    required this.investmentName,
    required this.investmentType,
    required this.initialAmount,
    this.currentValue,
    required this.investmentDate,
    this.broker,
    this.accountNumber,
    this.expectedReturn,
    this.actualReturn,
    this.maturityDate,
    this.description,
    this.status = 'active',
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        investmentName,
        investmentType,
        initialAmount,
        currentValue,
        investmentDate,
        broker,
        accountNumber,
        expectedReturn,
        actualReturn,
        maturityDate,
        description,
        status,
        createdAt,
        updatedAt,
      ];

  double get profitLoss => currentValue != null ? currentValue! - initialAmount : 0;

  double get returnPercentage =>
      initialAmount > 0 && currentValue != null
          ? ((currentValue! - initialAmount) / initialAmount) * 100
          : 0;

  InvestmentEntity copyWith({
    String? id,
    String? userId,
    String? investmentName,
    String? investmentType,
    double? initialAmount,
    double? currentValue,
    DateTime? investmentDate,
    String? broker,
    String? accountNumber,
    double? expectedReturn,
    double? actualReturn,
    DateTime? maturityDate,
    String? description,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return InvestmentEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      investmentName: investmentName ?? this.investmentName,
      investmentType: investmentType ?? this.investmentType,
      initialAmount: initialAmount ?? this.initialAmount,
      currentValue: currentValue ?? this.currentValue,
      investmentDate: investmentDate ?? this.investmentDate,
      broker: broker ?? this.broker,
      accountNumber: accountNumber ?? this.accountNumber,
      expectedReturn: expectedReturn ?? this.expectedReturn,
      actualReturn: actualReturn ?? this.actualReturn,
      maturityDate: maturityDate ?? this.maturityDate,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}