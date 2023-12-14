import 'package:dartz/dartz.dart';
import 'package:education_app/core/erros/failure.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repo_mock.dart';

void main() {
  late MockOnBoardingRepo repo;
  late CheckIfUserIsFirstTimer usecase;

  setUp(() {
    repo = MockOnBoardingRepo();
    usecase = CheckIfUserIsFirstTimer(repo);
  });

  test('should get a response from the [MockOboardingRepo]', () async {
    when(() => repo.checkIfUserIsFirstTimer()).thenAnswer(
      (_) async => const Right(true),
    );
    //Act
    final response = await usecase();

    expect(response, equals(const Right<Failure, bool>(true)));
    verify(() => repo.checkIfUserIsFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
