module: dylan-user

define library message-format-test-suite
  use common-dylan;
  use message-format;
  use testworks;
  use system;

  export message-format-test-suite;
end library;

define module message-format-test-suite
  use common-dylan;
  use message-format;
  use testworks;

  export message-format-test-suite;
end module;
