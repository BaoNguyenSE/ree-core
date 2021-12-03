import 'package:example/ui/count/widgets/counter_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_core/app_core.dart';

class CounterView extends StatefulWidget {
  final int counter;

  const CounterView({Key? key, required this.counter}) : super(key: key);

  @override
  _CounterViewState createState() => _CounterViewState();
}

class _CounterViewState extends BaseViewState<CounterView, CounterViewModel> {
  @override
  CounterViewModel createViewModel() => CounterViewModel();

  @override
  void loadArguments() {
    viewModel.counter = widget.counter;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          viewModel.counter.toString(),
          style: Theme.of(context).textTheme.headline4,
        ),
        Row(
          children: [
            Obx(
              () => Text(
                "Internal Counter: ${viewModel.internalCounter.toString()}",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            TextButton(
              onPressed: viewModel.increaseInternalCounter,
              child: const Text("Add"),
            ),
          ],
        )
      ],
    );
  }
}
