import 'package:mocktail/mocktail.dart';
import 'package:saa_mobile/features/home/data/datasources/home_remote_datasource.dart';
import 'package:saa_mobile/features/home/data/repositories/home_repository.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

class MockHomeRemoteDatasource extends Mock implements HomeRemoteDatasource {}
