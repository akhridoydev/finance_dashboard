import 'package:dartz/dartz.dart';
import 'package:appwrite/appwrite.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/appwrite_client.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/income_entity.dart';
import '../../domain/repositories/income_repository.dart';
import '../models/income_model.dart';

/// Income Repository Implementation
/// Handles all income data operations using Appwrite
class IncomeRepositoryImpl implements IncomeRepository {
  final AppwriteClient _appwriteClient;

  IncomeRepositoryImpl(this._appwriteClient);

  @override
  Future<Either<Failure, IncomeEntity>> createIncome(IncomeEntity income) async {
    try {
      final model = IncomeModel.fromEntity(income);

      final document = await _appwriteClient.databases.createDocument(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionTransactions,
        documentId: ID.unique(),
        data: model.toMap()
          ..addAll({
            'type': AppConstants.txnIncome,
            'updatedAt': DateTime.now().toIso8601String(),
          }),
      );

      final createdModel = IncomeModel.fromMap(document.data);
      return Right(createdModel.toEntity());
    } on AppwriteException catch (e) {
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to create income',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<IncomeEntity>>> getIncomes({
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
        Query.equal('type', AppConstants.txnIncome),
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

      final incomes = response.documents.map((doc) {
        return IncomeModel.fromMap(doc.data).toEntity();
      }).toList();

      return Right(incomes);
    } on AppwriteException catch (e) {
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to fetch incomes',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, IncomeEntity>> getIncomeById(String id) async {
    try {
      final document = await _appwriteClient.databases.getDocument(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionTransactions,
        documentId: id,
      );

      final income = IncomeModel.fromMap(document.data).toEntity();
      return Right(income);
    } on AppwriteException catch (e) {
      if (e.code == 404) {
        return Left(const NotFoundFailure(message: 'Income not found'));
      }
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to fetch income',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, IncomeEntity>> updateIncome(IncomeEntity income) async {
    try {
      final model = IncomeModel.fromEntity(income);

      final document = await _appwriteClient.databases.updateDocument(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionTransactions,
        documentId: income.id,
        data: model.toMap()
          ..addAll({
            'updatedAt': DateTime.now().toIso8601String(),
          }),
      );

      final updatedModel = IncomeModel.fromMap(document.data);
      return Right(updatedModel.toEntity());
    } on AppwriteException catch (e) {
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to update income',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteIncome(String id) async {
    try {
      await _appwriteClient.databases.deleteDocument(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionTransactions,
        documentId: id,
      );

      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to delete income',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getTotalIncome({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final result = await getIncomes(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
      );

      return result.fold(
        (failure) => Left(failure),
        (incomes) => Right(
          incomes.fold<double>(
            0.0,
            (total, income) => total + income.amount,
          ),
        ),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, double>>> getIncomeByCategory({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final result = await getIncomes(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
      );

      return result.fold(
        (failure) => Left(failure),
        (incomes) {
          final categoryMap = <String, double>{};
          for (final income in incomes) {
            categoryMap[income.category] =
              (categoryMap[income.category] ?? 0.0) + income.amount;
          }
          return Right(categoryMap);
        },
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getMonthlyIncomeTrends({
    required String userId,
    int? months,
  }) async {
    try {
      // Calculate start date based on months parameter
      final startDate = DateTime.now().subtract(
        Duration(days: (months ?? 12) * 30),
      );

      final result = await getIncomes(
        userId: userId,
        startDate: startDate,
      );

      return result.fold(
        (failure) => Left(failure),
        (incomes) {
          // Group by month
          final monthlyData = <String, List<IncomeEntity>>{};
          for (final income in incomes) {
            final monthKey = '${income.transactionDate.year}-${income.transactionDate.month.toString().padLeft(2, '0')}';
            monthlyData.putIfAbsent(monthKey, () => []).add(income);
          }

          // Convert to list of maps
          final trends = monthlyData.entries.map((entry) {
            final total = entry.value.fold<double>(
              0.0,
              (sum, income) => sum + income.amount,
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
  Future<Either<Failure, List<IncomeEntity>>> getIncomeByClient({
    required String userId,
    required String clientId,
  }) async {
    try {
      final response = await _appwriteClient.databases.listDocuments(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionTransactions,
        queries: [
          Query.equal('userId', userId),
          Query.equal('type', AppConstants.txnIncome),
          Query.equal('clientId', clientId),
          Query.orderDesc('transactionDate'),
        ],
      );

      final incomes = response.documents.map((doc) {
        return IncomeModel.fromMap(doc.data).toEntity();
      }).toList();

      return Right(incomes);
    } on AppwriteException catch (e) {
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to fetch incomes by client',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<IncomeEntity>>> searchIncome({
    required String userId,
    required String query,
  }) async {
    try {
      // For now, we'll fetch all incomes and filter on the client side
      // In production, you might want to use Appwrite's search features
      final result = await getIncomes(userId: userId);

      return result.fold(
        (failure) => Left(failure),
        (incomes) {
          final searchLower = query.toLowerCase();
          final filtered = incomes.where((income) {
            return income.description?.toLowerCase().contains(searchLower) == true ||
                   income.category.toLowerCase().contains(searchLower) ||
                   (income.reference?.toLowerCase().contains(searchLower) == true) ||
                   (income.invoiceId?.toLowerCase().contains(searchLower) == true);
          }).toList();

          return Right(filtered);
        },
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}