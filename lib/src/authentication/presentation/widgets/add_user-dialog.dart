import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/presentation/cubit/authentication_cubit.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({super.key, required this.nameController});
  final TextEditingController nameController;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'username'),
              ),
              ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    context.read<AuthenticationCubit>().createUserHandler(
                        createdAt: DateTime.now().toString(),
                        name: name,
                        avatar:
                            'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1226.jpg');
                    Navigator.of(context).pop();
                  },
                  child: const Text('Create User'))
            ],
          ),
        ),
      ),
    );
  }
}
