/*
import '../../../../app_export.dart';
import '../../../profile/cubit/profile_cubit.dart';
import '../../../profile/domain/entities/profile_entity.dart';
import '../../cubit/profile_edit_cubit.dart';
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

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    name = TextEditingController(text: widget.profile.name);
    super.initState();
  }

  @override
  void dispose() {
    selectedImage.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: CustomText(
            text: AppLocalizations.of(context)!.editProfile,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocConsumer<ProfileEditCubit, ProfileEditState>(
                listener: (context, state) async{
                  try{
                    if (state is ProfileUpdate) {
                      if (state.message != null) {
                        AppToast.show(context: context, message: state.message);
                      }
                      if (state.isVerified) {
                        context.read<ProfileCubit>().fetchProfile();

                        AppRouter.route.pop();
                      }
                    }
                  }catch (e){
                    AppLogger.log(e.toString());
                    if(context.mounted) {
                      AppToast.show(
                        context: context,
                        message: AppLocalizations.of(context)!.somethingWentWrong,
                      );
                    }
                  }
                },
                builder: (context, ProfileEditState stateSate) {
                  final isLoading = stateSate is ProfileUpdate && stateSate.isLoading;
                  return CustomButton(
                    text: AppLocalizations.of(context)!.save,
                    isLoading: isLoading,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ProfileEditCubit>().updateProfile(
                          name: name.text,
                          imagePath: selectedImage.value ?? "",
                        );
                      }
                    },
                  );
                },
              ),
            ],
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
