import 'package:dartz/dartz.dart';
import 'package:education_app/core/common/features/course/data/datasources/course_remote_data_source.dart';
import 'package:education_app/core/common/features/course/domain/entities/course.dart';
import 'package:education_app/core/common/features/course/domain/repos/course_repo.dart';
import 'package:education_app/core/erros/exceptions.dart';
import 'package:education_app/core/erros/failure.dart';
import 'package:education_app/core/utils/typedef.dart';

class CourseRepoImpl implements CourseRepo {
  const CourseRepoImpl(this._remoteDataSrc);

  final CourseRemoteDataSource _remoteDataSrc;

  @override
  ResultFuture<void> addCourse(Course course) async {
    try {
      await _remoteDataSrc.addCourse(course);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<Course>> getCourses() async {
    try {
      final result = await _remoteDataSrc.getCourses();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
