import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app.dart';
import 'bloc/forgot_password_bloc.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(
        authRepository: context.read<AuthRepository>(),
      ),
      child: BlocListener<ForgotPasswordBloc, ForgotPasswordPageState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Reset link sent! Please check your email.'),
              ),
            );
          } else if (state.status == Status.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage ?? 'Failed to send reset link. Please try again.',
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
          icon: Icons.lock,
          iconColor: Color(0xFF534AB7),
          containerColor: Color(0xFFEEEDFE),
          size: 28,
        ),
        SizedBox(height: 10),
        Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Enter your email to reset your password',
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          BlocBuilder<ForgotPasswordBloc, ForgotPasswordPageState>(
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
                  context.read<ForgotPasswordBloc>().add(
                    ForgotPasswordEmailChanged(value),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 20),
          BlocBuilder<ForgotPasswordBloc, ForgotPasswordPageState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) => _LoginButton(
              isLoading: state.status == Status.loading,
              onTap: () {
                context.read<ForgotPasswordBloc>().add(
                  const ForgotPasswordSubmitted(),
                );
              },
            ),
          ),
          const Spacer(),
          const _Divider(),
          const SizedBox(height: 20),
          const _SignUpRow(),
        ],
      ),
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
          color: const Color(0xFF534ab7),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF534ab7),
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
                    'Send reset link',
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
          'Remember your password? ',
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
