import 'package:dartz/dartz.dart';
import 'package:education_app/core/erros/exceptions.dart';
import 'package:education_app/core/erros/failure.dart';
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/data/repos/on_boarding_repo_impl.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingLocalDataSrc extends Mock
    implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource localDataSource;
  late OnBoardingRepoImpl repoImpl;

  setUp(() {
    localDataSource = MockOnboardingLocalDataSrc();
    repoImpl = OnBoardingRepoImpl(localDataSource);
  });

  test('should be a subclass of [OnBoardingRepo]', () {
    expect(repoImpl, isA<OnBoardingRepo>());
  });

  group('cacheFirstTimer', () {
    test('should complete successfuly when call to local source is successful',
        () async {
      when(
        () => localDataSource.cacheFirstTimer(),
      ).thenAnswer(
        // ignore: void_checks, inference_failure_on_instance_creation
        (_) async => Future.value(),
      );
      final result = await repoImpl.cacheFirstTimer();

      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => repoImpl.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });
  test('should return [CacheFailure] when call to local source is unssucessful',
      () async {
    when(() => localDataSource.cacheFirstTimer())
        .thenThrow(const CacheExpection(message: 'Insufficient storage'));
    // act

    final result = await repoImpl.cacheFirstTimer();

    expect(
      result,
      equals(
        Left<CacheFailure, dynamic>(
          CacheFailure(message: 'Insufficient storage', statusCode: 500),
        ),
      ),
    );
    verify(() => localDataSource.cacheFirstTimer()).called(1);
    verifyNoMoreInteractions(localDataSource);
  });

  group('checkIfUserIsFirstTimer', () {
    test('should return [true] when user is first timer', () async {
      when(
        () => localDataSource.checkIfUserIsFirstTimer(),
      ).thenAnswer(
        // ignore: void_checks, inference_failure_on_instance_creation
        (_) async => Future.value(true),
      );
      final result = await repoImpl.checkIfUserIsFirstTimer();

      expect(result, equals(const Right<dynamic, bool>(true)));
      verify(() => repoImpl.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
    test('should return [false] when user is not firs timer', () async {
      when(
        () => localDataSource.checkIfUserIsFirstTimer(),
      ).thenAnswer(
        // ignore: void_checks, inference_failure_on_instance_creation
        (_) async => Future.value(false),
      );
      final result = await repoImpl.checkIfUserIsFirstTimer();

      expect(result, equals(const Right<dynamic, bool>(false)));
      verify(() => repoImpl.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });

  test('should return CacheFailure when call to local source is unssucessful',
      () async {
    when(() => localDataSource.checkIfUserIsFirstTimer()).thenThrow(
      const CacheExpection(
        message: 'Unable to check if user is first timer',
        statusCode: 403,
      ),
    );
    // act

    final result = await repoImpl.checkIfUserIsFirstTimer();

    expect(
      result,
      equals(
        Left<CacheFailure, bool>(
          CacheFailure(
            message: 'Unable to check if user is first timer',
            statusCode: 403,
          ),
        ),
      ),
    );
    verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
    verifyNoMoreInteractions(localDataSource);
  });
}
