import 'dart:async';

import 'package:transport_for_london/models/disruption.dart';
import 'package:transport_for_london/models/line.dart';
import 'package:transport_for_london/models/line_status.dart';
import 'package:transport_for_london/models/stop_point.dart';
import 'package:transport_for_london/repos/line.dart';

class LineService {
  LineService(this.lineRepo);

  final LineRepo lineRepo;

  Future<List<Disruption>> getDisruptionsByMode([
    String mode = 'tube',
  ]) async {
    return await lineRepo.getDisruptionsByMode(
      mode,
    );
  }

  Future<Line> getLineByLineId(
    String lineId,
  ) async {
    return await lineRepo.getLineByLineId(
      lineId,
    );
  }

  Future<List<Line>> getLinesByMode([
    String mode = 'tube',
  ]) async {
    return await lineRepo.getLinesByMode(
      mode,
    );
  }

  Future<List<LineStatus>> getLineStatusesByLineId(
    String lineId,
  ) async {
    return await lineRepo.getLineStatusesByLineId(
      lineId,
    );
  }

  Future<List<LineStatus>> getLineStatusesByLineIdDate(
    String lineId,
    DateTime fromDate,
    DateTime toDate,
  ) async {
    return await lineRepo.getLineStatusesByLineIdDate(
      lineId,
      fromDate,
      toDate,
    );
  }

  Future<List<StopPoint>> getStopPointsByLineId(
    String lineId,
  ) async {
    return await lineRepo.getStopPointsByLineId(
      lineId,
    );
  }
}
