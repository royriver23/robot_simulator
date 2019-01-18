module RobotSimulator
  RSpec.describe Commands::Place do
    let(:robot) { double('robot', { x: 1, y: 2, orientation: 'NORTH' }) }
    let(:surface) { double('surface', { with: 5, height: 5 }) }
    let(:params) { %w(1 2 NORTH) }
    subject { described_class.new(robot: robot, surface: surface, params: params) }

    shared_examples "place validations" do |invalid_params, param_name|
      context 'when valid value' do
        it 'passes validation' do
          expect(described_class.send("#{param_name}_validation", subject.params[param_name])).to be_truthy
        end
      end

      context 'when invalid value' do
        it 'does not pass validation' do
          expect(described_class.send("#{param_name}_validation", invalid_params)).to be_falsy
        end
      end
    end

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

    describe 'x_validation' do
      include_examples "place validations", %w(NaN 2 NORTH), 'x'
    end

    describe 'y_validation' do
      include_examples "place validations", %w(1 NaN NORTH), 'y'
    end

    describe 'orientation_validation' do
      include_examples "place validations", %w(1 2 NORTHWEST), 'orientation'
    end

    describe 'perform?' do
      context 'valid coordinates' do
        it 'returns true' do
          allow(surface).to receive(:include_x_y?).and_return(true)
          expect(subject.perform?).to be_truthy
        end
      end

      context 'invalid coordinates' do
        it 'returns error' do
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
      it 'persists robot attributes' do
        allow(robot).to receive_messages(%w[placed= orientation= x= y=])
        subject.perform
        expect(robot).to match_attributes(Hash[*[described_class::PARAMS_CONFIG, params].transpose.flatten(1)])
      end
    end
  end
end
