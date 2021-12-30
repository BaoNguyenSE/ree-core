import 'package:app_core/src/ui/base_view_model.dart';
import 'package:flutter/material.dart';

abstract class BaseViewState<T extends StatefulWidget, M extends BaseViewModel> extends State<T> {
  late M _viewModel;

  M get viewModel => _viewModel;

  @protected
  void loadArguments() {}

  @protected
  M createViewModel();

  @override
  void initState() {
    _viewModel = createViewModel();
    super.initState();
    loadArguments();
    _viewModel.initState();
    _viewModel.context = context;
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    loadArguments();
  }

  @override
  void dispose() {
    _viewModel.disposeState();
    super.dispose();
  }
}
