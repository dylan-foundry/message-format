Module: message-format
Synopsis: The <select-format> class.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define sealed class <select-format> (<format>)
  constant slot select-mappings :: <sequence>,
    required-init-keyword: mappings:;
  constant slot select-default :: <message-format>,
    required-init-keyword: default:;
end class;

define sealed domain make (singleton(<select-format>));
define sealed domain initialize (<select-format>);

define method format-message-part
    (stream :: <stream>, part :: <select-format>, args :: <sequence>)
 => ()
  let value = format-variable-value(part, args);
  let result = get-property(part.select-mappings, value,
                            default: part.select-default);
  apply(format-message, stream, result, args);
end;
