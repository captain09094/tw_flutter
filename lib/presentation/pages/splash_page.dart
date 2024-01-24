import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trinity_lecture_app/core/routes/app_router.gr.dart';
import 'package:trinity_lecture_app/presentation/widgets/molecules/action_text.dart';
import 'package:trinity_lecture_app/presentation/widgets/molecules/platform_app_bar.dart';
import 'package:trinity_lecture_app/presentation/widgets/organisms/ui_helper.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PlatformAppBar(
        title: Text(
          'Starting Page',
        ),
      ),
      body: Padding(
        padding: UIHelper.padding(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            ActionText(
              onTap: () {
                AutoRouter.of(context).push(const CalcRoute());
              },
              title: 'Dummy UI',
              desc: 'Introducing Basic Flutter Widget UI',
            )
          ],
        ),
      ),
    );
  }
}
