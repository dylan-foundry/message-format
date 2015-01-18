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

define test format-basic-variable-test ()
  let vf = make(<simple-format>, variable-name: name:);
  let m = make(<message-format>, parts: message-parts("Hello, ", vf, "."));
  assert-equal("Hello, John.", format-message-to-string(m, name: "John"));
end test;

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

define suite message-format-test-suite ()
  test create-message-format-test;
  test format-basic-message-to-string-test;
  test format-basic-variable-test;
  test basic-select-format-test;
end suite;
