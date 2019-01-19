RSpec::Matchers.define :have_attr_accessor do |field|
  match do |actual|
    actual.respond_to?(field) && actual.respond_to?("#{field}=")
  end

  failure_message do |actual|
    "expected attr_accessor for #{field} on #{actual}"
  end

  failure_message_when_negated do |actual|
    "expected attr_accessor for #{field} not to be defined on #{actual}"
  end

  description do
    "checks to see if there is an attr accessor on the supplied object"
  end
end
