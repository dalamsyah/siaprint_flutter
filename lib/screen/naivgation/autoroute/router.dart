import 'package:auto_route/annotations.dart';
import 'package:siapprint/screen/account_setting.dart';
import 'package:siapprint/screen/form_print_page.dart';
import 'package:siapprint/screen/home_page.dart';
import 'package:siapprint/screen/upload_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: HomePage,
      children: [
        AutoRoute(
          path: 'posts',
          name: 'PostsRouter',
          page: AccountSettingPage,
          children: [
            AutoRoute(path: '', page: UploadPage),
          ],
        ),
      ]
    )
  ],
)
class $AppRouter {}