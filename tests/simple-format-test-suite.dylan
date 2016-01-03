module: message-format-test-suite
synopsis: Test suite for the message-format library.

define test basic-simple-format-test ()
  let vf = make(<simple-format>, variable-name: name:);
  let m = make(<message-format>, parts: message-parts("Hello, ", vf, "."));
  assert-equal("Hello, John.", format-message-to-string(m, name: "John"));
end test;

define suite simple-format-test-suite ()
  test basic-simple-format-test;
end suite;
