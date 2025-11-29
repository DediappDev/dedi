import 'package:fluffychat/widgets/twake_components/twake_loading/center_loading_indicator.dart';
import 'package:flutter/material.dart';

import 'package:fluffychat/utils/scroll_controller_extension.dart';

class DediSmartRefresher extends StatefulWidget {
  final DediRefreshController controller;
  final Function? onRefresh;
  final Function? onLoading;
  final List<Widget> slivers;

  const DediSmartRefresher({
    super.key,
    this.onRefresh,
    this.onLoading,
    required this.controller,
    required this.slivers,
  });

  @override
  State<DediSmartRefresher> createState() => _DediSmartRefresherController();
}

class DediRefreshController {
  final refreshNotifier = ValueNotifier(false);
  final loadingNotifier = ValueNotifier(false);

  bool get isRefeshing => refreshNotifier.value;
  bool get isLoading => loadingNotifier.value;

  void onRefresh() {
    refreshNotifier.value = true;
  }

  void refreshCompleted() {
    refreshNotifier.value = false;
  }

  void onLoading() {
    loadingNotifier.value = true;
  }

  void loadComplete() {
    loadingNotifier.value = false;
  }
}

class _DediSmartRefresherController extends State<DediSmartRefresher> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addLoadMoreListener(onLoading);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> onRefresh() async {
    if (widget.controller.isRefeshing || widget.onRefresh == null) return;
    widget.controller.onRefresh();
    widget.onRefresh?.call();
  }

  Future<void> onLoading() async {
    if (widget.controller.isLoading || widget.onLoading == null) return;
    widget.controller.onLoading();
    await widget.onLoading!();
  }

  @override
  Widget build(BuildContext context) {
    return _DediSmartRefresherView(
      controller: this,
      refreshController: widget.controller,
      slivers: widget.slivers,
    );
  }
}

class _DediSmartRefresherView extends StatelessWidget {
  const _DediSmartRefresherView({
    required this.controller,
    required this.refreshController,
    required this.slivers,
  });
  final List<Widget> slivers;
  final DediRefreshController refreshController;
  final _DediSmartRefresherController controller;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.onRefresh,
      child: CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          ValueListenableBuilder(
            valueListenable: refreshController.refreshNotifier,
            builder: (context, refreshing, child) => SliverToBoxAdapter(
              child: refreshing
                  ? const CenterLoadingIndicator()
                  : const SizedBox(),
            ),
          ),
          ...slivers,
          ValueListenableBuilder(
            valueListenable: refreshController.loadingNotifier,
            builder: (context, loading, child) => SliverToBoxAdapter(
              child:
                  loading ? const CenterLoadingIndicator() : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
