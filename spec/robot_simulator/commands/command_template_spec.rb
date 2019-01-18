module RobotSimulator
  RSpec.describe Commands::CommandTemplate do
    let(:robot) { double('robot', { x: 1, y: 2, orientation: 'NORTH' }) }
    let(:surface) { double('surface', { with: 5, height: 5 }) }
    let(:params) { [] }
    subject { described_class.new(robot: robot, surface: surface, params: params) }

    describe 'perform?' do
      it 'raises error' do
        expect { subject.perform? }.to raise_error(Errors::AbstractClassError)
      end
    end

    describe 'perform' do
      it 'raises error' do
        expect { subject.perform }.to raise_error(Errors::AbstractClassError)
      end
    end
  end
end
