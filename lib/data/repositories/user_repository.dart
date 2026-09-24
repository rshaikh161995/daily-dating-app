import '../datasources/user_remote_datasource.dart';
import '../models/user_model.dart';

class UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepository({
    required this.remoteDataSource,
  });

  Future<List<UserModel>> getUsers() async {
    return await remoteDataSource.getUsers();
  }
}