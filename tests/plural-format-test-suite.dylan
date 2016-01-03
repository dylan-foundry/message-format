module: message-format-test-suite
synopsis: Test suite for the message-format library.

define test basic-plural-format-test ()
  local method make-message (text :: <string>)
          make(<message-format>, parts: message-parts(text))
        end;
  let pf = make(<plural-format>, variable-name: count:,
                one: make-message("There is one."),
                other: make-message("There is not only one."));
  let m = make(<message-format>, parts: message-parts(pf));
  assert-equal("There is one.", format-message-to-string(m, count: 1));
  assert-equal("There is not only one.", format-message-to-string(m, count: 0));
  assert-equal("There is not only one.", format-message-to-string(m, count: 2));
end test;

define suite plural-format-test-suite ()
  test basic-plural-format-test;
end suite;
