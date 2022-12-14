import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/widgets/logo_app.dart';
import 'models/user.dart';
import 'register_controller.dart';
import 'register_states.dart';
import '../../design_sys/sizes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final ValueNotifier<bool> isVisible = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    RegisterController controller = context.read<RegisterController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Sizes.largeSpace),
        child: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(Sizes.mediumSpace),
                    child: LogoApp(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Sizes.mediumSpace),
                    child: Text(
                      'Cadastre-se',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Nome'),
                    controller: nameController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Nome é obrigatório';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    controller: emailController,
                    validator: (value) {
                      if ((value?.isEmpty ?? true)) {
                        return 'Email é obrigatório';
                      } else if (!value!.contains('@')) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                  ValueListenableBuilder(
                    builder: (context, value, _) {
                      return TextFormField(
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Senha é obrigatório';
                          } else if (value!.length < 6) {
                            return 'Senha inválida, mínimo 6 caracteres';
                          }
                          return null;
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          suffixIcon: IconButton(
                            onPressed: () => isVisible.value = !isVisible.value,
                            icon: Icon(value
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                        obscureText: value ? false : true,
                      );
                    },
                    valueListenable: isVisible,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: Sizes.mediumSpace),
                    child: SizedBox(
                      width: double.infinity,
                      child: BlocListener<RegisterController, RegisterState>(
                        listener: (context, state) {
                          if (state is LoadingRegisterState) {
                            showDialog(
                              context: context,
                              builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          if (state is ErrorRegisterState) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.error),
                              ),
                            );
                          }
                          if (state is SuccessRegisterState) {
                            Navigator.of(context)
                                .pushReplacementNamed('/home-page');
                          }
                        },
                        child: ElevatedButton(
                          style: Theme.of(context).elevatedButtonTheme.style,
                          onPressed: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              await controller.registerUser(
                                User(
                                    name: nameController.text,
                                    email: emailController.text,
                                    passworld: passwordController.text),
                              );
                            }
                          },
                          child: const Text('CRIAR CONTA'),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: const Text('JÁ POSSUI CADASTRO?'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}