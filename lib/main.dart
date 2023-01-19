import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha_bank/blocs/auth/auth_bloc.dart';
import 'package:sha_bank/blocs/user/user_bloc.dart';
import 'package:sha_bank/shared/theme.dart';
import 'package:sha_bank/ui/pages/data_package.dart';
import 'package:sha_bank/ui/pages/data_package_success.dart';
import 'package:sha_bank/ui/pages/data_provider_page.dart';
import 'package:sha_bank/ui/pages/home_page.dart';
import 'package:sha_bank/ui/pages/pin_page.dart';
import 'package:sha_bank/ui/pages/profile_edit_pin_page.dart';
import 'package:sha_bank/ui/pages/profile_edit_success.dart';
import 'package:sha_bank/ui/pages/profile_page.dart';
// import 'package:sha_bank/ui/pages/sign_up_page_profile.dart';
// import 'package:sha_bank/ui/pages/sign_up_page_set_ktp.dart';
import 'package:sha_bank/ui/pages/sign_up_page_success.dart';
// import 'package:sha_bank/ui/pages/top_up_amount_page.dart';
import 'package:sha_bank/ui/pages/top_up_page.dart';
import 'package:sha_bank/ui/pages/top_up_success.dart';
// import 'package:sha_bank/ui/pages/transfer_amount_page.dart';
import 'package:sha_bank/ui/pages/transfer_page.dart';
import 'package:sha_bank/ui/pages/transfer_user_success.dart';
import 'ui/pages/onboarding_page.dart';
import 'ui/pages/profile_edit_page.dart';
import 'ui/pages/signin_page.dart';
import 'ui/pages/signup_page.dart';
import 'ui/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()
            ..add(
              AuthCurrentUser(),
            ),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: lightBackgroundColor,
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: lightBackgroundColor,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: blackColor,
            ),
            titleTextStyle: blackTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 20,
            ),
          ),
        ),
        // home: SplashPage(),
        routes: {
          '/': (context) => const SplashPage(),
          '/onboarding': (context) => const OnboardingPage(),
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
          // '/sign-up-upload-profile': (context) =>
          //     const SignUpUploadProfilePage(),
          // '/sign-up-set-ktp': (context) => const SignUpSetKtpPage(),
          '/sign-up-success': (context) => const SignUpSuccessPage(),
          '/home-page': (context) => const HomePage(),
          '/profile-page': (context) => const ProfilePage(),
          '/edit-profile-page': (context) => const ProfileEditPage(),
          '/edit-profile-success': (context) => const ProfileEditSuccessPage(),
          '/pin': (context) => const PinPage(),
          '/pin-edit': (context) => const ProfileEditPinPage(),
          '/top-up': (context) => const TopUpPage(),
          // '/top-up-amount': (context) => const TopUpAmountPage(),
          '/top-up-success': (context) => const TopUpSuccessPage(),
          '/transfer': (context) => const TransferPage(),
          // '/transfer-amount': (context) => const TransferAmountPage(),
          '/transfer-success': (context) => const TransferSuccessPage(),
          '/data': (context) => const DataProviderPage(),
          // '/data-package': (context) => const DataPackage(),
          '/data-package-success': (context) => const DataPackageSuccessPage(),
        },
      ),
    );
  }
}
