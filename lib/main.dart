import 'package:daily_app/presentation/bloc/home/home_event.dart';
import 'package:daily_app/presentation/widgets/widgets/home_screen.dart' show HomeScreen;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'data/datasources/user_remote_datasource.dart';
import 'data/repositories/user_repository.dart';
import 'presentation/bloc/home/home_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final remoteDataSource = UserRemoteDataSource();

  final repository = UserRepository(
    remoteDataSource: remoteDataSource,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(
            repository: repository,
          )..add(FetchUsers()),
        ),
      ],
      child: const DailyApp(),
    ),
  );
}

class DailyApp extends StatelessWidget {
  const DailyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}