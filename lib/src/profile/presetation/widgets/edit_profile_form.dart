import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/extensions/string_extentions.dart';
import 'package:education_app/src/profile/presetation/widgets/edit_profile_form_field.dart';
import 'package:flutter/material.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.bioController,
    required this.oldPasswordController,
    super.key,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController bioController;
  final TextEditingController oldPasswordController;

  @override
  Widget build(BuildContext context) {
    final user = context.currentUser!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditProfileFormField(
          fieldTitle: 'FULL NAME',
          controller: fullNameController,
          hintText: user.fullName,
        ),
        const SizedBox(
          height: 30,
        ),
        EditProfileFormField(
          fieldTitle: 'EMAIL',
          controller: emailController,
          hintText: user.email.obscureEmail,
        ),
        const SizedBox(
          height: 30,
        ),
        EditProfileFormField(
          fieldTitle: 'CURRENT PASSWORD',
          controller: oldPasswordController,
          hintText: '*********',
        ),
        const SizedBox(
          height: 30,
        ),
        StatefulBuilder(
          builder: (_, setState) {
            oldPasswordController.addListener(() => setState(() {}));
            return EditProfileFormField(
              fieldTitle: 'NEW PASSWORD',
              controller: passwordController,
              hintText: '*********',
              readOnly: oldPasswordController.text.isEmpty,
            );
          },
        ),
        const SizedBox(
          height: 30,
        ),
        EditProfileFormField(
          fieldTitle: 'BIO',
          controller: bioController,
          hintText: 'Bio',
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
