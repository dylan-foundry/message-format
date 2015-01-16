Module: message-format
Synopsis: The <format> base class.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define abstract class <format> (<object>)
end class;

define generic format-message-part
    (stream :: <stream>, part :: <format>, args)
 => ();
