import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

part 'todo_form_state.dart';

class TodoFormCubit extends Cubit<TodoFormState> {
  TodoFormCubit()
      : super(
          TodoFormState(
            todoDescription: const TodoDescription.pure(),
            formzStatus: FormzStatus.pure,
          ),
        );

  void onTodoChanged(String? todoDescription) {
    final desrc = TodoDescription.dirty(todoDescription ?? '');
    emit(state.copyWith(
        todoDescription: desrc, formzStatus: Formz.validate([desrc])));
  }

  /// Submitting form, returns true when successful, false if not.
  Future<void> onSubmit() async {
    if (state.formzStatus.isInvalid || state.formzStatus.isPure) return;
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
    try {
      emit(state.copyWith(formzStatus: FormzStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(formzStatus: FormzStatus.submissionFailure));
    }
  }

  void clearForm() {
    emit(
      state.copyWith(
          todoDescription: const TodoDescription.pure(''),
          formzStatus: FormzStatus.pure),
    );
  }
}
