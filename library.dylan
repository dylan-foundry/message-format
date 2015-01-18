Module: dylan-user

define library message-format
  use common-dylan;
  use collections;
  use io;

  export message-format;
end library message-format;

define module message-format
  use common-dylan;
  use format, import: { print-message };
  use plists;
  use streams;

  export <message-format>,
         <message-format-parts-vector>,
         message-parts;

  export format-message,
         format-message-to-string,
         parse-message;

  export <format>,
         <plural-format>,
         <select-format>,
         <simple-format>;

  export format-message-part;
end module message-format;
