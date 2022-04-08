import 'package:beautina_provider/utils/ui/space.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Duration _kScrollDuration = const Duration(milliseconds: 150);
const EdgeInsetsGeometry _kTabMargin =
    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0);

const SizedBox _kSizedBoxW8 = const SizedBox(width: 8.0);

class WdgtScrollableListTabView extends StatefulWidget {
  /// Create a new [ScrollableListTabView]
  const WdgtScrollableListTabView(
      {Key? key,
      required this.tabs,
      this.tabHeight = kToolbarHeight,
      this.tabAnimationDuration = _kScrollDuration,
      this.bodyAnimationDuration = _kScrollDuration,
      this.tabAnimationCurve = Curves.decelerate,
      this.bodyAnimationCurve = Curves.decelerate})
      : assert(tabAnimationDuration != null, bodyAnimationDuration != null),
        assert(tabAnimationCurve != null, bodyAnimationCurve != null),
        assert(tabHeight != null),
        assert(tabs != null),
        super(key: key);

  /// List of tabs to be rendered.
  final List<ScrollableListTab> tabs;

  /// Height of the tab at the top of the view.
  final double tabHeight;

  /// Duration of tab change animation.
  final Duration tabAnimationDuration;

  /// Duration of inner scroll view animation.
  final Duration bodyAnimationDuration;

  /// Animation curve used when animating tab change.
  final Curve tabAnimationCurve;

  /// Animation curve used when changing index of inner [ScrollView]s.
  final Curve bodyAnimationCurve;

  @override
  _WdgtScrollableListTabViewState createState() =>
      _WdgtScrollableListTabViewState();
}

class _WdgtScrollableListTabViewState extends State<WdgtScrollableListTabView> {
  final ValueNotifier<int> _index = ValueNotifier<int>(2);

  final ItemScrollController _bodyScrollController = ItemScrollController();
  final ItemPositionsListener _bodyPositionsListener =
      ItemPositionsListener.create();
  final ItemScrollController _tabScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();

    _bodyPositionsListener.itemPositions.addListener(_onInnerViewScrolled);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.tabHeight,
          color: Colors.transparent,
          child: ScrollablePositionedList.builder(
            itemCount: widget.tabs.length,
            initialAlignment: 0,
            reverse: true,
            initialScrollIndex: widget.tabs.length,
            scrollDirection: Axis.horizontal,
            itemScrollController: _tabScrollController,
            padding: EdgeInsets.symmetric(vertical: 2.5),
            itemBuilder: (context, index) {
              var tab = widget.tabs[index].tab;
              return ValueListenableBuilder<int>(
                  valueListenable: _index,
                  builder: (_, i, __) {
                    var selected = index == i;
                    var borderColor = selected
                        ? tab.activeBackgroundColor
                        : Theme.of(context).dividerColor;
                    return Container(
                      width: (1/3).sw,
                      height: 32,
                      // margin: _kTabMargin,
                      decoration: BoxDecoration(
                          color: selected
                              ? tab.activeBackgroundColor
                              : tab.inactiveBackgroundColor,
                          borderRadius: tab.borderRadius),
                      child: OutlinedButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                  selected ? Colors.white : Colors.grey),
                              backgroundColor: MaterialStateProperty.all(
                                  selected
                                      ? tab.activeBackgroundColor
                                      : tab.inactiveBackgroundColor),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              side: MaterialStateProperty.all(BorderSide(
                                width: 1,
                                color: borderColor,
                              )),
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: tab.borderRadius))),
                          child: _buildTab(index),
                          onPressed: () => _onTabPressed(
                                index,
                                widget.tabs.length,
                              )),
                    );
                  });
            },
          ),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Expanded(
            child: ScrollablePositionedList.builder(
              itemScrollController: _bodyScrollController,
              padding: EdgeInsets.all(0),
              itemPositionsListener: _bodyPositionsListener,
              itemCount: widget.tabs.length,
              itemBuilder: (_, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: _kTabMargin.add(const EdgeInsets.all(5.0)),
                    child: _buildInnerTab(index),
                  ),
                  Flexible(
                    child: widget.tabs[index].body,
                  ),
                  if (widget.tabs.length - 1 == index)
                    Y(
                      height: 0.55.sh,
                    )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInnerTab(int index) {
    var tab = widget.tabs[index].tab;
    var textStyle = Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(fontWeight: FontWeight.w500);
    return Builder(
      builder: (_) {
        if (tab.icon == null) return tab.label;
        if (!tab.showIconOnList)
          return DefaultTextStyle(style: textStyle, child: tab.label);
        return DefaultTextStyle(
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.w500),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [tab.icon!, _kSizedBoxW8, tab.label],
          ),
        );
      },
    );
  }

  Widget _buildTab(int index) {
    var tab = widget.tabs[index].tab;
    if (tab.icon == null) return tab.label;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [tab.icon!, _kSizedBoxW8, tab.label],
    );
  }

  void _onInnerViewScrolled() async {
    var positions = _bodyPositionsListener.itemPositions.value;

    /// Target [ScrollView] is not attached to any views and/or has no listeners.
    if (positions == null || positions.isEmpty) return;

    /// Capture the index of the first [ItemPosition]. If the saved index is same
    /// with the current one do nothing and return.
    var firstIndex =
        _bodyPositionsListener.itemPositions.value.elementAt(0).index;
    if (_index.value == firstIndex) return;

    /// A new index has been detected.
    await _handleTabScroll(firstIndex);
  }

  Future<void> _handleTabScroll(int index) async {
    _index.value = index;
    await _tabScrollController.scrollTo(
        index: _index.value,
        duration: widget.tabAnimationDuration,
        curve: widget.tabAnimationCurve);
  }

  /// When a new tab has been pressed both [_tabScrollController] and
  /// [_bodyScrollController] should notify their views.
  void _onTabPressed(int index, int length) async {
    await _tabScrollController.scrollTo(
        index: index,
        duration: widget.tabAnimationDuration,
        curve: widget.tabAnimationCurve);
    await _bodyScrollController.scrollTo(
        index: index,
        duration: widget.bodyAnimationDuration,
        curve: widget.bodyAnimationCurve);
    _index.value = index;
  }

  @override
  void dispose() {
    _bodyPositionsListener.itemPositions.removeListener(_onInnerViewScrolled);
    return super.dispose();
  }
}

class ListTab {
  /// Create a new [ListTab]
  const ListTab(
      {Key? key,
      this.icon,
      required this.label,
      this.borderRadius = const BorderRadius.all(const Radius.circular(5.0)),
      this.activeBackgroundColor = Colors.blue,
      this.inactiveBackgroundColor = Colors.transparent,
      this.showIconOnList = false,
      this.borderColor = Colors.grey})
      : assert(label != null),
        assert(borderRadius != null),
        assert(activeBackgroundColor != null),
        assert(inactiveBackgroundColor != null),
        assert(showIconOnList != null),
        assert(borderColor != null);

  /// Trailing widget for a tab, typically an [Icon].
  final Widget? icon;

  /// Label to be shown in the tab, must be non-null.
  final Widget label;

  /// [BorderRadius] for the a tab at the bottom tab view.
  /// This won't affect the tab in the scrollable list.
  final BorderRadiusGeometry borderRadius;

  /// Color to be used when the tab is selected.
  final Color activeBackgroundColor;

  /// Color to be used when tab is not selected
  final Color inactiveBackgroundColor;

  /// If true, the [icon] will also be shown to the user in the scrollable list.
  final bool showIconOnList;

  /// Color of the [Border] property of the inner tab [Container].
  final Color borderColor;
}

class ScrollableListTab {
  /// A skeleton class to be used in order to build the scrollable list.
  /// [ScrollableListTab.tab] will be used on both tab bar and scrollable body.
  ScrollableListTab({required this.tab, required this.body})
      : assert(tab != null, body != null),
        assert(body.shrinkWrap && body.physics is NeverScrollableScrollPhysics);

  /// A data class for tab properties
  final ListTab tab;

  /// A single widget in the scrollable tab list.
  /// Make sure that [body] is created with [ScrollView.shrinkWrap] = true
  /// and [ScrollView.physics] = [NeverScrollableScrollPhysics].
  /// This will ensure that all the children will layout correctly.
  /// For more details see [ScrollView].
  final ScrollView body;
}
