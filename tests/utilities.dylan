module: message-format-test-suite
synopsis: Test suite for the message-format library.

define method make-message (text :: <string>)
 => (message :: <message-format>)
  make(<message-format>, parts: message-parts(text))
end method;

define inline method make-message-from-parts (parts)
 => (message :: <message-format>)
  make(<message-format>, parts: parts)
end method;
