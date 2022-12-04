import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:train_app/pages/boarding_pass.dart';
import 'package:train_app/pages/home.dart';
import 'package:train_app/pages/home_page.dart';
import 'package:train_app/pages/login_page.dart';
import 'package:train_app/pages/my_tickets.dart';

import 'package:train_app/pages/sign_up_page.dart';
import 'package:train_app/pages/thanks.dart';
import 'package:train_app/pages/ticket_options.dart';
import 'package:train_app/widgets/train_seats.dart';

import 'authentication/auth.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
      debugLogDiagnostics: true,
      redirect: (state) {
        bool loggedIn = ref.watch(loginStatusProvider);
        final loginLoc = state.namedLocation('login');
        final loggingIn = state.subloc == loginLoc;
        final createAccountLoc = state.namedLocation('signup');
        final creatingAccount = state.subloc == createAccountLoc;
        final homeLoc = state.namedLocation('home');

        if (!loggedIn && !loggingIn && !creatingAccount) return loginLoc;
        if (loggedIn && (loggingIn || creatingAccount)) return homeLoc;

        return null;
      },
      initialLocation: '/login',
      routes: [
        GoRoute(
          name: 'login',
          path: '/login',
          builder: (context, state) {
            return const LoginPage();
          },
        ),
        GoRoute(
            name: 'signup',
            path: '/signup',
            builder: (context, state) {
              return const SignUpPage();
            }),
        GoRoute(
            name: 'home',
            path: '/home',
            builder: (context, state) {
              return const HomePage();
            }),
        GoRoute(
            name: 'search',
            path: '/search',
            builder: (context, state) {
              return const SearchTripPage();
            }),
        GoRoute(
            name: 'options',
            path: '/options',
            builder: (context, state) {
              return const TicketOptionsPage();
            }),
        GoRoute(
            name: 'seats',
            path: '/seats',
            builder: (context, state) {
              return const TrainSeat();
            }),
        GoRoute(
            name: 'myTickets',
            path: '/myTickets',
            builder: (context, state) {
              return const MyTickets();
            }),
        GoRoute(
            name: 'ticket',
            path: '/ticket',
            builder: (context, state) {
              return const BoardingPassPage();
            }),
        GoRoute(
            name: 'thanks',
            path: '/thanks',
            builder: (context, state) {
              return const ThankYou();
            }),
      ]);
});
