import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/income_entity.dart';

/// Income Repository Interface
/// Defines the contract for income data operations
abstract class IncomeRepository {
  /// Create a new income record
  Future<Either<Failure, IncomeEntity>> createIncome(IncomeEntity income);

  /// Get all income records for a user with optional filters
  Future<Either<Failure, List<IncomeEntity>>> getIncomes({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
    String? category,
    int? limit,
    int? offset,
  });

  /// Get a single income record by ID
  Future<Either<Failure, IncomeEntity>> getIncomeById(String id);

  /// Update an existing income record
  Future<Either<Failure, IncomeEntity>> updateIncome(IncomeEntity income);

  /// Delete an income record
  Future<Either<Failure, void>> deleteIncome(String id);

  /// Get total income amount for a user within a date range
  Future<Either<Failure, double>> getTotalIncome({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get income breakdown by category
  Future<Either<Failure, Map<String, double>>> getIncomeByCategory({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get monthly income trends
  Future<Either<Failure, List<Map<String, dynamic>>>> getMonthlyIncomeTrends({
    required String userId,
    int? months,
  });

  /// Get income from a specific client
  Future<Either<Failure, List<IncomeEntity>>> getIncomeByClient({
    required String userId,
    required String clientId,
  });

  /// Search income records
  Future<Either<Failure, List<IncomeEntity>>> searchIncome({
    required String userId,
    required String query,
  });
}