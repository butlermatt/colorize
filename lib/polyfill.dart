library colorize.polyfill;

import 'dart:html';

// For debugging
import 'src/debugging.dart' as debug;

/**
 * Calling this function will apply the colorize polyfill to all input elements
 * with the class `colorize`. Throws an [UnsupportedError] if the input element 
 * does not have the type of text such as if you assigned the colorize class
 * to a input type of date.
 */
void colorizeMe() {
  debug.init();
  final log = new debug.Logger('colorizeMe Polyfill');
  log.finest('Entered colorizeMe');
  
  bool supportsColor = _checkSupport();
  log.fine('supports color: $supportsColor');
  
  // Color types are already supported natively no polyfill needed.
//  if(supportsColor) return;
  
  var elList = querySelectorAll('input.colorize');
  log.fine('Found ${elList.length} elements');

  if(elList.every((el) => el.type == 'text') != true) {
    throw new UnsupportedError('"colorize" class assigned to non-text type' +
        ' input element');
  }
  
  elList.forEach((el) { 
    el.style.width = '44px';
    el.style.height = '23px';
  });
}

bool _checkSupport() {
  var el = new InputElement(type: 'color');
  return el.type == 'color';
}