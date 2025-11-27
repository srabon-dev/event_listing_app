import 'package:event_listing_app/app_export.dart';

class SearchDrawer extends StatelessWidget {
  const SearchDrawer({
    super.key,
    required this.controller,
    required this.zipCode,
    required this.selectedSportType,
    required this.selectedEventType,
    required this.selectedAgesGroup,
    required this.selectedSkillLevel,
    required this.selectedStatus,
  });

  final SearchScreenCubit controller;
  final TextEditingController zipCode;
  final ValueNotifier<String?> selectedSportType;
  final ValueNotifier<String?> selectedEventType;
  final ValueNotifier<String?> selectedAgesGroup;
  final ValueNotifier<String?> selectedSkillLevel;
  final ValueNotifier<String?> selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.softBrandColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            spacing: 8,
            children: [
              CustomTextField(
                controller: zipCode,
                fillColor: AppColors.white,
                title: context.loc.location,
                hintText: context.loc.location_ZIP_Code_or_City,
              ),
              CustomAlignText(text: context.loc.sport),
              BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const LoadingWidget();
                  }

                  if (state is CategoryError) {
                    return ErrorCard(onTap: () {  }, text: state.message,);
                  }

                  if (state is CategoryLoaded && state.categories.getSports().isNotEmpty) {
                    final displayItems = state.categories.getSports().toList();

                    final selectedEntity = displayItems.cast<CategoryEntities?>().firstWhere(
                      (e) => e?.id == selectedSportType.value,
                      orElse: () => null,
                    );

                    return CustomDropdownField<CategoryEntities>(
                      hintText: context.loc.selectOne,
                      items: displayItems,
                      labelBuilder: (s) => s.name,
                      value: selectedEntity,
                      isRequired: true,
                      onChanged: (value) {
                        selectedSportType.value = value?.id;
                      },
                    );
                  }
                  return const NoDataCard(
                    text: "Category will appear once they’re available.",
                  );
                },
              ),
              CustomAlignText(text: context.loc.ageGroup),
              CustomDropdownField(
                hintText: context.loc.selectOne,
                value: selectedAgesGroup.value,
                validator: TextFieldValidator.required(context),
                items: const [
                  "Any Age",
                  "5–7 years",
                  "8–10 years",
                  "11–13 years",
                  "14–16 years",
                  "17+ years",
                ],
                onChanged: (value) {
                  if (value != null) {
                    selectedAgesGroup.value = value;
                  }
                },
              ),
              CustomAlignText(text: context.loc.eventType),
              BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const LoadingWidget();
                  }

                  if (state is CategoryError) {
                    return ErrorCard(onTap: () {  }, text: state.message,);
                  }

                  if (state is CategoryLoaded && state.categories.getSports().isNotEmpty) {
                    final displayItems = state.categories.getEvents().toList();

                    final selectedEntity = displayItems.cast<CategoryEntities?>().firstWhere(
                      (e) => e?.id == selectedEventType.value,
                      orElse: () => null,
                    );

                    return CustomDropdownField<CategoryEntities>(
                      hintText: context.loc.selectOne,
                      labelBuilder: (s) => s.name,
                      items: displayItems,
                      value: selectedEntity,
                      onChanged: (value) {
                        selectedEventType.value = value?.id;
                      },
                    );
                  }
                  return const NoDataCard(
                    text: "Event will appear once they’re available.",
                  );
                },
              ),
              CustomAlignText(text: context.loc.skillLevel),
              CustomDropdownField(
                hintText: context.loc.selectOne,
                items: const ["Intermediate", "Beginner", "Advanced"],
                value: selectedSkillLevel.value,
                onChanged: (value) {
                  if (value != null) {
                    selectedSkillLevel.value = value;
                  }
                },
              ),
              CustomAlignText(text: context.loc.status),
              CustomDropdownField(
                hintText: context.loc.selectOne,
                value: selectedStatus.value,
                items: const ["Upcoming", "Registration Open", "Event Started", "Event Finished"],
                onChanged: (value) {
                  selectedStatus.value = value;
                },
              ),
              const Gap(12),
              CustomButton(
                text: context.loc.apply_filter,
                onTap: () {
                  AppRouter.route.pop();
                  controller.pagingController.refresh();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
