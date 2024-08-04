import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_bloc/bloc/employee_bloc.dart';

class ShowEmployees extends StatefulWidget {
  const ShowEmployees({
    super.key,
  });

  @override
  State<ShowEmployees> createState() => _ShowEmployess();
}

class _ShowEmployess extends State<ShowEmployees> {
  @override
  void initState() {
    context.read<EmployeeBloc>().add(LoadEmployeeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Show Employees',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<EmployeeBloc, EmployeeState>(builder: (context, state) {
              if (state is EmployeeLoadedState) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.employees.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Card(
                            elevation: 5.0,
                            margin: const EdgeInsets.all(8.0),
                            color: Colors.white,
                            shadowColor: Colors.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: ListTile(
                              title: Text(
                                "${state.employees[index].name?.first ?? 'No Name'} ${state.employees[index].name?.last ?? 'No Name'}",
                                style: const TextStyle(fontWeight: FontWeight.w700),
                              ),
                              subtitle: Text(
                                state.employees[index].email.toString(),
                                style: const TextStyle(color: Colors.indigo),
                              ),
                              trailing: Text(
                                state.employees[index].address?.city ??
                                    'No Adress',
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              } else if (state is EmployeeErrorState) {
                return Text('Error: ${state.errorMessage}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add,color: Colors.white,),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
