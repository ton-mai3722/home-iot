import 'package:go_router/go_router.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/signup_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/room/presentation/pages/room_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Splash
    GoRoute(path: '/', builder: (context, state) => const SplashPage()),

    // Auth Routes
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/signup', builder: (context, state) => const SignUpPage()),

    // Main App Routes
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    GoRoute(
      path: '/room/:roomId',
      builder: (context, state) {
        final roomId = state.pathParameters['roomId']!;
        return RoomPage(roomId: roomId);
      },
    ),
    GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
  ],
);
