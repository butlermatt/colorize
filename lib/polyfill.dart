library colorize.polyfill;

import 'dart:html';

// For debugging
import 'src/debugging.dart' as debug;

void colorizeMe() {
  debug.init();
  final log = new debug.Logger('colorizeMe Polyfill');
  log.finest('Entered colorizeMe');
  
  bool supportsColor = _checkSupport();
  log.fine('supports color: $supportsColor');
  
  // Color types are already supported natively no polyfill needed.
  if(supportsColor) return;
  
  var elements = document.querySelectorAll('input.colorize');
  log.fine('Found ${elements.length} elements');
  
}

bool _checkSupport() {
  var el = new InputElement(type: 'color');
  return el.type == 'color';
}