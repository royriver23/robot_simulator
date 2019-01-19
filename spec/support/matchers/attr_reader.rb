RSpec::Matchers.define :have_attr_reader do |field|
  match do |actual|
    actual.respond_to?(field)
  end

  failure_message do |actual|
    "expected attr_reader for #{field} on #{actual}"
  end

  failure_message_when_negated do |actual|
    "expected attr_reader for #{field} not to be defined on #{actual}"
  end

  description do
    "checks to see if there is an attr reader on the supplied object"
  end
end
