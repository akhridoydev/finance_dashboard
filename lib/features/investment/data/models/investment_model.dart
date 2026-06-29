import '../../domain/entities/investment_entity.dart';

/// Investment Model
/// Data Transfer Object for Appwrite integration
class InvestmentModel {
  final String $id;
  final String userId;
  final String investmentName;
  final String investmentType;
  final double initialAmount;
  final double? currentValue;
  final String investmentDate;
  final String? broker;
  final String? accountNumber;
  final double? expectedReturn;
  final double? actualReturn;
  final String? maturityDate;
  final String? description;
  final String status;
  final String createdAt;
  final String? updatedAt;

  const InvestmentModel({
    required this.$id,
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

  /// Create InvestmentModel from Appwrite document
  factory InvestmentModel.fromMap(Map<String, dynamic> map) {
    return InvestmentModel(
      $id: map['\$id'] as String? ?? map['id'] as String,
      userId: map['userId'] as String,
      investmentName: map['investmentName'] as String,
      investmentType: map['investmentType'] as String,
      initialAmount: (map['initialAmount'] is num ? (map['initialAmount'] as num).toDouble() : double.tryParse(map['initialAmount'].toString())) ?? 0.0,
      currentValue: map['currentValue'] != null ? (map['currentValue'] is num ? (map['currentValue'] as num).toDouble() : double.tryParse(map['currentValue'].toString())) : null,
      investmentDate: map['investmentDate'] as String,
      broker: map['broker'] as String?,
      accountNumber: map['accountNumber'] as String?,
      expectedReturn: map['expectedReturn'] != null ? (map['expectedReturn'] is num ? (map['expectedReturn'] as num).toDouble() : double.tryParse(map['expectedReturn'].toString())) : null,
      actualReturn: map['actualReturn'] != null ? (map['actualReturn'] is num ? (map['actualReturn'] as num).toDouble() : double.tryParse(map['actualReturn'].toString())) : null,
      maturityDate: map['maturityDate'] as String?,
      description: map['description'] as String?,
      status: map['status'] as String? ?? 'active',
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String?,
    );
  }

  /// Convert from InvestmentEntity to InvestmentModel
  factory InvestmentModel.fromEntity(InvestmentEntity entity) {
    return InvestmentModel(
      $id: entity.id.isEmpty ? 'unique()' : entity.id,
      userId: entity.userId,
      investmentName: entity.investmentName,
      investmentType: entity.investmentType,
      initialAmount: entity.initialAmount,
      currentValue: entity.currentValue,
      investmentDate: entity.investmentDate.toIso8601String(),
      broker: entity.broker,
      accountNumber: entity.accountNumber,
      expectedReturn: entity.expectedReturn,
      actualReturn: entity.actualReturn,
      maturityDate: entity.maturityDate?.toIso8601String(),
      description: entity.description,
      status: entity.status,
      createdAt: entity.createdAt.toIso8601String(),
      updatedAt: entity.updatedAt?.toIso8601String(),
    );
  }

  /// Convert to InvestmentEntity
  InvestmentEntity toEntity() {
    return InvestmentEntity(
      id: $id,
      userId: userId,
      investmentName: investmentName,
      investmentType: investmentType,
      initialAmount: initialAmount,
      currentValue: currentValue,
      investmentDate: DateTime.parse(investmentDate),
      broker: broker,
      accountNumber: accountNumber,
      expectedReturn: expectedReturn,
      actualReturn: actualReturn,
      maturityDate: maturityDate != null ? DateTime.parse(maturityDate!) : null,
      description: description,
      status: status,
      createdAt: DateTime.parse(createdAt),
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
    );
  }

  /// Convert to Map for Appwrite storage
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'investmentName': investmentName,
      'investmentType': investmentType,
      'initialAmount': initialAmount,
      if (currentValue != null) 'currentValue': currentValue,
      'investmentDate': investmentDate,
      if (broker != null) 'broker': broker,
      if (accountNumber != null) 'accountNumber': accountNumber,
      if (expectedReturn != null) 'expectedReturn': expectedReturn,
      if (actualReturn != null) 'actualReturn': actualReturn,
      if (maturityDate != null) 'maturityDate': maturityDate,
      if (description != null) 'description': description,
      'status': status,
      'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
    };
  }

  /// Create a copy with modified fields
  InvestmentModel copyWith({
    String? $id,
    String? userId,
    String? investmentName,
    String? investmentType,
    double? initialAmount,
    double? currentValue,
    String? investmentDate,
    String? broker,
    String? accountNumber,
    double? expectedReturn,
    double? actualReturn,
    String? maturityDate,
    String? description,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return InvestmentModel(
      $id: $id ?? this.$id,
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