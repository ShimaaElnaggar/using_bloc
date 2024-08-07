import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:using_bloc/models/employee.dart';

class EmployeeRepository {
  static List<Employee> employeesList = [] ;
  Future<List<Employee>> getEmployees() async {
    try {
      var result = await rootBundle.loadString('assets/employees.json');
      var employeesData = json.decode(result);
      employeesList = List<Employee>.from(
          employeesData.map((data) => Employee.fromJson(data)).toList());
      return employeesList;
    } catch (e) {
      rethrow;
    }
  }
}
