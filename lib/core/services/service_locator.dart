import 'package:get_it/get_it.dart';
import 'package:pp_438/core/services/database/database_service.dart';
import 'package:pp_438/core/services/flag_smith_service.dart';

class ServiceLocator {
  static Future<void> setup() async {
    GetIt.I.registerSingletonAsync(() => DatabaseService().init());
    await GetIt.I.isReady<DatabaseService>();
    GetIt.I.registerSingletonAsync(() => FlagSmithService().init());
    await GetIt.I.isReady<FlagSmithService>();
    /*  GetIt.I.registerSingletonAsync(() => RemoteConfigService().init());
    await GetIt.I.isReady<RemoteConfigService>();*/
  }
}
