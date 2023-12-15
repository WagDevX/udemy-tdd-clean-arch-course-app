import 'package:dartz/dartz.dart';
import 'package:education_app/core/common/features/course/data/datasources/course_remote_data_source.dart';
import 'package:education_app/core/common/features/course/data/models/course_model.dart';
import 'package:education_app/core/common/features/course/data/repo/course_repo_impl.dart';
import 'package:education_app/core/common/features/course/domain/entities/course.dart';
import 'package:education_app/core/erros/exceptions.dart';
import 'package:education_app/core/erros/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRouseRemoteDataSource extends Mock
    implements CourseRemoteDataSource {}

void main() {
  late CourseRemoteDataSource dataSource;
  late CourseRepoImpl repoImpl;

  final tCourse = CourseModel.empty();

  setUp(() {
    dataSource = MockRouseRemoteDataSource();
    repoImpl = CourseRepoImpl(dataSource);
    registerFallbackValue(tCourse);
  });

  const tException =
      ServerException(message: 'Something went wrong', statusCode: '500');

  group('addCourse', () {
    test('should successfuly call the [CourseRemoteDataSource]', () async {
      when(() => dataSource.addCourse(any()))
          .thenAnswer((_) async => Future.value());

      final result = await repoImpl.addCourse(tCourse);

      expect(result, const Right<dynamic, void>(null));
      verify(() => dataSource.addCourse(tCourse)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
    test('should throw a [ServerExpection] when something goes wrong',
        () async {
      when(() => dataSource.addCourse(any())).thenThrow(tException);

      final result = await repoImpl.addCourse(tCourse);

      expect(
        result,
        Left<dynamic, Failure>(
          ServerFailure(
            message: tException.message,
            statusCode: tException.statusCode,
          ),
        ),
      );
      verify(() => dataSource.addCourse(tCourse)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });

  group('getCourses', () {
    final list = [tCourse];
    test(
        'should successfuly call the [CourseRemoteDataSource] '
        'and return a list of [CourseModel]', () async {
      when(() => dataSource.getCourses()).thenAnswer((_) async => list);

      final result = await repoImpl.getCourses();

      expect(result, isA<Right<dynamic, List<Course>>>());
      verify(() => dataSource.getCourses()).called(1);
      verifyNoMoreInteractions(dataSource);
    });
    test('should throw a [ServerExpection] when something goes wrong',
        () async {
      when(() => dataSource.getCourses()).thenThrow(tException);

      final result = await repoImpl.getCourses();

      expect(
        result,
        Left<dynamic, Failure>(
          ServerFailure(
            message: tException.message,
            statusCode: tException.statusCode,
          ),
        ),
      );
      verify(() => dataSource.getCourses()).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}
