module RobotSimulator
   RSpec.describe Outputters::PlainTextOutputter do
    let(:robot) { double('robot', { x: 1, y: 2, orientation: 'NORTH' }) }
    let(:surface) { double('surface', { with: 5, height: 5 }) }
    subject { described_class.new(robot: robot, surface: surface) }

    it 'has appropiate accessors' do
      expect(subject).to have_attr_accessor(:robot)
      expect(subject).to have_attr_accessor(:surface)
    end

    describe 'report' do
      let(:expected_output) { "\n#{robot.x},#{robot.y},#{robot.orientation}\n\n" }

      it 'outputs correct data' do
        expect { subject.report }.to output(expected_output).to_stdout
      end
    end

    describe 'error' do
      let(:error) { 'Something went wrong' }
      it 'raises error' do
        expect { subject.error(error) }.to output("#{error}\n").to_stdout
      end
    end
  end
end
