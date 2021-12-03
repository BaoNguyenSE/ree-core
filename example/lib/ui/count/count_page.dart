import 'package:example/ui/count/count_page_model.dart';
import 'package:example/ui/count/widgets/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_service/keyboard_service.dart';
import 'package:app_core/app_core.dart';

class CountPage extends StatefulWidget {
  @override
  _CountPageState createState() => _CountPageState();
}

class _CountPageState extends BaseViewState<CountPage, CountPageModel> {
  @override
  CountPageModel createViewModel() => CountPageModel();

  @override
  Widget build(BuildContext context) {
    return KeyboardAutoDismiss(
      scaffold: Scaffold(
        appBar: AppBar(
          title: const Text("Test"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Obx(
                  () => Text(
                    viewModel.description.toString(),
                  ),
                ),
                Obx(
                  () => CounterView(counter: viewModel.count),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      TextField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(hintText: "Email"),
                        onChanged: (value) => viewModel.email = value,
                      ),
                      Container(
                        margin: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(color: Colors.lightBlue, borderRadius: BorderRadius.circular(5)),
                        child: TextButton(
                          onPressed: () async => viewModel.sendOTP(),
                          child: const Text("Send Code", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      TextField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(hintText: "Code"),
                        onChanged: (value) => viewModel.code = value,
                      ),
                      Container(
                        margin: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(color: Colors.lightBlue, borderRadius: BorderRadius.circular(5)),
                        child: TextButton(
                          onPressed: () async => viewModel.login(),
                          child: const Text("Login", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            viewModel.increase();
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
