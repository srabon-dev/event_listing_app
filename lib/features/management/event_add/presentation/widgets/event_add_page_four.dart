import 'package:event_listing_app/app_export.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';

class EventAddPageFour extends StatelessWidget {
  const EventAddPageFour({
    super.key,
    required this.pageController,
    required this.formKey,
    required this.link,
    required this.eventFee,
    required this.quillController,
    required this.onTap,
    required this.onComplete,
  });

  final PageController pageController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onTap;
  final VoidCallback onComplete;

  final TextEditingController link;
  final TextEditingController eventFee;
  final QuillController quillController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text(
            context.loc.registrationEventDetails,
            style: context.headlineLarge.copyWith(fontWeight: FontWeight.w500),
          ),
          const Gap(12),
          CustomTextField(
            title: context.loc.eventWebsiteRegistrationLink,
            hintText: context.loc.googleForm_your_own_site_or_social_media_link,
            controller: link,
            validator: TextFieldValidator.website(context),
          ),
          CustomTextField(
            title: context.loc.eventRegistrationFee,
            hintText: r"$20",
            controller: eventFee,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: TextFieldValidator.required(context),
          ),
          CustomAlignText(text: context.loc.describeAboutYourEvent),
          QuillSimpleToolbar(
            controller: quillController,
            config: const QuillSimpleToolbarConfig(
                showFontFamily: false,
                showStrikeThrough: false,
                showInlineCode: false,
                showSubscript: false,
                showSuperscript: false,
                showBackgroundColorButton: false,
                showClearFormat: false,
                showListCheck: false,
                showCodeBlock: false,
                showQuote: true,
                showSearchButton: false,
                showLink: false,
                showUnderLineButton: false,
                showColorButton: false,
                showRedo: false,
                showUndo: false,
                sectionDividerColor: AppColors.brandHoverColor,
                color: AppColors.white,
                decoration: BoxDecoration(
                    color: AppColors.black
                ),
                iconTheme: QuillIconTheme(
                    iconButtonSelectedData: IconButtonData(
                      color: AppColors.softBrandColor,
                      focusColor: AppColors.softBrandColor,
                      isSelected: true,
                    ),
                    iconButtonUnselectedData: IconButtonData(
                      color: AppColors.skyLight,
                    )
                )
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.softBrandColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: QuillEditor.basic(
              controller: quillController,
              config: QuillEditorConfig(
                enableScribble: true,
                placeholder: context.loc.describeAboutYourEvent,
                paintCursorAboveText: true,
                maxContentWidth: 1000,
                showCursor: true,
                minHeight: 250,
              ),
            ),
          ),
          const Gap(12),
          Row(
            spacing: 24,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    final currentPage = pageController.page?.round() ?? 0;
                    if (currentPage > 0) {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      AppLogger.log("Already on the first page");
                    }
                  },
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.white),
                    foregroundColor: WidgetStatePropertyAll(AppColors.brandHoverColor),
                    side: WidgetStatePropertyAll(
                      BorderSide(color: AppColors.brandHoverColor, width: 1.5),
                    ),
                  ),
                  child: Text(context.loc.previous),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final plainText = quillController.document.toPlainText().trim();
                      if (plainText.isEmpty) {
                        AppToast.warning(message: context.loc.pleaseDescribeYourEvent);
                        return;
                      }

                      onTap.call();
                    }
                  },
                  child: BlocConsumer<EventAddBloc, EventAddState>(
                    listener: (context, state) {
                      if (state is EventState) {
                        if (state.message != null) {
                          AppToast.info(context: context, message: state.message ?? "");
                        }
                        if (state.isVerified) {
                          onComplete.call();
                        }
                      }
                    },
                    builder: (context, state) {
                      final data = state is EventState && state.isLoading;
                      if(data) {
                        return const LoadingWidget();
                      }
                      return Text(context.loc.savePublish);
                    },
                  ),
                ),
              ),
            ],
          ),
          const Gap(44),
        ],
      ),
    );
  }
}
