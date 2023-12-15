import 'package:education_app/core/common/features/course/domain/entities/course.dart';
import 'package:education_app/core/common/features/course/domain/repos/course_repo.dart';
import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedef.dart';

class AddCourse extends UseCaseWithParams<void, Course> {
  AddCourse(this._repo);

  final CourseRepo _repo;

  @override
  ResultFuture<void> call(Course params) async => _repo.addCourse(params);
}
