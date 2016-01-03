module: message-format-test-suite
synopsis: Test suite for the message-format library.

define test basic-simple-format-test ()
  let vf = make(<simple-format>, variable-name: name:);
  let m = make(<message-format>, parts: message-parts("Hello, ", vf, "."));
  assert-equal("Hello, John.", format-message-to-string(m, name: "John"));
end test;

define test multiple-variables-simple-format-test ()
  let vf = make(<simple-format>, variable-name: name:);
  let af = make(<simple-format>, variable-name: adj:);
  let m = make(<message-format>,
               parts: message-parts("Hello, ", vf, ". It is going to be a ",
                                    af, " day."));
  assert-equal("Hello, John. It is going to be a good day.",
               format-message-to-string(m, name: "John", adj: "good"));
end test;

define test integer-simple-format-test ()
  let vf = make(<simple-format>, variable-name: count:);
  let m = make(<message-format>, parts: message-parts("Boo: ", vf, "."));
  assert-equal("Boo: 10.", format-message-to-string(m, count: 10));
end test;

define suite simple-format-test-suite ()
  test basic-simple-format-test;
  test multiple-variables-simple-format-test;
  test integer-simple-format-test;
end suite;
