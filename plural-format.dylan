Module: message-format
Synopsis: The <plural-format> class.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define class <plural-format> (<format>)
  constant slot plural-classifier :: <function> = english-cardinal-classifier,
    init-keyword: rules:;
  constant slot plural-zero-format :: false-or(<message-format>) = #f,
    init-keyword: zero:;
  constant slot plural-one-format :: false-or(<message-format>) = #f,
    init-keyword: one:;
  constant slot plural-two-format :: false-or(<message-format>) = #f,
    init-keyword: two:;
  constant slot plural-few-format :: false-or(<message-format>) = #f,
    init-keyword: few:;
  constant slot plural-many-format :: false-or(<message-format>) = #f,
    init-keyword: many:;
  constant slot plural-other-format :: false-or(<message-format>) = #f,
    init-keyword: other:;
end class;

define sealed domain make (singleton(<select-format>));
define sealed domain initialize (<select-format>);

define constant <plural-category>
  = one-of(plural-zero-format,
           plural-one-format,
           plural-two-format,
           plural-few-format,
           plural-many-format,
           plural-other-format);

define method english-cardinal-classifier (value :: <integer>)
 => (category :: <plural-category>)
  case
    value = 1 => plural-one-format;
    otherwise => plural-other-format;
  end case;
end method;

define method format-message-part
    (stream :: <stream>, part :: <plural-format>, args :: <sequence>)
 => ()
  let value = format-variable-value(part, args);
  let classifier = part.plural-classifier;
  let category :: <plural-category> = classifier(value);
  let result = category(part);
  if (result)
    apply(format-message, stream, result, args);
  end if;
end;
