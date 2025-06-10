import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:maestro_vs_flutter_test/domain/entities/quote.dart';
import 'package:maestro_vs_flutter_test/domain/repositories/quote_repository.dart';

@GenerateNiceMocks([MockSpec<QuoteRepository>()])
import 'mock_quote_repository.mocks.dart';
