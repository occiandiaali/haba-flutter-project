import 'package:haba/src/features/authentication/data/repository/app_auth_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockSupabaseAuth extends Mock implements AppAuthRepo {}

// test('calls signOut', () async {
//   final mock = MockSupabaseAuth();
//
//   when(mock.signOut).thenAnswer((_) => Future.value());
//   final authRepository = AppAuthRepo(mock);
//
//   await authRepository.signOut();
//   expect(mock.signOut).called(1);
// })
