part of 'employee_bloc.dart';

sealed class EmployeeEvent {}

class LoadEmployeeEvent extends EmployeeEvent {}

class AddEmployeeEvent extends EmployeeEvent {
  final Employee employee;
  AddEmployeeEvent(this.employee);
}
