import 'package:dartz/dartz.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/erros/exceptions.dart';
import 'package:education_app/core/erros/failure.dart';
import 'package:education_app/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:education_app/src/auth/data/models/user_model.dart';
import 'package:education_app/src/auth/data/repos/auth_repo_imp.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSrc extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource remoteDataSource;
  late AuthRepoImpl repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthRepoImpl(remoteDataSource);
    registerFallbackValue(UpdateUserAction.password);
  });

  const tPassword = 'Test password';
  const tFullName = 'Test full name';
  const tEmail = 'Test email';
  const tUpdateAction = UpdateUserAction.password;
  const tUserData = 'New password';

  const tUser = LocalUserModel.empty();

  group('forgotPassword', () {
    test('should return [void] when call to remote source is successful',
        () async {
      when(() => remoteDataSource.forgotPassword(any()))
          .thenAnswer((_) async => Future.value());

      final result = await repoImpl.forgotPassword(email: tEmail);

      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => remoteDataSource.forgotPassword(tEmail)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return [ServerFailure] when call to remote source is '
        'unsuccessful', () async {
      when(() => remoteDataSource.forgotPassword(any())).thenThrow(
        const ServerException(
          message: 'User does not exist',
          statusCode: '404',
        ),
      );

      final result = await repoImpl.forgotPassword(email: tEmail);
      expect(
        result,
        equals(
          Left<ServerFailure, void>(
            ServerFailure(message: 'User does not exist', statusCode: '404'),
          ),
        ),
      );
    });
  });

  group('signIn', () {
    test('should return a [LocalUser] when call to remote source is successful',
        () async {
      when(
        () => remoteDataSource.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => tUser,
      );

      final result = await repoImpl.signIn(email: tEmail, password: tPassword);

      expect(result, equals(const Right<dynamic, LocalUser>(tUser)));
      verify(() => remoteDataSource.signIn(email: tEmail, password: tPassword))
          .called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return [ServerFailure] when call to remote source is '
        'unsuccessful', () async {
      when(
        () => remoteDataSource.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(
        const ServerException(
          message: 'User doest not exist',
          statusCode: '404',
        ),
      );

      final result = await repoImpl.signIn(email: tEmail, password: tPassword);

      expect(
        result,
        equals(
          Left<dynamic, void>(
            ServerFailure(message: 'User doest not exist', statusCode: '404'),
          ),
        ),
      );
      verify(() => remoteDataSource.signIn(email: tEmail, password: tPassword))
          .called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('signUp', () {
    test('should return [void] when call to remote source is sucessful',
        () async {
      when(
        () => remoteDataSource.signUp(
          email: any(named: 'email'),
          fullName: any(named: 'fullName'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => Future.value(),
      );

      final result = await repoImpl.signUp(
        email: tEmail,
        fullName: tFullName,
        password: tPassword,
      );

      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => remoteDataSource.signUp(
          email: tEmail,
          fullName: tFullName,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return [ServerFailure] when call to remote source is '
        'unsuccessful', () async {
      when(
        () => remoteDataSource.signUp(
          email: any(named: 'email'),
          fullName: any(named: 'fullName'),
          password: any(named: 'password'),
        ),
      ).thenThrow(
        const ServerException(
          message: 'User already exists',
          statusCode: '400',
        ),
      );

      final result = await repoImpl.signUp(
        email: tEmail,
        fullName: tFullName,
        password: tPassword,
      );

      expect(
        result,
        equals(
          Left<ServerFailure, void>(
            ServerFailure(message: 'User already exists', statusCode: '400'),
          ),
        ),
      );
      verify(
        () => remoteDataSource.signUp(
          email: tEmail,
          fullName: tFullName,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('updateUser', () {
    test('should return [void] when call to remote source is successful',
        () async {
      when(
        () => remoteDataSource.updateUser(
          action: any(named: 'action'),
          userData: any<dynamic>(named: 'userData'),
        ),
      ).thenAnswer((_) async => Future.value());

      final result =
          await repoImpl.updateUser(action: tUpdateAction, userData: tUserData);

      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => remoteDataSource.updateUser(
          action: tUpdateAction,
          userData: tUserData,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return [ServerFailure] when call to remote source is '
        'unsuccessful', () async {
      when(
        () => remoteDataSource.updateUser(
          action: any(named: 'action'),
          userData: any<dynamic>(named: 'userData'),
        ),
      ).thenThrow(
        const ServerException(
          message: 'User doest no exist',
          statusCode: '404',
        ),
      );

      final result =
          await repoImpl.updateUser(action: tUpdateAction, userData: tUserData);

      expect(
        result,
        equals(
          Left<ServerFailure, void>(
            ServerFailure(message: 'User doest no exist', statusCode: '404'),
          ),
        ),
      );
      verify(
        () => remoteDataSource.updateUser(
          action: tUpdateAction,
          userData: tUserData,
        ),
      );
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
