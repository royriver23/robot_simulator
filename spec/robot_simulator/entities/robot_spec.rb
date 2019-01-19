module RobotSimulator
  RSpec.describe Entities::Robot do
    subject { described_class.new }

    it 'has appropiate accessors' do
      expect(subject).to have_attr_accessor(:x)
      expect(subject).to have_attr_accessor(:y)
      expect(subject).to have_attr_accessor(:orientation)
      expect(subject).to have_attr_accessor(:placed)
    end
  end
end
