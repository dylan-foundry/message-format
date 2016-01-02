Module: message-format
Synopsis: The <simple-format> base class.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define sealed class <simple-format> (<format>)
end class;

define sealed domain make (singleton(<simple-format>));
define sealed domain initialize (<simple-format>);

define method format-message-part
    (stream :: <stream>, part :: <format>, args :: <sequence>)
 => ()
  print-message(format-variable-value(part, args), stream);
end method;
