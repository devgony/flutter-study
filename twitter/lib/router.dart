import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter/views/create_account_screen.dart';
import 'package:twitter/views/customize_experience_screen.dart';
import 'package:twitter/views/interest_detail_screen.dart';
import 'package:twitter/views/interest_screen.dart';
import 'package:twitter/views/otp_screen.dart';
import 'package:twitter/views/sign_up_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    // initialLocation: "/home",
    initialLocation: "/otp",
    // redirect: (context, state) {
    //   return null;
    // },
    routes: [
      GoRoute(
        name: SignUpScreen.routeName,
        path: SignUpScreen.routeURL,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        name: CreateAccountScreen.routeName,
        path: CreateAccountScreen.routeURL,
        builder: (context, state) {
          // if (state.extra == null) {
          return const CreateAccountScreen();
          // }
          // final args = state.extra as CreateAccountScreenArgs;
          // return CreateAccountScreen(agreed: args.agreed);
        },
      ),
      GoRoute(
        name: CustomizeExperienceScreen.routeName,
        path: CustomizeExperienceScreen.routeURL,
        builder: (context, state) => const CustomizeExperienceScreen(),
      ),
      GoRoute(
        name: OtpScreen.routeName,
        path: OtpScreen.routeURL,
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        name: InterestScreen.routeName,
        path: InterestScreen.routeURL,
        builder: (context, state) => const InterestScreen(),
      ),
      GoRoute(
        name: InterestDetailScreen.routeName,
        path: InterestDetailScreen.routeURL,
        builder: (context, state) => const InterestDetailScreen(),
      ),
    ],
  );
});
