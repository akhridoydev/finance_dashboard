import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/investment_entity.dart';

/// Investment Repository Interface
/// Defines the contract for investment data operations
abstract class InvestmentRepository {
  /// Create a new investment record
  Future<Either<Failure, InvestmentEntity>> createInvestment(InvestmentEntity investment);

  /// Get all investment records for a user with optional filters
  Future<Either<Failure, List<InvestmentEntity>>> getInvestments({
    required String userId,
    String? investmentType,
    String? status,
    int? limit,
    int? offset,
  });

  /// Get a single investment record by ID
  Future<Either<Failure, InvestmentEntity>> getInvestmentById(String id);

  /// Update an existing investment record
  Future<Either<Failure, InvestmentEntity>> updateInvestment(InvestmentEntity investment);

  /// Delete an investment record
  Future<Either<Failure, void>> deleteInvestment(String id);

  /// Update current value of an investment
  Future<Either<Failure, InvestmentEntity>> updateInvestmentValue({
    required String investmentId,
    required double currentValue,
  });

  /// Get total investment value for a user
  Future<Either<Failure, double>> getTotalInvestmentValue({
    required String userId,
  });

  /// Get investment breakdown by type
  Future<Either<Failure, Map<String, double>>> getInvestmentsByType({
    required String userId,
  });

  /// Get active investments
  Future<Either<Failure, List<InvestmentEntity>>> getActiveInvestments({
    required String userId,
  });

  /// Get matured investments
  Future<Either<Failure, List<InvestmentEntity>>> getMaturedInvestments({
    required String userId,
  });

  /// Mark investment as sold
  Future<Either<Failure, InvestmentEntity>> markInvestmentAsSold({
    required String investmentId,
    required double sellingPrice,
    required DateTime soldDate,
  });

  /// Get investment performance metrics
  Future<Either<Failure, Map<String, dynamic>>> getInvestmentPerformance({
    required String userId,
  });

  /// Search investment records
  Future<Either<Failure, List<InvestmentEntity>>> searchInvestments({
    required String userId,
    required String query,
  });
}