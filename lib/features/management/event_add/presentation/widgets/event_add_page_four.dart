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
    required this.actionWidget,
  });

  final PageController pageController;
  final GlobalKey<FormState> formKey;

  final TextEditingController link;
  final TextEditingController eventFee;
  final QuillController quillController;
  final Widget actionWidget;

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
            hintText: "e.g., Google Form, your own site, or social media link",
            controller: link,
            validator: TextFieldValidator.website(context),
          ),
          CustomTextField(
            title: context.loc.eventRegistrationFee,
            hintText: r"$20",
            controller: eventFee,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
          actionWidget,
          const Gap(44),
        ],
      ),
    );
  }
}
