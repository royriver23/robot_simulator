module RobotSimulator
  RSpec.describe Outputters::BaseOutputter do
    let(:robot) { double('robot', { x: 1, y: 2, orientation: 'NORTH' }) }
    let(:surface) { double('surface', { with: 5, height: 5 }) }
    subject { described_class.new(robot: robot, surface: surface) }

    it 'has appropiate accessors' do
      expect(subject).to have_attr_accessor(:robot)
      expect(subject).to have_attr_accessor(:surface)
    end

    describe 'report' do
      it 'raises error' do
        expect { subject.report }.to raise_error(Errors::AbstractClassError)
      end
    end

    describe 'error' do
      it 'raises error' do
        expect { subject.error('Test error') }.to raise_error(Errors::AbstractClassError)
      end
    end
  end
end
