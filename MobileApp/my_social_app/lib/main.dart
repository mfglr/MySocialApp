import 'dart:async';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_social_app/constants/routes.dart';
import 'package:my_social_app/global_error_handling.dart';
import 'package:my_social_app/state/account_state/account_state.dart';
import 'package:my_social_app/state/actions.dart';
import 'package:my_social_app/state/state.dart';
import 'package:my_social_app/state/store.dart';
import 'package:my_social_app/views/shared/loading_view.dart';
import 'package:my_social_app/views/account/login_view.dart';
import 'package:my_social_app/views/create_question/pages/display_images_page.dart';
import 'package:my_social_app/views/create_question/pages/select_exam_page.dart';
import 'package:my_social_app/views/create_question/pages/select_subject_page.dart';
import 'package:my_social_app/views/create_question/pages/select_topic_page.dart';
import 'package:my_social_app/views/create_question/pages/take_question_image_page.dart';
import 'package:my_social_app/views/create_solution/pages/create_solution_page.dart';
import 'package:my_social_app/views/create_solution/pages/take_solution_image_page.dart';
import 'package:my_social_app/views/message/pages/display_message_images.dart';
import 'package:my_social_app/views/message/pages/take_message_image_page.dart';
import 'package:my_social_app/views/question/pages/display_user_questions_page.dart';
import 'package:my_social_app/views/account/register_view.dart';
import 'package:my_social_app/views/user/pages/user_followeds_page.dart';
import 'package:my_social_app/views/user/pages/user_followers_page.dart';
import 'package:my_social_app/views/root_view.dart';
import 'package:my_social_app/views/account/verify_email_view.dart';

Future loadEnvironmentVariables() async {
  const bool isProduction = bool.fromEnvironment('dart.vm.product');
  await dotenv.load(fileName: isProduction ? ".env.prod" : ".env.dev");
}

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  final List<CameraDescription> cameras = await availableCameras();
  await loadEnvironmentVariables();

  FlutterError.onError = (error) {
    handleErrors(error.exception);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    handleErrors(error);
    return true;
  };
  
  runApp(
    StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: StoreConnector<AppState,bool>(
          onInit: (store) => store.dispatch(const InitAppAction()),
          converter: (store) => store.state.isInitialized,
          builder: (context, isInitialized){
            if(isInitialized){
              return StoreConnector<AppState,AccountState?>(
                converter: (store) => store.state.accountState,
                builder: (context,accountState){
                  if(accountState == null){
                    return StoreConnector<AppState,ActiveLoginPage>(
                      converter: (store) => store.state.activeLoginPage,
                      builder: (context,activeLoginPage){
                        if(activeLoginPage == ActiveLoginPage.loginPage) return const LoginView();
                        return const RegisterView();
                      },
                    );
                  }
                  if(!accountState.emailConfirmed) return const VerifyEmailView();
                  return const RootView();
                },
              );
            }
            return const LoadingView();
          }
        ),
        routes: {
          loginRoute: (context) => const LoginView(),
          registerRoute: (context) => const RegisterView(),
          verifyEmailRoute: (context) => const VerifyEmailView(),
          rootRoute: (context) => const RootView(),
          userFollowersRoute: (context) => const UserFollowersPage(),
          userFollowedsRoute: (context) => const UserFollowedsPage(),

          takeQuestionImageRoute: (context) => TakeQuestionImagePage(camera: cameras.first),
          displayQuestionImagesRoute: (context) => const DisplayImagesPage(),
          selectExamRoute: (context) => const SelectExamPage(),
          selectSubjectRoute: (context) => const SelectSubjectPage(),
          selectTopicRoute: (context) => const SelectTopicPage(),

          displayUserQuestionsRoute: (context) => const DisplayUserQuestionsPage(),
          
          createSolutionRoute: (context) => const CreateSolutionPage(),
          takeSolutionImageRoute: (context) => TakeSolutionImagePage(camera: cameras.first),

          takeMessageImageRoute: (context) => TakeMessageImagePage(camera: cameras.first),
          displayMessageImagesRoute: (context) => const DisplayMessageImages()
        },
      ),
    )
  );
}
