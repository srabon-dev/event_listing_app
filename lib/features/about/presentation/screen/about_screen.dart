import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../app_export.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AboutUsCubit(apiClient: sl<IApiClient>(), db: sl<ILocalService>()),
      child: const _AboutView(),
    );
  }
}

class _AboutView extends StatelessWidget {
  const _AboutView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.loc.aboutUs,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BlocBuilder<AboutUsCubit, AboutUsState>(
        builder: (context, state) {
          if (state is OtherAboutState) {
            switch (state.status) {
              case ApiStatus.loading:
                return const LoadingWidget(color: AppColors.black,);

              case ApiStatus.internetError:
                return Center(child: NoInternetCard(onTap: () {
                  context.read<AboutUsCubit>().getAbout();
                }));

              case ApiStatus.noDataFound:
                return Center(
                  child: Text(
                    context.loc.no_items_found,
                  ),
                );

              case ApiStatus.error:
                return ErrorCard(onTap: () {
                  context.read<AboutUsCubit>().getAbout();
                });

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
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 44),
                  child: HtmlWidget(description),
                );
            }
          }
          // Fallback
          return const SizedBox();
        },
      ),
    );
  }
}

