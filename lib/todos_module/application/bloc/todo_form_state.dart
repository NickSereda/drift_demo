
part of 'todo_form_cubit.dart';

enum TodoValidationError { empty, notEnoughChars }

class TodoFormState extends Equatable with FormzMixin {

  TodoFormState({
    this.todoDescription = const TodoDescription.pure(),
    this.formzStatus = FormzStatus.pure,
  });

  final TodoDescription todoDescription;
  final FormzStatus formzStatus;

  TodoFormState copyWith({
    TodoDescription? todoDescription,
    FormzStatus? formzStatus,
  }) {
    return TodoFormState(
      todoDescription: todoDescription ?? this.todoDescription,
      formzStatus: formzStatus ?? this.formzStatus,
    );
  }

  @override
  List<FormzInput> get inputs => [todoDescription];

  @override
  List<Object?> get props => [todoDescription, formzStatus];

}


class TodoDescription extends FormzInput<String, TodoValidationError> {
  const TodoDescription.pure([String value = '']) : super.pure(value);
  const TodoDescription.dirty([String value = '']) : super.dirty(value);

  // static final _emailRegExp = RegExp(
  //   r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  // );

  @override
  TodoValidationError? validator(String value) {

    // return _emailRegExp.hasMatch(value)
    //     ? null
    //     : EmailValidationError.invalid;


    if (value.isEmpty) {
      return TodoValidationError.empty;
    }

    if (value.length < 3) {
      return TodoValidationError.notEnoughChars;
    }

    return null;

  }

}

// enum PasswordValidationError { invalid }
//
// class Password extends FormzInput<String, PasswordValidationError> {
//   const Password.pure([String value = '']) : super.pure(value);
//   const Password.dirty([String value = '']) : super.dirty(value);
//
//   static final _passwordRegex =
//   RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
//
//   @override
//   PasswordValidationError? validator(String value) {
//     return _passwordRegex.hasMatch(value)
//         ? null
//         : PasswordValidationError.invalid;
//   }
// }

extension ErrorNaming on TodoValidationError {
  String get text {
    switch (this) {
      case TodoValidationError.empty:
        return 'Please enter some text';
      case TodoValidationError.notEnoughChars:
        return 'Please enter more letters';
    }
  }
}

