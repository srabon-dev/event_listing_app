import '../../../../app_export.dart';
import '../widgets/bottom_widget.dart';

class ManagementNavigationScreen extends StatefulWidget {
  const ManagementNavigationScreen({super.key});

  @override
  State<ManagementNavigationScreen> createState() => _ManagementNavigationScreenState();
}

class _ManagementNavigationScreenState extends State<ManagementNavigationScreen> {

  final List<Widget> screens = [
    const ManagementHomeScreen(),
    const EventAddScreen(),
    const MyEventScreen(),
    const ProfileScreen(isUser: false),
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
      bottomNavigationBar: const BottomWidget(),
    );
  }
}
