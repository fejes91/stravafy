import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injectable.config.dart';

const mock = Environment('mock');
const integration = Environment('integration');

@InjectableInit()
Future<void> configureDependencies() async {
  await GetIt.instance.init();
}
