import 'dart:async';

import 'package:flutter/material.dart';
import 'package:transport_for_london/config/app.dart';
import 'package:transport_for_london/injectors/dependency.dart';
import 'package:transport_for_london/models/stop_point.dart';
import 'package:transport_for_london/services/stop_point.dart';
import 'package:transport_for_london/types/predicate.dart';
import 'package:transport_for_london/utils/stop_point.dart';
import 'package:transport_for_london/widgets/drawer.dart';
import 'package:transport_for_london/widgets/loading_spinner.dart';
import 'package:transport_for_london/widgets/search_icon_button.dart';
import 'package:transport_for_london/widgets/stop_point_list_tile.dart';

class StopPointsPage extends StatefulWidget {
  @override
  _StopPointsPageState createState() => new _StopPointsPageState();
}

class _StopPointsPageState extends State<StopPointsPage> {
  _StopPointsPageState() {
    _stopPointItemBuilder = (
      BuildContext context,
      int index,
    ) {
      return new StopPointListTileWidget(
        onTap: () => _handleStopPointListTileTap(_filteredStopPoints[index]),
        stopPoint: _filteredStopPoints[index],
      );
    };

    _stopPointNamePredicate = (stopPoint) {
      return doesStopPointCommonNameContainQuery(stopPoint, _searchQuery.text);
    };

    _stopPointService = new DependencyInjector().stopPointService;
  }

  List<StopPoint> _filteredStopPoints = [];
  bool _isSearching = false;
  IndexedWidgetBuilder _stopPointItemBuilder;
  Predicate<StopPoint> _stopPointNamePredicate;
  StopPointService _stopPointService;
  List<StopPoint> _stopPoints = [];

  final TextEditingController _searchQuery = new TextEditingController();

  AppBar _buildAppBar() {
    return new AppBar(
      actions: <Widget>[
        new SearchIconButtonWidget(onPressed: _handleSearchBegin),
      ],
      title: new Text('Stop Points'),
    );
  }

  AppBar _buildSearchBar() {
    return new AppBar(
      title: new TextField(
        autofocus: true,
        controller: _searchQuery,
        decoration: new InputDecoration(
          hintText: 'Search by stop point name',
        ),
      ),
    );
  }

  ListView _buildStopPointListView() {
    return new ListView.builder(
      itemBuilder: _stopPointItemBuilder,
      itemCount: _filteredStopPoints.length,
    );
  }

  Widget _buildStopPoints() {
    if (_stopPoints.length > 0) {
      _filteredStopPoints = _stopPoints;

      if (_isSearching && _searchQuery.text.isNotEmpty) {
        _filteredStopPoints =
            _stopPoints.where(_stopPointNamePredicate).toList();
      }

      return _buildStopPointListView();
    } else {
      return new FutureBuilder<List<StopPoint>>(
        builder: (
          BuildContext context,
          AsyncSnapshot<List<StopPoint>> snapshot,
        ) {
          if (snapshot.hasData) {
            _filteredStopPoints = snapshot.data;
            _stopPoints = snapshot.data;

            return _buildStopPointListView();
          } else {
            return new LoadingSpinnerWidget();
          }
        },
        future: _stopPointService.getStopPointsByTypeMode(),
      );
    }
  }

  void _handleSearchBegin() {
    ModalRoute.of(context).addLocalHistoryEntry(new LocalHistoryEntry(
      onRemove: () {
        setState(() {
          _isSearching = false;
          _searchQuery.clear();
        });
      },
    ));

    setState(() {
      _isSearching = true;
    });
  }

  Future<void> _handleStopPointListTileTap(StopPoint stopPoint) async {
    await App.router.navigateTo(context, '/stop_points/${stopPoint.id}');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _isSearching ? _buildSearchBar() : _buildAppBar(),
      body: _buildStopPoints(),
      drawer: !_isSearching ? new DrawerWidget() : null,
    );
  }
}
