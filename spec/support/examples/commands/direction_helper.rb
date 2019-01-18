require 'robot_simulator/entities/robot'
require 'robot_simulator/errors/command_error'

RSpec.shared_examples 'direction examples' do
  let(:robot) { double('robot', { x: 1, y: 2, orientation: 'NORTH', placed: true }) }
  let(:surface) { double('surface', { with: 5, height: 5 }) }
  let(:params) { [] }
  subject { described_class.new(robot: robot, surface: surface, params: params) }

  describe 'initialize' do
    it 'has class validation methods for all params' do
      described_class::PARAMS_CONFIG.each do |param|
        expect(described_class).to respond_to("#{param}_validation")
      end
    end

    it 'transforms params into a hash' do
      expect(subject.params).to eq(Hash[*[described_class::PARAMS_CONFIG, params].transpose.flatten(1)])
    end
  end

  describe 'perform?' do
    context 'valid movement' do
      it 'returns true' do
        expect(subject.perform?).to be_truthy
      end
    end

    context 'when robot is not placed' do
      it 'returns true' do
        allow(robot).to receive(:placed).and_return(false)
        allow(RobotSimulator::Errors::CommandError).to receive(:output_error)
          .with('Robot must be placed in surface first')
        expect(subject.perform?).to be_falsy
        expect(RobotSimulator::Errors::CommandError).to have_received(:output_error).once
      end
    end
  end

  describe 'perform' do
    let(:robot) { RobotSimulator::Entities::Robot.new }

    it 'persists robot attributes' do
      robot.x = 1
      robot.y = 2
      robot.orientation = 'NORTH'
      subject.perform
      expected_orientation = direction == 'Right' ? 'EAST' : 'WEST'
      expect(robot.orientation).to eq(expected_orientation)
    end
  end
end
