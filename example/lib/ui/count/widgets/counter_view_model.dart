import 'package:get/get.dart';
import 'package:app_core/app_core.dart';

class CounterViewModel extends BaseViewModel {
  int? counter;

  RxInt internalCounter = 0.obs;

  void increaseInternalCounter() {
    internalCounter++;
  }
}
