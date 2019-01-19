module RobotSimulator
  RSpec.describe CommandDataExtractor do
    let(:command) { 'PLACE 1,2,NORTH' }
    subject { described_class.new(command: command) }

    it 'has appropiate readers' do
      expect(subject).to have_attr_reader(:cli_data)
    end

    describe 'initialize' do
      it 'populates has correct keys' do
        %i[command_verb command_params full_command].each do |key|
          expect(subject.cli_data).to have_key(key)
        end
      end

      it 'populates data correctly' do
        expected_hash = {
          command_verb: 'PLACE',
          command_params: %w[1 2 NORTH],
          full_command: command
        }

        expect(subject.cli_data).to eq(expected_hash)
      end
    end

    describe 'valid?' do
      it 'calls CommandValidator' do
        allow(Validators::CommandValidator).to receive_message_chain(:new, :valid_syntax?)
        subject.valid?

        expect(Validators::CommandValidator).to have_received(:new).once
      end
    end
  end
end
