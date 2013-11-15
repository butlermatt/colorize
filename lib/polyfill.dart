library colorize.polyfill;

import 'dart:html';
import 'colorize.dart';

// For debugging
import 'src/debugging.dart' as debug;

/**
 * Calling this function will apply the colorize polyfill to all input elements
 * with the class `colorize`. Throws an [UnsupportedError] if the input element 
 * does not have the type of text such as if you assigned the colorize class
 * to a input type of date.
 */
final log = new debug.Logger('colorizeMe Polyfill');

void colorizeMe() {
  debug.init();
  log.finest('Entered colorizeMe');
  
  bool supportsColor = checkSupport();
  log.fine('supports color: $supportsColor');
  
  // Color types are already supported natively no polyfill needed.
//  if(supportsColor) return;
  
  var elList = querySelectorAll('input.colorize');
  log.fine('Found ${elList.length} elements');

  if(elList.every((el) => el.type == 'text') != true) {
    throw new UnsupportedError('"colorize" class assigned to non-text type' +
        ' input element');
  }
  
  elList.onFocus.listen(_onFocus);
  
  elList.forEach((el) {
    el.style.width = '53px';
    el.style.height = '23px';
  });
}

/**
 * Determins if the currently browser supports `input type="color"`
 * Returns true if browser natively supports color. Returns false
 * otherwise.
 */
bool checkSupport() {
  var el = new InputElement(type: 'color');
  return el.type == 'color';
}

// The onFocus event was received by one of our components. Need to
// display the pop-up color picker. TODO: If text box contains a value
// then try to initalize it from that.
void _onFocus(Event e) {
  var el = e.target as InputElement;
  el.blur();
  
  var picker = new Colorize(64, showInfoBox: false);
  picker.colorChangeListener = (ColorValue color, num hue, num saturation, num brightness) {
      el.value = color.toHex();
      el.style.backgroundColor = color.toHex();
      if(color.r < 128 && color.g < 128 && color.b < 128) {
        el.style.color = '#fff';
      } else {
        el.style.color = '#000';
      }
  };
  var position = el.getBoundingClientRect().bottomRight;
  picker.element.style..position = 'absolute'
      ..left = '${position.x}px'
      ..top = '${position.y - (picker.element.getBoundingClientRect().height)}px';
  
  picker.element.onMouseLeave.listen((e) {
    picker.element.remove();
  });
  el.insertAdjacentElement('afterEnd', picker.element);
  
}
