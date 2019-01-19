module RobotSimulator
  RSpec.describe Factories::CommandFactory do
    describe 'self.instance' do
      context 'when valid command' do
        it 'returns a instance of command' do
          params = %w[1 2 north]
          cmd = described_class.instance('PLACE', params: params, robot: double('robot'), surface: double('surface'))
          expect(cmd).to be_kind_of(Commands::Place)
        end
      end

      context 'when invalid command' do
        it 'raises an error' do
          expect { described_class.instance('DANCE', {}) }.to raise_error(NoMethodError)
        end
      end

      context 'wrong number of params' do
        it 'raises an error' do
          params = %w[1 2 north south]
          expect do
            described_class.instance('PLACE', params: params, robot: double('robot'), surface: double('surface'))
          end.to raise_error(IndexError)
        end
      end
    end

    describe 'self.command_class' do
      context 'when valid command' do
        it 'returns class reference' do
          expect(described_class.command_class('PLACE')).to eq(Commands::Place)
        end
      end

      context 'when invalid command' do
        it 'returns nil' do
          expect(described_class.command_class('DANCE')).to be_nil
        end
      end
    end
  end
end
