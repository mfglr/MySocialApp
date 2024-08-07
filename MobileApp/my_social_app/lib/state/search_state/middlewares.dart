import 'package:my_social_app/services/user_service.dart';
import 'package:my_social_app/state/image_status.dart';
import 'package:my_social_app/state/search_state/actions.dart';
import 'package:my_social_app/state/state.dart';
import 'package:my_social_app/state/user_entity_state/actions.dart';
import 'package:my_social_app/state/user_image_entity_state/actions.dart';
import 'package:my_social_app/state/user_image_entity_state/user_image_state.dart';
import 'package:redux/redux.dart';

void searchMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is SearchAction){
    UserService()
      .search(action.key)
      .then((users){
        store.dispatch(
          AddUsersAction(
            users: users.map((e) => e.toUserState())
          )
        );

        store.dispatch(
          AddUserImagesAction(
            images: users.map((e) => UserImageState(id: e.id, image: null, state: ImageStatus.notStarted))
          )
        );

        store.dispatch(
          SearchSuccessAction(
            key: action.key,
            payload: users.map((e) => e.id)
          )
        );
      });
  }
  next(action);
}

void nextPageSearchingMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is NextPageSearchingAction){
    final key = store.state.searchState.key;
    final lastId = store.state.searchState.users.lastValue;
    UserService()
      .search(key,lastValue: lastId)
      .then((users){
        store.dispatch(
          AddUsersAction(
            users: users.map((e) => e.toUserState())
          )
        );
        
        store.dispatch(
          AddUserImagesAction(
            images: users.map((e) => UserImageState(id: e.id, image: null, state: ImageStatus.notStarted))
          )
        );

        store.dispatch(
          NextPageOfSearchingSuccessAction(
            payload: users.map((e) => e.id)
          )
        );
      });
  }
  next(action);
}

