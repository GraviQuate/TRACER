import 'package:flutter/material.dart';
import 'package:tracer/auth/auth_service.dart';
import 'package:tracer/widgets/gradient_border_button.dart';
import 'package:tracer/widgets/gradient_icon.dart';
import 'package:tracer/widgets/labeled_field.dart';
import 'package:tracer/widgets/titled_card.dart';
import '../utils/constants.dart';
import '../widgets/gradient_border_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final authService = AuthService(Supabase.instance.client);
  final double mainColumnSpacing = 20.0;
  final double sectionSpacing = 60.0;

  void logout() async {
    await authService.logOut();

    if (mounted) {
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
      ScaffoldMessenger.of(context).showSnackBar(
        GradientBorderSnackbar(message: 'Log out successful!')
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: AppDesign.appLightGray,
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                spacing: mainColumnSpacing,
                children: [
                  Center(
                    child: GradientIcon(
                      icon: Icons.account_circle,
                      size: 96.0,
                      gradient: LinearGradient(
                        colors: [
                          AppDesign.primaryGradientStart,
                          AppDesign.primaryGradientEnd,
                        ],
                      ),
                    ),
                  ),

                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: sectionSpacing,
                      children: [
                        TitledCard(
                          title: 'Profile Details',
                          icon: GradientIcon(
                            icon: Icons.account_circle,
                            size: 28.0,
                            gradient: LinearGradient(
                              colors: [
                                AppDesign.primaryGradientStart,
                                AppDesign.primaryGradientEnd,
                              ],
                            ),
                          ),
                          children: [
                            _LabeledText(
                              label: 'Full Name',
                              value: '',
                            ),
                            _LabeledText(
                              label: 'Email',
                              value: '',
                            ),
                            _LabeledText(
                              label: 'Student Number',
                              value: '',
                            ),
                            _LabeledText(
                              label: 'Year and Bloc',
                              value: '',
                            ),
                            _LabeledText(
                              label: 'Organization',
                              value: '',
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                              child: GradientBorderButton(
                                onPressed: () async {
                                  // Edit logic here
                                },
                                borderRadius: BorderRadius.circular(30.0),
                                gradient: const LinearGradient(
                                  colors: [
                                    AppDesign.primaryGradientStart,
                                    AppDesign.primaryGradientEnd
                                  ]
                                ),
                                child: const Text(
                                  'Edit',
                                  style: AppDesign.buttonTextStyle,
                                ),
                              ),
                            )
                          ]
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            spacing: mainColumnSpacing,
                            children: [
                              GradientBorderButton(
                                onPressed: () async {

                                },
                                borderRadius: BorderRadius.circular(30.0),
                                gradient: LinearGradient(
                                  colors: [
                                    AppDesign.dangerRed,
                                    AppDesign.dangerRed,
                                  ]
                                ),
                                child: Text(
                                  'Change Password',
                                  style: AppDesign.buttonTextStyle,
                                ),
                              ),
                              GradientBorderButton(
                                onPressed: () async {
                                  logout();
                                },
                                borderRadius: BorderRadius.circular(30.0),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white,
                                  ]
                                ),
                                child: Text(
                                  'Log Out',
                                  style: AppDesign.buttonTextStyle,
                                ),
                              ),
                              Text(
                                'TRACER v2',
                                style: AppDesign.bodyStyle,
                              ),
                              SizedBox(height: sectionSpacing-30.0)
                            ],
                          ),
                        ),
                      ],
                    ),
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

class _LabeledText extends StatelessWidget {
  final String label;
  final String value;

  const _LabeledText({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppDesign.bodyStyle,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: AppDesign.appLightGray,
            borderRadius: BorderRadius.circular(30.0)
          ),
          child: Text(
            value,
            style: AppDesign.bodyStyle,
          ),
        ),
      ],
    );
  }
}
