import '../../../../app_export.dart';
import '../widgets/bottom_widget.dart';

class UserNavigationScreen extends StatefulWidget {
  const UserNavigationScreen({super.key});

  @override
  State<UserNavigationScreen> createState() => _UserNavigationScreenState();
}

class _UserNavigationScreenState extends State<UserNavigationScreen> {

  final List<Widget> screens = [
    const UserHomeScreen(),
    const SearchScreen(),
    const ShortlistedScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          int index = state is NavigationInitial? state.index : 0;
          return IndexedStack(index: index, children: screens);
        },
      ),
      bottomNavigationBar: const BottomWidget(isUser: true,),
    );
  }
}
