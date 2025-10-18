part of 'navigation_cubit.dart';

sealed class NavigationState extends Equatable {
  const NavigationState();
}

final class NavigationInitial extends NavigationState {
  final int index;
  const NavigationInitial(this.index);

  @override
  List<Object> get props => [index];
}
