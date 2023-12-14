import 'package:dartz/dartz.dart';
import 'package:education_app/core/erros/failure.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repo_mock.dart';

void main() {
  late OnBoardingRepo repo;
  late CacheFirstTimer usecase;

  setUp(() {
    repo = MockOnBoardingRepo();
    usecase = CacheFirstTimer(repo);
  });

  test(
      'should call the [OnboardingRepo.cacheFirstTimer] '
      'and return the right data', () async {
    //Arrange
    when(() => repo.cacheFirstTimer()).thenAnswer(
      (_) async => Left(
        ServerFailure(message: 'Unknown Error Occurred', statusCode: 500),
      ),
    );
    //Act
    final result = await usecase();

    expect(
      result,
      equals(
        Left<Failure, dynamic>(
          ServerFailure(message: 'Unknown Error Occurred', statusCode: 500),
        ),
      ),
    );
    verify(
      () => repo.cacheFirstTimer(),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}
