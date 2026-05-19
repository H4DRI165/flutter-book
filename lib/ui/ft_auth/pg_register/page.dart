import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app.dart';
import 'bloc/register_bloc.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        authRepository: context.read<AuthRepository>(),
      ),
      child: BlocListener<RegisterBloc, RegisterPageState>(
        listener: (context, state) {
          if (state.status == RegisterStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Create account successfully.',
                ),
              ),
            );
            context.router.replace(const LoginRoute());
          } else if (state.status == RegisterStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage ?? 'Register failed. Please try again.',
                ),
              ),
            );
          }
        },
        child: const SafeArea(
          child: Scaffold(
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
          icon: Icons.person_add_alt_1_outlined,
          iconColor: Color(0xFF534AB7),
          containerColor: Color(0xFFEEEDFE),
          size: 28,
        ),
        SizedBox(height: 10),
        Text(
          'Create an account',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Start your learning your journey today',
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
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          BlocBuilder<RegisterBloc, RegisterPageState>(
            buildWhen: (previous, current) => previous.emailError != current.emailError,
            builder: (context, state) {
              return AppTextField(
                controller: _emailController,
                labelText: 'Email your email',
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
                  context.read<RegisterBloc>().add(RegisterEmailChanged(value));
                },
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<RegisterBloc, RegisterPageState>(
            buildWhen: (previous, current) =>
                previous.obscurePassword != current.obscurePassword || previous.passwordError != current.passwordError,
            builder: (context, state) {
              return AppTextField(
                controller: _passwordController,
                labelText: 'Create a password',
                hintText: 'Create a password',
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
                    context.read<RegisterBloc>().add(const RegisterObscurePasswordToggled());
                  },
                ),
                onChanged: (value) {
                  context.read<RegisterBloc>().add(RegisterPasswordChanged(value));
                },
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<RegisterBloc, RegisterPageState>(
            buildWhen: (previous, current) =>
                previous.obscureConfirmPassword != current.obscureConfirmPassword ||
                previous.confirmPasswordError != current.confirmPasswordError,
            builder: (context, state) {
              return AppTextField(
                controller: _confirmPasswordController,
                labelText: 'Confirm your password',
                hintText: 'Confirm your password',
                border: AppFormFieldBorder.roundedOutlined,
                prefixIcon: const Icon(
                  Icons.lock_outlined,
                  size: 20,
                  color: Colors.grey,
                ),
                errorText: state.confirmPasswordError,
                obscureText: state.obscureConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    state.obscureConfirmPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                  ),
                  onPressed: () {
                    context.read<RegisterBloc>().add(
                      const RegisterObscureConfirmPasswordToggled(),
                    );
                  },
                ),
                onChanged: (value) {
                  context.read<RegisterBloc>().add(
                    RegisterConfirmPasswordChanged(value),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 20),
          BlocBuilder<RegisterBloc, RegisterPageState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) => AppButton(
              label: 'Create account',
              isLoading: state.status == RegisterStatus.loading,
              containerColor: const Color(0xFF534ab7),
              onTap: () {
                context.read<RegisterBloc>().add(const RegisterSubmitted());
              },
            ),
          ),
          const SizedBox(height: 20),
          const _Divider(),
          const SizedBox(height: 20),
          const _GoogleButton(),
          const Spacer(),
          const _LoginRow(),
        ],
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

class _LoginRow extends StatelessWidget {
  const _LoginRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        GestureDetector(
          onTap: () {
            context.router.maybePop();
          },
          child: const Text(
            'Sign in',
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
