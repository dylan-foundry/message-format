Module: message-format
Synopsis: The <message-format> class.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define constant <string-or-format> = type-union(<string>, <format>);

define constant <message-format-parts-vector>
  = limited(<vector>, of: <string-or-format>);

define sealed domain as (singleton(<message-format-parts-vector>), <object>);

define inline function message-parts (#rest args)
  as(<message-format-parts-vector>, args)
end;

define class <message-format> (<object>)
  constant slot message-format-parts :: <message-format-parts-vector>,
    required-init-keyword: parts:;
end class;

define sealed domain make (singleton(<message-format>));
define sealed domain initialize (<message-format>);

define generic format-message
    (stream :: <stream>, message :: type-union(<string>, <message-format>),
     #rest args, #key #all-keys)
 => ();

define method format-message
    (stream :: <stream>, message :: <string>,
     #rest args, #key #all-keys)
 => ()
  let message-format = parse-message(message);
  apply(format-message, stream, message-format, args)
end method;

define method format-message
    (stream :: <stream>, message-format :: <message-format>,
     #rest args, #key #all-keys)
 => ()
  for (part in message-format.message-format-parts)
    select (part by instance?)
      <string> => write(stream, part);
      otherwise => format-message-part(stream, part, args);
    end;
  end for;
end method;

define generic format-message-to-string
    (message :: type-union(<string>, <message-format>),
     #rest args, #key #all-keys)
 => (message :: <byte-string>);

define method format-message-to-string
    (message :: <string>,
     #rest args, #key #all-keys)
 => (message :: <byte-string>)
  let s :: <byte-string-stream>
    = make(<byte-string-stream>,
           contents: make(<byte-string>, size: 32), direction: #"output");
  apply(format-message, s, message, args);
  s.stream-contents
end method;

define method format-message-to-string
    (message-format :: <message-format>,
     #rest args, #key #all-keys)
 => (message :: <byte-string>)
  let s :: <byte-string-stream>
    = make(<byte-string-stream>,
           contents: make(<byte-string>, size: 32), direction: #"output");
  apply(format-message, s, message-format, args);
  s.stream-contents
end method;
