import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app.dart';
import 'bloc/profile_bloc.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        authRepository: context.read<AuthRepository>(),
      )..add(const ProfileLoadRequested()),
      child: BlocListener<ProfileBloc, ProfilePageState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
          } else if (state.status == ProfileStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Something went wrong'),
              ),
            );
          }
        },
        child: BlocBuilder<ProfileBloc, ProfilePageState>(
          builder: (context, state) {
            if (_nameController.text != state.fullName) {
              _nameController.text = state.fullName;
            }

            return Scaffold(
              appBar: const CustomAppBar(
                title: 'Profile',
                subtitle: 'Manage your account',
                titleSize: 16,
                subtitleSize: 13,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _ProfilePicture(),
                            const SizedBox(height: 28),
                            AppTextField(
                              controller: _nameController,
                              labelText: 'Full name',
                              hintText: 'Enter your full name',
                              border: AppFormFieldBorder.roundedOutlined,
                              prefixIcon: const Icon(
                                Icons.person_outline_rounded,
                                size: 20,
                                color: Colors.grey,
                              ),
                              clearable: true,
                              onChanged: (value) {
                                context.read<ProfileBloc>().add(ProfileFullNameChanged(value));
                              },
                            ),
                            const SizedBox(height: 16),
                            AppTextField(
                              enabled: false,
                              readonly: true,
                              labelText: state.email,
                              border: AppFormFieldBorder.roundedOutlined,
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                size: 20,
                                color: Colors.grey,
                              ),
                              suffixIcon: const Icon(
                                Icons.lock_outline_rounded,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppButton(
                      label: 'Save changes',
                      containerColor: const Color(0xFF534ab7),
                      onTap: () {
                        context.read<ProfileBloc>().add(const ProfileSavePressed());
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProfilePicture extends StatelessWidget {
  const _ProfilePicture();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFEEEDFE),
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  size: 36,
                  color: Color(0xFF534AB7),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    // pick image
                  },
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF534AB7),
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      size: 13,
                      color: Color(0xFFEEEDFE),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              // pick image
            },
            child: const Text(
              'Change photo',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF534AB7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
