module RobotSimulator
  RSpec.describe Errors::AbstractClassError do
    let(:method) { 'test_method?' }

    it 'has appropiate accessors' do
      expect { raise Errors::AbstractClassError.new(method: method) }
        .to raise_error(/logic must be implemented in corresponding child class/)
    end
  end
end
