import 'package:flutter/material.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.displayName});

  final String displayName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Successfull logged as $displayName',
        style: TextStyle(fontSize: 22, color: AppColors.primary),
      ),
    );
  }
}
