import 'package:event_listing_app/app_export.dart';
import 'package:flutter_quill/flutter_quill.dart';

class EventAddPageFour extends StatelessWidget {
  const EventAddPageFour({
    super.key,
    required this.pageController,
    required this.formKey,
    required this.link,
    required this.eventFee,
    required this.quillController,
  });

  final PageController pageController;
  final GlobalKey<FormState> formKey;

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
            validator: TextFieldValidator.required(context),
          ),
          CustomTextField(
            title: context.loc.eventRegistrationFee,
            hintText: r"$20",
            controller: eventFee,
            validator: TextFieldValidator.required(context),
          ),
          CustomAlignText(text: context.loc.describeAboutYourEvent),
          QuillSimpleToolbar(
            controller: quillController,
            config: const QuillSimpleToolbarConfig(
              showFontFamily: false,
              showStrikeThrough: false,
              showInlineCode: true,
              showSubscript: false,
              showSuperscript: false,
              showBackgroundColorButton: false,
              showClearFormat: false,
              showListCheck: false,
              showCodeBlock: true,
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
          QuillEditor.basic(
            controller: quillController,
            config: const QuillEditorConfig(),
          ),
          const Gap(12),
          CustomButton(text: context.loc.next, onTap: () {}),
        ],
      ),
    );
  }
}
