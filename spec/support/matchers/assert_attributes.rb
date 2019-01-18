RSpec::Matchers.define :match_attributes do |expected_attributes|
  match do |actual|
    raise ArgumentError.new('expected_attributes should be an instance of Hash') unless expected_attributes.is_a? Hash

    expected_attributes.all? do |attr, value|
      value.to_s == actual.send(attr).to_s
    end
  end

  failure_message do |actual|
    failed_matches = expected_attributes.select do |attr, value|
      value.to_s != actual.send(attr).to_s
    end
    message = "Failed matches are: \n"
    message + failed_matches.map do |failed|
      "[#{failed.first}] '#{failed.last}' is not equal to '#{actual.send(failed.first)}'"
    end.join("\n")
  end

  failure_message_when_negated do |actual|
    'Expected none of the attributes to be present in actual object'
  end
end
