module RobotSimulator
  RSpec.describe Errors::CommandError do
    describe 'self.output_error?' do
      before do
        $OUTPUTTERS = %w[json ascii]
        allow(Factories::OutputterFactory).to receive_message_chain(:get_outputter, :error)

        # temporarily supress puts
        $stdout = File.open(File::NULL, "w")
      end

      it 'calls configured outputters' do
        described_class.output_error('Something wrong happened')
        expect(Factories::OutputterFactory).to have_received(:get_outputter).exactly($OUTPUTTERS.size).times
      end

      it 'returns false' do
        expect(described_class.output_error('Something wrong happened')).to be_falsy
      end
    end
  end
end
