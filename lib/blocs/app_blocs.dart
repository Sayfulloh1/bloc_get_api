import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/blocs/app_events.dart';
import 'package:flutter_bloc_app/blocs/app_states.dart';
import 'package:flutter_bloc_app/repos/repositories.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repository;

  UserBloc(this._repository) : super(UserLoadingState()) {
    on<LoadUserEvent>(
      (event, emit) async {
        emit(UserLoadingState());
        try {
          final users = await _repository.getUsers();
          emit(
            UserLoadedState(users),
          );
        } catch (error) {
          emit(UserErrorState('$error'));
        }
      },
    );
  }
}
