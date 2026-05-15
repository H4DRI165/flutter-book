import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app.dart';
import 'bloc/login_bloc.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authRepository: context.read<AuthRepository>(),
      ),
      child: BlocListener<LoginBloc, LoginPageState>(
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            context.router.replace(const MainMenuRoute());
          } else if (state.status == LoginStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage ?? 'Login failed. Please try again.',
                ),
              ),
            );
          }
        },
        child: const Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(),
                _BodyContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppIcon(
          icon: Icons.menu_book_rounded,
          iconColor: Color(0xFF534AB7),
          containerColor: Color(0xFFEEEDFE),
          size: 28,
        ),
        SizedBox(height: 10),
        Text(
          'Welcome back',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Sign in to continue your learning journey',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class _BodyContent extends StatefulWidget {
  const _BodyContent();

  @override
  State<_BodyContent> createState() => _BodyContentState();
}

class _BodyContentState extends State<_BodyContent> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        BlocBuilder<LoginBloc, LoginPageState>(
          buildWhen: (previous, current) => previous.emailError != current.emailError,
          builder: (context, state) {
            return AppTextField(
              controller: _emailController,
              labelText: 'Email',
              hintText: 'Enter your email',
              border: AppFormFieldBorder.roundedOutlined,
              errorText: state.emailError,
              clearable: true,
              onChanged: (value) {
                context.read<LoginBloc>().add(LoginEmailChanged(value));
              },
            );
          },
        ),
        const SizedBox(height: 16),
        BlocBuilder<LoginBloc, LoginPageState>(
          buildWhen: (previous, current) =>
              previous.obscurePassword != current.obscurePassword || previous.passwordError != current.passwordError,
          builder: (context, state) {
            return AppTextField(
              controller: _passwordController,
              labelText: 'Password',
              hintText: 'Enter your password',
              border: AppFormFieldBorder.roundedOutlined,
              errorText: state.passwordError,
              obscureText: state.obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  state.obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                ),
                onPressed: () {
                  context.read<LoginBloc>().add(const LoginObscurePasswordToggled());
                },
              ),
              onChanged: (value) {
                context.read<LoginBloc>().add(LoginPasswordChanged(value));
              },
            );
          },
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            context.router.push(const ForgotPasswordRoute());
          },
          child: const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Forgot password?',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        BlocBuilder<LoginBloc, LoginPageState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) => _LoginButton(
            isLoading: state.status == LoginStatus.loading,
            onTap: () {
              context.read<LoginBloc>().add(const LoginSubmitted());
            },
          ),
        ),
        const SizedBox(height: 20),
        const _Divider(),
        const SizedBox(height: 20),
        const _GoogleButton(),
        const SizedBox(height: 20),
        const _SignUpRow(),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    required this.isLoading,
    required this.onTap,
  });

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 40,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withValues(alpha: 0.3),
                ),
              ),
            ),
            child: const SizedBox(height: 1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'or continue with',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.withValues(alpha: 0.8),
            ),
          ),
        ),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withValues(alpha: 0.3),
                ),
              ),
            ),
            child: const SizedBox(height: 1),
          ),
        ),
      ],
    );
  }
}

class _GoogleButton extends StatelessWidget {
  const _GoogleButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const SizedBox(
          width: double.infinity,
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.g_mobiledata_rounded, size: 24, color: Colors.red),
              SizedBox(width: 8),
              Text(
                'Continue with Google',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpRow extends StatelessWidget {
  const _SignUpRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'Sign up',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.deepPurple,
            ),
          ),
        ),
      ],
    );
  }
}
