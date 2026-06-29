import 'package:dartz/dartz.dart';
import 'package:appwrite/appwrite.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/appwrite_client.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/investment_entity.dart';
import '../../domain/repositories/investment_repository.dart';
import '../models/investment_model.dart';

/// Investment Repository Implementation
/// Handles all investment data operations using Appwrite
class InvestmentRepositoryImpl implements InvestmentRepository {
  final AppwriteClient _appwriteClient;

  InvestmentRepositoryImpl(this._appwriteClient);

  @override
  Future<Either<Failure, InvestmentEntity>> createInvestment(InvestmentEntity investment) async {
    try {
      final model = InvestmentModel.fromEntity(investment);

      final document = await _appwriteClient.databases.createDocument(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionInvestments,
        documentId: ID.unique(),
        data: model.toMap()
          ..addAll({
            'updatedAt': DateTime.now().toIso8601String(),
          }),
      );

      final createdModel = InvestmentModel.fromMap(document.data);
      return Right(createdModel.toEntity());
    } on AppwriteException catch (e) {
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to create investment',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<InvestmentEntity>>> getInvestments({
    required String userId,
    String? investmentType,
    String? status,
    int? limit,
    int? offset,
  }) async {
    try {
      List<String> queries = [
        Query.equal('userId', userId),
        Query.orderDesc('investmentDate'),
      ];

      if (investmentType != null) {
        queries.add(Query.equal('investmentType', investmentType));
      }

      if (status != null) {
        queries.add(Query.equal('status', status));
      }

      if (limit != null) {
        queries.add(Query.limit(limit));
      }

      if (offset != null) {
        queries.add(Query.offset(offset));
      }

      final response = await _appwriteClient.databases.listDocuments(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionInvestments,
        queries: queries,
      );

      final investments = response.documents.map((doc) {
        return InvestmentModel.fromMap(doc.data).toEntity();
      }).toList();

      return Right(investments);
    } on AppwriteException catch (e) {
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to fetch investments',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, InvestmentEntity>> getInvestmentById(String id) async {
    try {
      final document = await _appwriteClient.databases.getDocument(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionInvestments,
        documentId: id,
      );

      final investment = InvestmentModel.fromMap(document.data).toEntity();
      return Right(investment);
    } on AppwriteException catch (e) {
      if (e.code == 404) {
        return Left(const NotFoundFailure(message: 'Investment not found'));
      }
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to fetch investment',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, InvestmentEntity>> updateInvestment(InvestmentEntity investment) async {
    try {
      final model = InvestmentModel.fromEntity(investment);

      final document = await _appwriteClient.databases.updateDocument(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionInvestments,
        documentId: investment.id,
        data: model.toMap()
          ..addAll({
            'updatedAt': DateTime.now().toIso8601String(),
          }),
      );

      final updatedModel = InvestmentModel.fromMap(document.data);
      return Right(updatedModel.toEntity());
    } on AppwriteException catch (e) {
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to update investment',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteInvestment(String id) async {
    try {
      await _appwriteClient.databases.deleteDocument(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionInvestments,
        documentId: id,
      );

      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to delete investment',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, InvestmentEntity>> updateInvestmentValue({
    required String investmentId,
    required double currentValue,
  }) async {
    try {
      final document = await _appwriteClient.databases.updateDocument(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionInvestments,
        documentId: investmentId,
        data: {
          'currentValue': currentValue,
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );

      final investment = InvestmentModel.fromMap(document.data).toEntity();
      return Right(investment);
    } on AppwriteException catch (e) {
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to update investment value',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getTotalInvestmentValue({
    required String userId,
  }) async {
    try {
      final result = await getInvestments(userId: userId, status: 'active');

      return result.fold(
        (failure) => Left(failure),
        (investments) => Right(
          investments.fold<double>(
            0.0,
            (total, investment) => total + (investment.currentValue ?? investment.initialAmount),
          ),
        ),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, double>>> getInvestmentsByType({
    required String userId,
  }) async {
    try {
      final result = await getInvestments(userId: userId);

      return result.fold(
        (failure) => Left(failure),
        (investments) {
          final typeMap = <String, double>{};
          for (final investment in investments) {
            final value = investment.currentValue ?? investment.initialAmount;
            typeMap[investment.investmentType] = (typeMap[investment.investmentType] ?? 0.0) + value;
          }
          return Right(typeMap);
        },
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<InvestmentEntity>>> getActiveInvestments({
    required String userId,
  }) async {
    return getInvestments(userId: userId, status: 'active');
  }

  @override
  Future<Either<Failure, List<InvestmentEntity>>> getMaturedInvestments({
    required String userId,
  }) async {
    try {
      final now = DateTime.now();
      final result = await getInvestments(userId: userId);

      return result.fold(
        (failure) => Left(failure),
        (investments) {
          final matured = investments.where((investment) {
            return investment.maturityDate != null &&
                   investment.maturityDate!.isBefore(now) &&
                   investment.status == 'active';
          }).toList();

          return Right(matured);
        },
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, InvestmentEntity>> markInvestmentAsSold({
    required String investmentId,
    required double sellingPrice,
    required DateTime soldDate,
  }) async {
    try {
      final document = await _appwriteClient.databases.updateDocument(
        databaseId: _appwriteClient.databaseId,
        collectionId: AppConstants.collectionInvestments,
        documentId: investmentId,
        data: {
          'currentValue': sellingPrice,
          'status': 'sold',
          'updatedAt': soldDate.toIso8601String(),
        },
      );

      final investment = InvestmentModel.fromMap(document.data).toEntity();
      return Right(investment);
    } on AppwriteException catch (e) {
      return Left(DatabaseFailure(
        message: e.message ?? 'Failed to mark investment as sold',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getInvestmentPerformance({
    required String userId,
  }) async {
    try {
      final result = await getInvestments(userId: userId);

      return result.fold(
        (failure) => Left(failure),
        (investments) {
          double totalInvested = 0.0;
          double totalCurrentValue = 0.0;
          double totalProfitLoss = 0.0;
          int performingCount = 0;
          int nonPerformingCount = 0;

          for (final investment in investments) {
            totalInvested += investment.initialAmount;
            final currentValue = investment.currentValue ?? investment.initialAmount;
            totalCurrentValue += currentValue;
            totalProfitLoss += investment.profitLoss;

            if (investment.profitLoss >= 0) {
              performingCount++;
            } else {
              nonPerformingCount++;
            }
          }

          final averageReturn = totalInvested > 0
              ? ((totalCurrentValue - totalInvested) / totalInvested) * 100
              : 0.0;

          return Right({
            'totalInvested': totalInvested,
            'totalCurrentValue': totalCurrentValue,
            'totalProfitLoss': totalProfitLoss,
            'averageReturn': averageReturn,
            'performingCount': performingCount,
            'nonPerformingCount': nonPerformingCount,
            'totalCount': investments.length,
          });
        },
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<InvestmentEntity>>> searchInvestments({
    required String userId,
    required String query,
  }) async {
    try {
      final result = await getInvestments(userId: userId);

      return result.fold(
        (failure) => Left(failure),
        (investments) {
          final searchLower = query.toLowerCase();
          final filtered = investments.where((investment) {
            return investment.investmentName.toLowerCase().contains(searchLower) ||
                   investment.investmentType.toLowerCase().contains(searchLower) ||
                   (investment.description?.toLowerCase().contains(searchLower) == true) ||
                   (investment.broker?.toLowerCase().contains(searchLower) == true);
          }).toList();

          return Right(filtered);
        },
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}