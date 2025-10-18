import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../app_export.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PrivacyCubit(
        apiClient: sl<IApiClient>(),
        db: sl<ILocalService>(),
      ),
      child: const _PrivacyView(),
    );
  }
}

class _PrivacyView extends StatelessWidget {
  const _PrivacyView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.loc.privacyPolicy,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BlocBuilder<PrivacyCubit, PrivacyState>(
        builder: (context, state) {
          if (state is OtherPrivacyState) {
            switch (state.status) {
              case ApiStatus.loading:
                return const LoadingWidget(color: AppColors.black,);

              case ApiStatus.internetError:
                return Center(
                  child: NoInternetCard(
                    onTap: () => context.read<PrivacyCubit>().getPrivacy(),
                  ),
                );

              case ApiStatus.noDataFound:
                return Center(
                  child: Text(
                    context.loc.no_items_found,
                  ),
                );

              case ApiStatus.error:
                return ErrorCard(
                  onTap: () => context.read<PrivacyCubit>().getPrivacy(),
                );

              case ApiStatus.completed:
                final description = state.description.trim();
                if (description.isEmpty) {
                  return Center(
                    child: Text(
                      context.loc.no_items_found,
                    ),
                  );
                }
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: HtmlWidget(description),
                );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
