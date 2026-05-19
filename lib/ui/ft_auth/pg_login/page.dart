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
        child: const SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
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
    return Expanded(
      child: IntrinsicHeight(
        child: Column(
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
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    size: 20,
                    color: Colors.grey,
                  ),
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
                  previous.obscurePassword != current.obscurePassword ||
                  previous.passwordError != current.passwordError,
              builder: (context, state) {
                return AppTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: AppFormFieldBorder.roundedOutlined,
                  prefixIcon: const Icon(
                    Icons.lock_outlined,
                    size: 20,
                    color: Colors.grey,
                  ),
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
              builder: (context, state) => AppButton(
                label: 'Sign in',
                isLoading: state.status == LoginStatus.loading,
                containerColor: const Color(0xFF534ab7),
                onTap: () {
                  context.read<LoginBloc>().add(const LoginSubmitted());
                },
              ),
            ),
            const SizedBox(height: 20),
            const _Divider(middleText: 'or continue with'),
            const SizedBox(height: 20),
            BlocBuilder<LoginBloc, LoginPageState>(
              buildWhen: (previous, current) => previous.status != current.status,
              builder: (context, state) => AppButton(
                label: 'Continue with Google',
                fontSize: 14,
                isLoading: state.status == LoginStatus.loading,
                enablePrefixIcon: true,
                prefixIcon: Icons.g_mobiledata_rounded,
                iconColor: Colors.red,
                iconSize: 24,
                onTap: () {
                  context.read<LoginBloc>().add(const LoginSubmitted());
                },
              ),
            ),
            const Spacer(),
            const _SignUpRow(),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({this.middleText});

  final String? middleText;

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
        if (middleText != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              middleText!,
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
      ],
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
          onTap: () {
            context.router.push(const RegisterRoute());
          },
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
