import 'package:mocktail/mocktail.dart';
import 'package:saa_mobile/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:saa_mobile/features/profile/data/repositories/profile_repository.dart';

class MockProfileRemoteDatasource extends Mock
    implements ProfileRemoteDatasource {}

class MockProfileRepository extends Mock implements ProfileRepository {}
