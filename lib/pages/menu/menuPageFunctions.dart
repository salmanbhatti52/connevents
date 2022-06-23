import 'package:connevents/pages/Dashboard/dashboard-page.dart';
import 'package:connevents/pages/bookRoom/eventsRoom.dart';
import 'package:connevents/pages/eventGuestList/eventGuestListPage.dart';
import 'package:connevents/pages/eventLibrary/eventLibraryPage.dart';
import 'package:connevents/pages/favorites/favoritesPage.dart';
import 'package:connevents/pages/help/helpPage.dart';
import 'package:connevents/pages/interestCategories/interest-categories.dart';
import 'package:connevents/pages/myportfolio/my-portfolio.dart';
import 'package:connevents/pages/notifications/notificationsPage.dart';
import 'package:connevents/pages/paymentMethods/paymentMethodsPage.dart';
import 'package:connevents/pages/privacy%20policy/privacy-policy.dart';
import 'package:connevents/pages/profile/profilePage.dart';
import 'package:connevents/pages/refundRequests/refundRequestsPage.dart';
import 'package:connevents/pages/rewards/rewardsPage.dart';
import 'package:connevents/pages/setting.dart';
import 'package:connevents/pages/terms%20and%20condition/terms-and-condition.dart';
import 'package:connevents/pages/ticketHistory/ticketHistoryPage.dart';
import 'package:connevents/pages/wallet/walletPage.dart';
import 'package:connevents/widgets/custom-navigator.dart';

executeActivitiesOption(val, context) {
  print('options is: $val');
  switch (val) {
    case 'Payment Method':
     // CustomNavigator.navigateTo(context, PaymentMethodsPageWithoutPayButton());
      CustomNavigator.navigateTo(context, PaymentMethodsPage(isPay: false,fromMenu: true));
      // Navigator.pushNamed(context, '/paymentMethodswithoutPay');
      break;
    case 'Dashboard':
      CustomNavigator.navigateTo(context, DashboardPage());
      // Navigator.pushNamed(context, '/eventDashboard');
      break;
     case 'Favorite Events':
      CustomNavigator.navigateTo(context, FavoritesPage(isShowPeeks: false));
      // Navigator.pushNamed(context, '/eventDashboard');
      break;
    case 'Refund Requests':
      CustomNavigator.navigateTo(context, RefundRequestsPage());
      // Navigator.pushNamed(context, '/refundRequests');
      break;
    case 'Event Guests List':
      CustomNavigator.navigateTo(context, EventGuestListPage());
      // Navigator.pushNamed(context, '/eventGuestList');
      break;
    case 'Ticket Library':
      CustomNavigator.navigateTo(context, TicketLibraryPage());
      // Navigator.pushNamed(context, '/ticketHistory');
      break;
    case 'Event Catalog':
      CustomNavigator.navigateTo(context, EventLibraryPage());
      // Navigator.pushNamed(context, '/eventLibrary');
      break;
    case 'Interest Categories':
      CustomNavigator.navigateTo(context, InterestCategoriesPage());
      // Navigator.pushNamed(context, '/selectCategories');
      break;
    case 'Your Rewards':
      CustomNavigator.navigateTo(context, RewardsPage());
      // Navigator.pushNamed(context, '/rewards');
      break;
    case 'My Portfolio':
      CustomNavigator.navigateTo(context, MyPortfolio());
      // Navigator.pushNamed(context, '/wallet');
      break;
     case 'My Earnings':
      CustomNavigator.navigateTo(context, WalletPage());
      // Navigator.pushNamed(context, '/wallet');
      break;
    case 'Book Room':
      CustomNavigator.navigateTo(context,EventsRoomPage());
      // Navigator.pushNamed(context, '/eventsRoom');
      break;
  }
}

executeSettingsOption(val, context) {
  print('options is: $val');
  switch (val) {
    case 'Profile':
      CustomNavigator.navigateTo(context, ProfilePage());
      // Navigator.pushNamed(context, '/profile');
      break;
    case 'Notifications':
      CustomNavigator.navigateTo(context, NotificationsPage());
      // Navigator.pushNamed(context, '/notifications');
      break;
    case 'Help':
      CustomNavigator.navigateTo(context, HelpPage());
      // Navigator.pushNamed(context, '/help');
      break;
    case 'Notification Settings':
      CustomNavigator.navigateTo(context, SettingPage());
      // Navigator.pushNamed(context, '/setting');
      break;
    case 'Terms & Conditions':
      CustomNavigator.navigateTo(context, TermsAndCondition());
      // Navigator.pushNamed(context, '/help');
      break;
    case 'Privacy & Policy':
      CustomNavigator.navigateTo(context, PrivacyPolicy());
      // Navigator.pushNamed(context, '/help');
      break;
  }
}
