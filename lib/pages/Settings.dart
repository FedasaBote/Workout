import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_config.dart';
import '../states/LanguageCubit/language_cubit.dart';
import '../utils/enums.dart';
import '../widgets/BMIInfo.dart';
import '../widgets/FunctionalSettings.dart';
import '../widgets/CustomTile.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: IntrinsicWidth(
            child: Padding(
              padding: EdgeInsets.all(width * 0.05),
              child: Column(
                children: [
                  const BMIInfo(),
                  const Divider(height: 1, color: Colors.black),
                  const FunctionalSettings(),
                  SizedBox(height: width * 0.1),
                  CustomTile(
                      title: state.language == Language.eng ? "SHARE US" : "ПОДЕЛИТЬСЯ",
                      image: "assets/images/icons/share.png",
                      addForwardIcon: true,
                      onTap: () async {
                        Share.share('Check out this app: ${AppConfig.playStoreUrl}');
                      }
                  ),
                  CustomTile(
                      title: state.language == Language.eng ? "RATE US" : "ОЦЕНИТЕ НАС",
                      image: "assets/images/icons/rate.png",
                      addForwardIcon: true,
                      onTap: () async {
                        final url = Uri.parse(AppConfig.playStoreUrl);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      },
                  ),
                  SizedBox(height: width * 0.1),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
