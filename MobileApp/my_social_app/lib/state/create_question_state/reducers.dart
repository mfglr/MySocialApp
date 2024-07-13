import 'package:my_social_app/state/actions.dart' as redux;
import 'package:my_social_app/state/create_question_state/actions.dart';
import 'package:my_social_app/state/create_question_state/create_question_state.dart';
import 'package:redux/redux.dart';

CreateQuestionState addImageReducer(CreateQuestionState oldState, redux.Action action)
  => action is AddImageAction ? oldState.addImage(action.image) : oldState;

CreateQuestionState removeImageReducer(CreateQuestionState oldState, redux.Action action)
  => action is RemoveImageAction ? oldState.removeImage(action.image) : oldState;

CreateQuestionState updateContentReducer(CreateQuestionState oldState, redux.Action action)
  => action is UpdateContentAction ? oldState.updateContent(action.content) : oldState;

CreateQuestionState updateExamReducer(CreateQuestionState oldState, redux.Action action)
  => action is UpdateExamAction ? oldState.updateExam(action.examId) : oldState;

CreateQuestionState updateSubjectReducer(CreateQuestionState oldState,redux.Action action)
  => action is UpdateSubjectAction ? oldState.updateSubject(action.subjectId) : oldState;

CreateQuestionState addTopicIdReducer(CreateQuestionState oldState,redux.Action action)
  => action is AddTopicIdAction ? oldState.addTopicId(action.topicId) : oldState;

CreateQuestionState removeTopicIdReducer(CreateQuestionState oldState,redux.Action action)
  => action is RemoveTopicIdAction ? oldState.removeTopicId(action.topicId) : oldState;

Reducer<CreateQuestionState> createQuestionReducers = combineReducers<CreateQuestionState>([
  TypedReducer<CreateQuestionState,AddImageAction>(addImageReducer).call,
  TypedReducer<CreateQuestionState,RemoveImageAction>(removeImageReducer).call,
  TypedReducer<CreateQuestionState,UpdateContentAction>(updateContentReducer).call,
  TypedReducer<CreateQuestionState,UpdateExamAction>(updateExamReducer).call,
  TypedReducer<CreateQuestionState,UpdateSubjectAction>(updateSubjectReducer).call,
  TypedReducer<CreateQuestionState,AddTopicIdAction>(addTopicIdReducer).call,
  TypedReducer<CreateQuestionState,RemoveTopicIdAction>(removeTopicIdReducer).call,
]);

