module RobotSimulator
  RSpec.describe Validators::CommandValidator do
    let(:robot) { double('robot')}
    let(:cli_data) { { command_verb: 'PLACE', command_params: %w[1 2 NORTH] } }

    subject { described_class.new(cli_data: cli_data) }

    describe 'valid_syntax?' do
      context 'when valid' do
        it 'returns true' do
          expect(subject.valid_syntax?).to be_truthy
        end
      end

      context 'when valid verb and no params' do
        let(:cli_data) { { command_verb: 'MOVE', command_params: [] } }

        it 'returns true' do
          expect(subject.valid_syntax?).to be_truthy
        end
      end

      context 'when invalid command verb' do
        let(:cli_data) { { command_verb: 'JUMP', command_params: %w[1 2 NORTH] } }

        it 'displays error' do
          allow(Errors::CommandError).to receive(:output_error)
            .with('Command not found')
          expect(subject.valid_syntax?).to be_falsy
          expect(Errors::CommandError).to have_received(:output_error).once
        end
      end

      context 'when invalid number of params' do
        let(:cli_data) { { command_verb: 'PLACE', command_params: %w[1 2 NORTH SD] } }

        it 'displays error' do
          allow(Errors::CommandError).to receive(:output_error)
            .with("Given: #{cli_data[:command_params].size},
            Expected: #{subject.send(:command_class)::PARAMS_CONFIG.size}")
          expect(subject.valid_syntax?).to be_falsy
          expect(Errors::CommandError).to have_received(:output_error).once
        end
      end

      context 'when specific params are invalid' do
        let(:cli_data) { { command_verb: 'PLACE', command_params: %w[1 2 NORTHWEST] } }

        it 'displays error' do
          allow(Errors::CommandError).to receive(:output_error)
            .with("The orientation value is not valid")
          expect(subject.valid_syntax?).to be_falsy
          expect(Errors::CommandError).to have_received(:output_error).once
        end
      end
    end
  end
end
