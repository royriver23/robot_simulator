module RobotSimulator
  RSpec.describe Outputters::JsonOutputter do
    let(:robot) { double('robot', { x: 1, y: 2, orientation: 'NORTH' }) }
    let(:surface) { double('surface', { with: 5, height: 5 }) }
    subject { described_class.new(robot: robot, surface: surface) }

    it 'has appropiate accessors' do
      expect(subject).to have_attr_accessor(:robot)
      expect(subject).to have_attr_accessor(:surface)
    end

    describe 'report' do
      let(:expected_output) do
        o = "\n"
        o += JSON.pretty_generate ({
          x: robot.x,
          y: robot.y,
          orientation: robot.orientation
        })
        o += "\n\n"
        o
      end

      it 'outputs correct data' do
        expect { subject.report }.to output(expected_output).to_stdout
      end
    end

    describe 'error' do
      let(:error) { 'Something went wrong' }
      let(:expected_output) { JSON.pretty_generate({ error: error }) }
      it 'raises error' do
        expect { subject.error(error) }.to output("#{expected_output}\n").to_stdout
      end
    end
  end
end
