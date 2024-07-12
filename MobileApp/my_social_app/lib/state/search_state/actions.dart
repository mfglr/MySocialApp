import 'package:flutter/material.dart';
import 'package:my_social_app/state/actions.dart' as redux;

@immutable
class SearchAction extends redux.Action{
  final String key;
  const SearchAction({required this.key});
}

@immutable
class SuccessfullySearchedAction extends redux.Action{
  final String key;
  final List<int> payload;
  const SuccessfullySearchedAction({required this.key,required this.payload});
}

@immutable
class NextPageSearchingAction extends redux.Action{
  const NextPageSearchingAction();
}

@immutable
class NextPageSearchingSuccessAction extends redux.Action{
  final List<int> payload;
  const NextPageSearchingSuccessAction({required this.payload});
}

@immutable
class ClearSearchingAction extends redux.Action{
  const ClearSearchingAction();
}