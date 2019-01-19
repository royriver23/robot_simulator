module RobotSimulator
  RSpec.describe Factories::OutputterFactory do
    describe 'self.get_outputter' do
      context 'when valid command' do
        it 'returns a instance of command' do
          cmd = described_class.get_outputter('json', robot: double('robot'), surface: double('surface'))
          expect(cmd).to be_kind_of(Outputters::JsonOutputter)
        end
      end

      context 'when invalid command' do
        it 'raises an error' do
          expect { described_class.get_outputter('xml', {}) }.to raise_error(NoMethodError)
        end
      end
    end

    describe 'self.outputter_class' do
      context 'when valid command' do
        it 'returns class reference' do
          expect(described_class.outputter_class('plain_text')).to eq(Outputters::PlainTextOutputter)
        end
      end

      context 'when invalid command' do
        it 'returns nil' do
          expect(described_class.outputter_class('gif')).to be_nil
        end
      end
    end
  end
end
