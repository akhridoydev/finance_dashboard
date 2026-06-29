import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/expense_entity.dart';

/// Expense Repository Interface
/// Defines the contract for expense data operations
abstract class ExpenseRepository {
  /// Create a new expense record
  Future<Either<Failure, ExpenseEntity>> createExpense(ExpenseEntity expense);

  /// Get all expense records for a user with optional filters
  Future<Either<Failure, List<ExpenseEntity>>> getExpenses({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
    String? category,
    int? limit,
    int? offset,
  });

  /// Get a single expense record by ID
  Future<Either<Failure, ExpenseEntity>> getExpenseById(String id);

  /// Update an existing expense record
  Future<Either<Failure, ExpenseEntity>> updateExpense(ExpenseEntity expense);

  /// Delete an expense record
  Future<Either<Failure, void>> deleteExpense(String id);

  /// Get total expense amount for a user within a date range
  Future<Either<Failure, double>> getTotalExpenses({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get expense breakdown by category
  Future<Either<Failure, Map<String, double>>> getExpensesByCategory({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get monthly expense trends
  Future<Either<Failure, List<Map<String, dynamic>>>> getMonthlyExpenseTrends({
    required String userId,
    int? months,
  });

  /// Get expenses from a specific vendor
  Future<Either<Failure, List<ExpenseEntity>>> getExpensesByVendor({
    required String userId,
    required String vendorId,
  });

  /// Approve an expense
  Future<Either<Failure, ExpenseEntity>> approveExpense({
    required String expenseId,
    required String approvedBy,
  });

  /// Reject an expense
  Future<Either<Failure, ExpenseEntity>> rejectExpense({
    required String expenseId,
    required String rejectedBy,
    required String reason,
  });

  /// Search expense records
  Future<Either<Failure, List<ExpenseEntity>>> searchExpense({
    required String userId,
    required String query,
  });
}