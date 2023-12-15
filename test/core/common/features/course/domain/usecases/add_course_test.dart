import 'package:dartz/dartz.dart';
import 'package:education_app/core/common/features/course/domain/entities/course.dart';
import 'package:education_app/core/common/features/course/domain/repos/course_repo.dart';
import 'package:education_app/core/common/features/course/domain/usecases/add_course.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'course_repo_mock.dart';

void main() {
  late CourseRepo repo;
  late AddCourse usecase;

  final tCourse = Course.emtpy();

  setUp(() {
    repo = MockCourseRepo();
    usecase = AddCourse(repo);
    registerFallbackValue(tCourse);
  });

  test('should successfuly call [CourseRepo.addCourse]', () async {
    when(() => repo.addCourse(any()))
        .thenAnswer((_) async => const Right(null));

    final result = await usecase(tCourse);

    expect(result, const Right<dynamic, void>(null));
    verify(() => repo.addCourse(tCourse)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
