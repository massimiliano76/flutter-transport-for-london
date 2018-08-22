import 'package:flutter_flux/flutter_flux.dart';
import 'package:transport_for_london/models/line.dart';

class LineStore extends Store {
  LineStore() {
    triggerOnAction(selectLine, (line) {
      _line = line;
    });
  }

  Line _line;

  Line get line => _line;
}

final StoreToken lineStoreToken = new StoreToken(new LineStore());

final Action<Line> selectLine = new Action<Line>();
