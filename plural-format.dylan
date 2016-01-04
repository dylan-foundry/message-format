Module: message-format
Synopsis: The <plural-format> class.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define constant <integer-vector>
  = limited(<vector>, of: <integer>);

define class <plural-format> (<format>)
  constant slot plural-classifier :: <function> = english-cardinal-classifier,
    init-keyword: rules:;
  constant slot plural-literal-values :: false-or(<integer-vector>) = #f,
    init-keyword: literal-values:;
  constant slot plural-literal-formats :: false-or(<message-format-vector>) = #f,
    init-keyword: literal-formats:;
  constant slot plural-offset :: <integer> = 0,
    init-keyword: offset:;
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
  constant slot plural-other-format :: <message-format>,
    required-init-keyword: other:;
end class;

define sealed method make
    (class == <plural-format>,
     #rest initargs,
     #key literal-values, literal-formats,
     #all-keys)
 => (part :: <plural-format>)
  if (literal-values | literal-formats)
    if (~literal-values | ~literal-formats)
      error("<plural-format> must be provided with both literal-values "
            "and literal-formats");
    end if;
    if (size(literal-values) ~= size(literal-formats))
      error("<plural-format> must be provided with the same number of "
            "both literal-values and literal-formats");
    end if;
    apply(next-method, class,
          literal-values: as(<integer-vector>, literal-values),
          literal-formats: as(<message-format-vector>, literal-formats),
          initargs)
  else
    apply(next-method, class, initargs)
  end if
end method;

define sealed domain initialize (<plural-format>);

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
  let offset = part.plural-offset;
  local method format-from-classifier ()
          let classifier = part.plural-classifier;
          let category :: <plural-category> = classifier(value - offset);
          let result = category(part);
          result | part.plural-other-format
        end;
  let format
    = if (part.plural-literal-values)
        let pos = find-key(part.plural-literal-values, curry(\=, value - offset));
        if (pos)
          part.plural-literal-formats[pos]
        else
          format-from-classifier()
        end if
      else
        format-from-classifier()
      end if;
  format-plural-message(stream, format, value, offset, args);
end;

define method format-plural-message
    (stream :: <stream>, message-format :: <message-format>,
     value :: <integer>, offset :: <integer>, args :: <sequence>)
 => ()
  for (part in message-format.message-format-parts)
    select (part by instance?)
      <string> => write(stream, part);
      <plural-value-placeholder> => print-message(value - offset, stream);
      otherwise => format-message-part(stream, part, args);
    end;
  end for;
end method;

define sealed class <plural-value-placeholder> (<format>)
  inherited slot format-variable-name = #"invalid";
end class;

define sealed domain make (singleton(<plural-value-placeholder>));
define sealed domain initialize (<plural-value-placeholder>);
