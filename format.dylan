Module: message-format
Synopsis: The <format> base class.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define class <format> (<object>)
  constant slot format-variable-name :: <symbol>,
    required-init-keyword: variable-name:;
end class;

define generic format-message-part
    (stream :: <stream>, part :: <format>, args)
 => ();

define method format-message-part
    (stream :: <stream>, part :: <format>, args)
 => ()
  print-message(format-variable-value(part, args), stream);
end method;

// This is used as a tombstone for a default argument.
define generic invalid () => ();

define function format-variable-value
    (format :: <format>, args :: <sequence>)
 => (value)
  let value = get-property(args, format.format-variable-name, default: invalid);
  if (value = invalid)
    error("Unknown format variable name '%s'.", format.format-variable-name);
  end;
  value
end function;
