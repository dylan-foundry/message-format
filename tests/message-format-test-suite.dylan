module: message-format-test-suite
synopsis: Test suite for the message-format library.

define test create-message-format-test ()
  assert-no-errors(make(<message-format>,
                        parts: message-parts("Hello,", " ", "World")),
                   "Can create message-format");
end test;

define test format-basic-message-to-string-test ()
  let m = make(<message-format>,
               parts: message-parts("Hello,", " ", "World"));
  assert-equal("Hello, World", format-message-to-string(m));
end test;

define suite message-format-test-suite ()
  test create-message-format-test;
  test format-basic-message-to-string-test;
end suite;
