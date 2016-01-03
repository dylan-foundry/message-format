module: message-format-test-suite
synopsis: Test suite for the message-format library.

define test basic-select-format-test ()
  local method make-message (text :: <string>)
          make(<message-format>, parts: message-parts(text))
        end;
  let sf = make(<select-format>, variable-name: gender:,
                mappings: vector(male:, make-message("He"),
                                 female: make-message("She")),
                default: make-message("It"));
  let m = make(<message-format>, parts: message-parts(sf, " sat down."));
  assert-equal("She sat down.", format-message-to-string(m, gender: female:));
  assert-equal("He sat down.", format-message-to-string(m, gender: male:));
  assert-equal("It sat down.", format-message-to-string(m, gender: neuter:));
end test;

define suite select-format-test-suite ()
  test basic-select-format-test;
end suite;
