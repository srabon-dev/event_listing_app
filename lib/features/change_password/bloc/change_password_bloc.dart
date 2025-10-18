import '../../../app_export.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ILocalService db;
  final IChangePasswordRepository repository;

  ChangePasswordBloc({required this.db, required this.repository}) : super(ChangePasswordInitial()) {
    on<ChangePasswordAddNewEvent>(_onInsuranceAdd);
  }

  Future<void> _onInsuranceAdd(ChangePasswordAddNewEvent event, Emitter<ChangePasswordState> emit) async {
    try {
      emit(const ChangePasswordAddNewState(isLoading: true));
      final token = await db.getToken();

      final response = await repository.changePassword(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
        url: ApiUrls.changePassword(),
        token: token,
      );

      await response.fold((failure) async {
        emit(ChangePasswordAddNewState(isLoading: false, message: failure.message));
      }, (success) async {
        AppLogger.log("Password change successful");
        emit(const ChangePasswordAddNewState(isLoading: false, isVerified: true, message: "Password change successful"));
      },
      );
    } catch (e) {
      AppLogger.log(e.toString());
      emit(ChangePasswordAddNewState(isLoading: false, error: e.toString()));
    }
  }
}
