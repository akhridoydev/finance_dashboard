import 'package:dartz/dartz.dart';
import 'package:appwrite/appwrite.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/appwrite_client.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/expense_entity.dart';
import '../../domain/repositories/expense_repository.dart';
import '../models/expense_model.dart';

/// Expense Repository Implementation
/// Handles all expense data operations using Appwrite
class ExpenseRepositoryImpl implements ExpenseRepository {
  final AppwriteClient _appwriteClient;

  ExpenseRepositoryImpl(this._appwriteClient);

  @override
  Future<Either<Failure, ExpenseEntity>> createExpense(ExpenseEntity expense) async {
    try {
      final model = ExpenseModel.fromEntity(expense);

      final document = await _appwriteClient.databases.createDocument(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionTransactions,
        documentId: ID.unique(),
        data: model.toMap()
          ..addAll({
            'type': AppConstants.txnExpense,
            'updatedAt': DateTime.now().toIso8601String(),
          }),
      );

      final createdModel = ExpenseModel.fromMap(document.data);
      return Right(createdModel.toEntity());
    } on AppwriteException catch (e) {
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to create expense',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ExpenseEntity>>> getExpenses({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
    String? category,
    int? limit,
    int? offset,
  }) async {
    try {
      List<String> queries = [
        Query.equal('userId', userId),
        Query.equal('type', AppConstants.txnExpense),
        Query.orderDesc('transactionDate'),
      ];

      if (startDate != null) {
        queries.add(Query.greaterThan('transactionDate', startDate.toIso8601String()));
      }

      if (endDate != null) {
        queries.add(Query.lessThan('transactionDate', endDate.toIso8601String()));
      }

      if (category != null) {
        queries.add(Query.equal('category', category));
      }

      if (limit != null) {
        queries.add(Query.limit(limit));
      }

      if (offset != null) {
        queries.add(Query.offset(offset));
      }

      final response = await _appwriteClient.databases.listDocuments(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionTransactions,
        queries: queries,
      );

      final expenses = response.documents.map((doc) {
        return ExpenseModel.fromMap(doc.data).toEntity();
      }).toList();

      return Right(expenses);
    } on AppwriteException catch (e) {
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to fetch expenses',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExpenseEntity>> getExpenseById(String id) async {
    try {
      final document = await _appwriteClient.databases.getDocument(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionTransactions,
        documentId: id,
      );

      final expense = ExpenseModel.fromMap(document.data).toEntity();
      return Right(expense);
    } on AppwriteException catch (e) {
      if (e.code == 404) {
        return Left(const NotFoundFailure(message: 'Expense not found'));
      }
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to fetch expense',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExpenseEntity>> updateExpense(ExpenseEntity expense) async {
    try {
      final model = ExpenseModel.fromEntity(expense);

      final document = await _appwriteClient.databases.updateDocument(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionTransactions,
        documentId: expense.id,
        data: model.toMap()
          ..addAll({
            'updatedAt': DateTime.now().toIso8601String(),
          }),
      );

      final updatedModel = ExpenseModel.fromMap(document.data);
      return Right(updatedModel.toEntity());
    } on AppwriteException catch (e) {
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to update expense',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense(String id) async {
    try {
      await _appwriteClient.databases.deleteDocument(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionTransactions,
        documentId: id,
      );

      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to delete expense',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getTotalExpenses({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final result = await getExpenses(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
      );

      return result.fold(
        (failure) => Left(failure),
        (expenses) => Right(
          expenses.fold<double>(
            0.0,
            (total, expense) => total + expense.amount,
          ),
        ),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, double>>> getExpensesByCategory({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final result = await getExpenses(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
      );

      return result.fold(
        (failure) => Left(failure),
        (expenses) {
          final categoryMap = <String, double>{};
          for (final expense in expenses) {
            categoryMap[expense.category] =
              (categoryMap[expense.category] ?? 0.0) + expense.amount;
          }
          return Right(categoryMap);
        },
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getMonthlyExpenseTrends({
    required String userId,
    int? months,
  }) async {
    try {
      final startDate = DateTime.now().subtract(
        Duration(days: (months ?? 12) * 30),
      );

      final result = await getExpenses(
        userId: userId,
        startDate: startDate,
      );

      return result.fold(
        (failure) => Left(failure),
        (expenses) {
          final monthlyData = <String, List<ExpenseEntity>>{};
          for (final expense in expenses) {
            final monthKey = '${expense.transactionDate.year}-${expense.transactionDate.month.toString().padLeft(2, '0')}';
            monthlyData.putIfAbsent(monthKey, () => []).add(expense);
          }

          final trends = monthlyData.entries.map((entry) {
            final total = entry.value.fold<double>(
              0.0,
              (sum, expense) => sum + expense.amount,
            );
            return {
              'month': entry.key,
              'total': total,
              'count': entry.value.length,
            };
          }).toList();

          return Right(trends);
        },
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ExpenseEntity>>> getExpensesByVendor({
    required String userId,
    required String vendorId,
  }) async {
    try {
      final response = await _appwriteClient.databases.listDocuments(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionTransactions,
        queries: [
          Query.equal('userId', userId),
          Query.equal('type', AppConstants.txnExpense),
          Query.equal('vendorId', vendorId),
          Query.orderDesc('transactionDate'),
        ],
      );

      final expenses = response.documents.map((doc) {
        return ExpenseModel.fromMap(doc.data).toEntity();
      }).toList();

      return Right(expenses);
    } on AppwriteException catch (e) {
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to fetch expenses by vendor',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExpenseEntity>> approveExpense({
    required String expenseId,
    required String approvedBy,
  }) async {
    try {
      final document = await _appwriteClient.databases.updateDocument(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionTransactions,
        documentId: expenseId,
        data: {
          'status': 'approved',
          'approvedBy': approvedBy,
          'approvedAt': DateTime.now().toIso8601String(),
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );

      final expense = ExpenseModel.fromMap(document.data).toEntity();
      return Right(expense);
    } on AppwriteException catch (e) {
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to approve expense',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExpenseEntity>> rejectExpense({
    required String expenseId,
    required String rejectedBy,
    required String reason,
  }) async {
    try {
      final document = await _appwriteClient.databases.updateDocument(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionTransactions,
        documentId: expenseId,
        data: {
          'status': 'rejected',
          'approvedBy': rejectedBy,
          'description': reason,
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );

      final expense = ExpenseModel.fromMap(document.data).toEntity();
      return Right(expense);
    } on AppwriteException catch (e) {
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to reject expense',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ExpenseEntity>>> searchExpense({
    required String userId,
    required String query,
  }) async {
    try {
      final result = await getExpenses(userId: userId);

      return result.fold(
        (failure) => Left(failure),
        (expenses) {
          final searchLower = query.toLowerCase();
          final filtered = expenses.where((expense) {
            return expense.description?.toLowerCase().contains(searchLower) == true ||
                   expense.category.toLowerCase().contains(searchLower) ||
                   (expense.reference?.toLowerCase().contains(searchLower) == true) ||
                   (expense.invoiceId?.toLowerCase().contains(searchLower) == true);
          }).toList();

          return Right(filtered);
        },
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}