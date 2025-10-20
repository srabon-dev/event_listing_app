import '../../../../app_export.dart';
import '../widgets/profile_edit_inputs_widget.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key, required this.profile});
  final ProfileEntity profile;

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final ValueNotifier<String?> selectedImage = ValueNotifier(null);
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    name = TextEditingController(text: widget.profile.name);
    phone = TextEditingController(text: widget.profile.name);
    location = TextEditingController(text: widget.profile.name);
    super.initState();
  }

  @override
  void dispose() {
    selectedImage.dispose();
    name.dispose();
    phone.dispose();
    location.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.loc.editProfile,
            style: context.titleMedium,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 24,
              children: [
                ProfileEditInputsWidget(
                  selectedImage: selectedImage,
                  profileImage: widget.profile.profileImage,
                  name: name,
                  phone: phone,
                  location: location,
                ),
                BlocConsumer<ProfileEditCubit, ProfileEditState>(
                  listener: (context, state) async{
                    try{
                      if (state is ProfileUpdate) {
                        if (state.message != null) {
                          AppToast.success(context: context, message: state.message);
                        }
                        if (state.isVerified) {
                          context.read<ProfileCubit>().fetchProfile();
                          AppRouter.route.pop();
                        }
                      }
                    }catch (e){
                      AppLogger.log(e.toString());
                      if(context.mounted) {
                        AppToast.error(
                          context: context,
                          message: AppLocalizations.of(context)!.somethingWentWrong,
                        );
                      }
                    }
                  },
                  builder: (context, ProfileEditState stateSate) {
                    final isLoading = stateSate is ProfileUpdate && stateSate.isLoading;
                    return CustomButton(
                      text: context.loc.continueText,
                      isLoading: isLoading,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          /*context.read<ProfileEditCubit>().updateProfile(
                            name: name.text,
                            imagePath: selectedImage.value ?? "",
                          );*/
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
