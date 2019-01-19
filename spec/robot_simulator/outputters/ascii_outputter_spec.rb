module RobotSimulator
  RSpec.describe Outputters::AsciiOutputter do
    let(:robot) { double('robot', { x: 1, y: 2, orientation: 'NORTH' }) }
    let(:surface) { double('surface', { width: 5, height: 5 }) }
    subject { described_class.new(robot: robot, surface: surface) }

    it 'has appropiate accessors' do
      expect(subject).to have_attr_accessor(:robot)
      expect(subject).to have_attr_accessor(:surface)
    end

    describe 'report' do
      let(:expected_output) do
        o = "\n"
        (surface.height - 1).downto(0) do |y|
          (0).upto(surface.width - 1) do |x|
            o += ((x == robot.x && y == robot.y) ? " #{subject.send :orientation} " : ' . ')
          end
          o += "\n" unless y.zero?
        end
        o += "\n\n"
      end

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
