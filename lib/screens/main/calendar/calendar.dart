import 'package:assoesaip_flutter/models/eventOccurrence.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:assoesaip_flutter/shares/eventsOccurrencesList.dart';
import 'package:assoesaip_flutter/shares/newsList.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:flutter/material.dart';

final String classicFont = "Nunito";

final RoundedRectangleBorder roundedBorder = RoundedRectangleBorder(
  borderRadius: headerBorder,
);

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> with AutomaticKeepAliveClientMixin<CalendarWidget> {
  @override
  bool get wantKeepAlive => true;

  List<EventOccurrence> events;

  @override
  void initState() {
    super.initState();
    getNextEventOccurrences().then((value) {
      setState(() {
        events = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //* Using the CustomScroolView in order to have the bouncingScrollPhysic
    return CustomScrollView(
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
              color: headerTextColor,
              fontFamily: classicFont,
            ),
          ),
          flexibleSpace: _headerFlexibleSpace(),
          toolbarHeight: 60,
          expandedHeight: 100,
          floating: true,
          pinned: true,
          backgroundColor: headerColor,
        ),
        //* We wrap the rest of the page inside the SliverList: like this everything scrool vertically except the header
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(height: 5),
              //* Widget with all the name of the categories of the association
              _buildEventsList(),
              //* Sizedbox of height 60 because otherwise the last one is under the navbar
              SizedBox(height: 70),
            ],
          ),
        ),
      ],
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
                color: headerTextColor,
                fontFamily: classicFont,
              ),
            ),
          ),
        ));
  }
}

