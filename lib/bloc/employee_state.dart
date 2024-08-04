part of 'employee_bloc.dart';

sealed class EmployeeState {}

final class EmployeeLoadingState extends EmployeeState {}

final class EmployeeLoadedState extends EmployeeState {
  final List<Employee> employees;

  EmployeeLoadedState(this.employees);
}

final class EmployeeErrorState extends EmployeeState {
  final String errorMessage;

  EmployeeErrorState(this.errorMessage);
}
