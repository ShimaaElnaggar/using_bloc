part of 'employee_bloc.dart';

sealed class EmployeeState {}

sealed class EmployeeAddedState extends EmployeeState {}

final class EmployeeLoadingState extends EmployeeState {}

final class EmployeeLoadedState extends EmployeeState {
  final List<Employee> employees;

  EmployeeLoadedState(this.employees);
}

final class EmployeeErrorState extends EmployeeState {
  final String errorMessage;

  EmployeeErrorState(this.errorMessage);
}

final class EmployeeAddingState extends EmployeeAddedState {}

final class EmployeeAddingLoadingState extends EmployeeAddedState {}

final class EmployeeAddingSuccessfulState extends EmployeeAddedState {}

final class EmployeeAddingErrorState extends EmployeeAddedState {
  final String errorMessage;

  EmployeeAddingErrorState(this.errorMessage);
}
