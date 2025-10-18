part of 'onboarding_cubit.dart';

abstract class OnboardingState extends Equatable{}

class OnboardingInitial extends OnboardingState {
  final int index;
  OnboardingInitial(this.index);

  @override
  List<Object?> get props => [index];
}

class ChangeIndexState extends OnboardingState {
  final int index;
  ChangeIndexState(this.index);

  @override
  List<Object?> get props => [index];
}
