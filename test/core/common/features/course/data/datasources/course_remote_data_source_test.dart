import 'package:education_app/core/common/features/course/data/datasources/course_remote_data_source.dart';
import 'package:education_app/core/common/features/course/data/models/course_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late CourseRemoteDataSource dataSource;
  late FakeFirebaseFirestore firestore;
  late MockFirebaseAuth auth;
  late MockFirebaseStorage storage;

  final tCourse = CourseModel.empty();

  setUp(() async {
    firestore = FakeFirebaseFirestore();
    final user = MockUser(
      uid: '123',
      email: 'email',
      displayName: 'name',
    );

    final googleSignIn = MockGoogleSignIn();
    final sinInAccount = await googleSignIn.signIn();
    final googleAuth = await sinInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    auth = MockFirebaseAuth(mockUser: user);
    await auth.signInWithCredential(credential);
    storage = MockFirebaseStorage();
    dataSource = CourseRemoteDataSourceImpl(
      firestore: firestore,
      storage: storage,
      auth: auth,
    );
    registerFallbackValue(tCourse);
  });

  group('addCourse', () {
    test(
        'should successfuly call the [CourseRemoteDataSource] '
        'and add the course in the firestore collection', () async {
      await dataSource.addCourse(tCourse);

      final firestoreData = await firestore.collection('courses').get();

      expect(firestoreData.docs.length, 1);

      final courseRef = firestoreData.docs.first;

      expect(courseRef.data()['id'], courseRef.id);

      final groupData = await firestore.collection('groups').get();
      expect(groupData.docs.length, 1);

      final groupRef = groupData.docs.first;
      expect(groupRef.data()['id'], groupRef.id);

      expect(courseRef.data()['groupId'], groupRef.id);
      expect(groupRef.data()['courseId'], courseRef.id);
    });
  });

  group('getCourses', () {
    test('should return a list if [Course] when the call is successful',
        () async {
      final firstDate = DateTime.now();
      final secodnDate = DateTime.now().add(const Duration(seconds: 20));
      // Arrange
      final expectedCourses = [
        CourseModel.empty().copyWith(createdAt: firstDate),
        CourseModel.empty()
            .copyWith(createdAt: secodnDate, id: '1', title: 'Course 1'),
      ];
      for (final course in expectedCourses) {
        await firestore.collection('courses').add(course.toMap());
      }
      // act
      final result = await dataSource.getCourses();

      expect(result, expectedCourses);
    });
  });
}
