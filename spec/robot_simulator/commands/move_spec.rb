module RobotSimulator
  RSpec.describe Commands::Move do
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
          allow(surface).to receive(:include_x_y?).and_return(true)
          expect(subject.perform?).to be_truthy
        end
      end

      context 'when robot is not placed' do
        it 'display error mesage' do
          allow(robot).to receive(:placed).and_return(false)
          allow(Errors::CommandError).to receive(:output_error)
            .with('Robot must be placed in surface first')
          expect(subject.perform?).to be_falsy
          expect(Errors::CommandError).to have_received(:output_error).once
        end
      end

      context 'invalid coordinates' do
        it 'displays error mesage' do
          allow(surface).to receive(:include_x_y?).and_return(false)
          allow(Errors::CommandError).to receive(:output_error)
            .with('The movement is not safe, robot would fall from surface')
          expect(subject.perform?).to be_falsy
          expect(Errors::CommandError).to have_received(:output_error).once
          expect(surface).to have_received(:include_x_y?).once
        end
      end
    end

    describe 'perform' do
      let(:robot) { Entities::Robot.new }

      it 'persists robot attributes' do
        robot.x = 1
        robot.y = 2
        robot.orientation = 'NORTH'
        expect { subject.perform }.to change { robot.y }.by(1)
      end
    end
  end
end
