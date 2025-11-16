import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_service.dart';
import '../../services/token_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // EMAIL INPUT
              TextFormField(
                controller: emailC,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email tidak boleh kosong";
                  }
                  if (!value.contains("@")) {
                    return "Format email tidak valid";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // PASSWORD INPUT
              TextFormField(
                controller: passwordC,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password tidak boleh kosong";
                  }
                  if (value.length < 6) {
                    return "Password minimal 6 karakter";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              // LOGIN BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => isLoading = true);

                            final auth = AuthService();

                            final res = await auth.login(
                              emailC.text.trim(),
                              passwordC.text.trim(),
                            );

                            if (!res.success) {
                              // LOGIN FAIL RESPONSE
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Login gagal, cek kredensial."),
                                ),
                              );
                              setState(() => isLoading = false);
                              return;
                            }

                            // CEK ROLE
                            if (res.role == "admin") {
                              // POPUP ACCESS DENIED
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text("Access Denied"),
                                  content: const Text(
                                    "Akun admin tidak boleh login ke aplikasi user.",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                              setState(() => isLoading = false);
                              return;
                            }

                            // ROLE USER => SIMPAN TOKEN
                            if (res.role == "user" && res.accessToken != null) {
                              await TokenStorage.saveToken(res.accessToken!);

                              // Arahkan ke halaman utama
                              context.go("/events");
                            }

                            setState(() => isLoading = false);
                          }
                        },
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
