import 'dart:collection';
import 'package:my_social_app/providers/account_provider.dart';
import 'package:my_social_app/providers/search_state.dart';
import 'package:my_social_app/providers/user_state.dart';

class AppState{
  SearchState _searchState = SearchState();
  SearchState get searchState => _searchState;
  final Map<String,UserState> _users = {};

  UserState? getUser(String id) => _users[id];
  UnmodifiableListView<UserState> getFollowers(String id) => UnmodifiableListView(_users[id]!.followers.map((id) => _users[id]!));
  UnmodifiableListView<UserState> getFolloweds(String id) => UnmodifiableListView(_users[id]!.followeds.map((id) => _users[id]!));
  UnmodifiableListView<UserState> getRequesters() => UnmodifiableListView(_users[AccountProvider().state!.id]!.requesters.map((id) => _users[id]!));
  UnmodifiableListView<UserState> getRequesteds() => UnmodifiableListView(_users[AccountProvider().state!.id]!.requesteds.map((id) => _users[id]!));
  UnmodifiableListView<UserState> get usersSearched => UnmodifiableListView(_searchState.ids.map((id) => _users[id]!));

  AppState clone(){
    final AppState state = AppState();
    state._searchState = _searchState.clone();
    state._users.addEntries(_users.entries);
    return state;
  }
  
  void addUsers(List<UserState> users){
    final uniqUsers = users.where((user) => _users[user.id] == null);
    _users.addEntries(uniqUsers.map((user) => MapEntry(user.id, user)));
  }

  void addUser(UserState user){
    _users.addEntries([MapEntry(user.id, user)]);
  }
}