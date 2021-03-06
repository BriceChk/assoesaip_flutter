import 'package:assoesaip_flutter/models/eventOccurrence.dart';
import 'package:assoesaip_flutter/shares/constants.dart';
import 'package:assoesaip_flutter/shares/eventsOccurrencesListWidget.dart';
import 'package:assoesaip_flutter/shares/lifecycleEventHandler.dart';
import 'package:assoesaip_flutter/shares/newsListWidget.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:flutter/material.dart';

class CalendarWidget extends StatefulWidget {
  final ScrollController controller;
  CalendarWidget(this.controller);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> with AutomaticKeepAliveClientMixin<CalendarWidget> {
  @override
  bool get wantKeepAlive => true;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  List<EventOccurrence>? events;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(
        LifecycleEventHandler(resumeCallBack: () async => setState(() {
          WidgetsBinding.instance!.addPostFrameCallback((_) => _refreshIndicatorKey.currentState!.show());
        }))
    );

    _loadData();
  }

  Future<void> _loadData() {
    return getNextEventOccurrences().then((value) {
      setState(() {
        events = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //* Using the CustomScroolView in order to have the bouncingScrollPhysic
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _loadData,
      color: COLOR_AE_BLUE,
      child: CustomScrollView(
        controller: widget.controller,
        physics: BouncingScrollPhysics(),
        slivers: [
          //* We wrap our header inside the sliverAppBar with somme properties
          SliverAppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              "Calendrier",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontFamily: FONT_NUNITO,
              ),
            ),
            flexibleSpace: _headerFlexibleSpace(),
            toolbarHeight: 60,
            expandedHeight: 100,
            floating: true,
            pinned: true,
            backgroundColor: COLOR_AE_BLUE,
          ),
          //* We wrap the rest of the page inside the SliverList: like this everything scrool vertically except the header
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 5),
                //* Widget with all the name of the categories of the association
                _buildEventsList(),
                //* Sizedbox of height 60 because otherwise the last one is under the navbar
                SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsList() {
    if (events is List<EventOccurrence>) {
      return EventsOccurrencesList(events);
    } else {
      return NewsListWidget.newsListPlaceholder();
    }
  }

  Widget _headerFlexibleSpace() {
    return FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: true,
        background: Container(
          padding: EdgeInsets.fromLTRB(15, 60, 15, 0),
          child: Center(
            child: Text(
              "Les prochains événements sur ton campus",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: FONT_NUNITO,
              ),
            ),
          ),
        ));
  }
}

