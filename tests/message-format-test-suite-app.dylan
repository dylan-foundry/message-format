module: message-format-test-suite-app

define suite all-message-format-test-suites ()
  suite message-format-test-suite;
end;

run-test-application(all-message-format-test-suites);
