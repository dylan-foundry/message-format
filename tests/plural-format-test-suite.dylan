module: message-format-test-suite
synopsis: Test suite for the message-format library.

define test basic-plural-format-test ()
  let pf = make(<plural-format>, variable-name: count:,
                one: make-message("There is one."),
                other: make-message("There is not only one."));
  let m = make(<message-format>, parts: message-parts(pf));
  assert-equal("There is one.", format-message-to-string(m, count: 1));
  assert-equal("There is not only one.", format-message-to-string(m, count: 0));
  assert-equal("There is not only one.", format-message-to-string(m, count: 2));
end test;

define test offset-plural-format-test ()
  let pf = make(<plural-format>,
                variable-name: count:,
                offset: 1,
                one: make-message("There is one."),
                other: make-message("There is not only one."));
  let m = make(<message-format>, parts: message-parts(pf));
  assert-equal("There is one.", format-message-to-string(m, count: 2));
  assert-equal("There is not only one.", format-message-to-string(m, count: 0));
  assert-equal("There is not only one.", format-message-to-string(m, count: 1));
  assert-equal("There is not only one.", format-message-to-string(m, count: 3));
end test;

define test missing-cases-plural-format-test ()
  let pf = make(<plural-format>,
                variable-name: count:,
                other: make-message("Hit other."));
  let m = make(<message-format>, parts: message-parts(pf));
  assert-equal("Hit other.", format-message-to-string(m, count: 2));
  assert-equal("Hit other.", format-message-to-string(m, count: 1));
  assert-equal("Hit other.", format-message-to-string(m, count: 0));
end test;

define test number-value-plural-format-test ()
  let pvp = make(<plural-value-placeholder>);
  let pf = make(<plural-format>,
                variable-name: count:,
                one: make-message-from-parts(message-parts("There was ", pvp, " item.")),
                other: make-message-from-parts(message-parts("There were ", pvp, " items.")));
  let m = make(<message-format>, parts: message-parts(pf));
  assert-equal("There were 0 items.", format-message-to-string(m, count: 0));
  assert-equal("There was 1 item.", format-message-to-string(m, count: 1));
  assert-equal("There were 2 items.", format-message-to-string(m, count: 2));
end test;

define test literal-values-plural-format-test ()
  let pf = make(<plural-format>,
                variable-name: count:,
                one: make-message("One"),
                other: make-message("Other"),
                literal-values: vector(0, 5),
                literal-formats: vector(make-message("Zero"),
                                        make-message("Five")));
  let m = make(<message-format>, parts: message-parts(pf));
  assert-equal("Zero", format-message-to-string(m, count: 0));
  assert-equal("One", format-message-to-string(m, count: 1));
  assert-equal("Other", format-message-to-string(m, count: 2));
  assert-equal("Five", format-message-to-string(m, count: 5));
end test;

define test incorrect-literal-values-plural-format-test ()
  assert-signals(<error>,
                 make(<plural-format>,
                      variable-name: count:,
                      other: make-message("Other"),
                      literal-values: vector(0, 2),
                      literal-formats: vector(make-message("Zero"))),
                 "Values and formats must have same length");
  assert-signals(<error>,
                 make(<plural-format>,
                      variable-name: count:,
                      other: make-message("Other"),
                      literal-values: vector(0.0),
                      literal-formats: vector(make-message("Zero"))),
                 "Values must be integers");
  assert-signals(<error>,
                 make(<plural-format>,
                      variable-name: count:,
                      other: make-message("Other"),
                      literal-values: vector(0),
                      literal-formats: vector("Zero")),
                 "Formats must be <message-format> instances");
  assert-signals(<error>,
                 make(<plural-format>,
                      variable-name: count:,
                      other: make-message("Other"),
                      literal-values: vector(0)),
                 "If literal values are supplied, then formats must be");
  assert-signals(<error>,
                 make(<plural-format>,
                      variable-name: count:,
                      other: make-message("Other"),
                      literal-formats: vector(make-message("Zero"))),
                 "If literal formats are supplied, then values must be");
end test;

define suite plural-format-test-suite ()
  test basic-plural-format-test;
  test offset-plural-format-test;
  test missing-cases-plural-format-test;
  test number-value-plural-format-test;
  test literal-values-plural-format-test;
  test incorrect-literal-values-plural-format-test;
end suite;
