part of 'support_cubit.dart';

sealed class SupportState extends Equatable {
  const SupportState();
}

final class OtherSupportState extends SupportState {
  final ApiStatus status;
  final FaqModel faqModel;
  const OtherSupportState({required this.status, required this.faqModel});

  @override
  List<Object> get props => [status, faqModel];
}
