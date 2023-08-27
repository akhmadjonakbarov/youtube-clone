import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/app/screens/main/main_screen.dart';
import 'app/common/controllers/blocs/channel/channel_bloc.dart';
import 'app/common/controllers/blocs/video/video_bloc.dart';
import 'app/screens/authentication/controllers/blocs/authentication/authentication_bloc.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (context) => VideoBloc(),
        ),
        BlocProvider(
          create: (context) => ChannelBloc(),
        )
      ],
      child: const MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: MainScreen(),
        ),
      ),
    );
  }
}
