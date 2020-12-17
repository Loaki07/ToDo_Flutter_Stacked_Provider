import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'locator.config.dart';

final GetIt locator = GetIt.instance;

/// Alternative Method using injectable
@injectableInit
void setupLocator() => $initGetIt(locator);

@module
abstract class ThirdPartyServicesModule {
  @lazySingleton
  NavigationService get navigationService;
  @lazySingleton
  DialogService get dialogService;
}