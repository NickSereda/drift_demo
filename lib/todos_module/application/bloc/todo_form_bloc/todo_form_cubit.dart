import 'package:bloc/bloc.dart';
import 'package:drift_demo/todos_module/application/bloc/todos_bloc/todos_cubit.dart';
import 'package:drift_demo/todos_module/infrastructure/services/database/app_db.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:formz/formz.dart';
import 'package:drift/drift.dart' as drift;

part 'todo_form_state.dart';

@injectable
class TodoFormCubit extends Cubit<TodoFormState> {
  final TodosCubit _todosCubit;

  TodoFormCubit(this._todosCubit)
      : super(
          TodoFormState(
            todoDescription: const TodoDescription.pure(),
            formzStatus: FormzStatus.pure,
          ),
        );

  void onTodoChanged(String? todoDescription) {
    final desrc = TodoDescription.dirty(todoDescription ?? '');
    emit(state.copyWith(todoDescription: desrc, formzStatus: Formz.validate([desrc])));
  }

  /// Submitting form, returns true when successful, false if not.
  Future<bool> onSubmit(TextEditingController textEditingController) async {

    if (state.formzStatus.isInvalid || state.formzStatus.isPure) return false;
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
    try {
      final TodoCompanion entity = TodoCompanion(
        todoDescription: drift.Value(state.todoDescription.value),
        isCompleted: const drift.Value(false),
      );

      _todosCubit.addTodo(entity);
      emit(state.copyWith(formzStatus: FormzStatus.submissionSuccess));

      textEditingController.clear();
      emit(state.copyWith(todoDescription: const TodoDescription.pure(''), formzStatus: FormzStatus.pure));

      return true;
    } catch (_) {
      emit(state.copyWith(formzStatus: FormzStatus.submissionFailure));
      return false;
    }
  }
}
