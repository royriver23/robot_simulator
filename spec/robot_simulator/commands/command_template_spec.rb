module RobotSimulator
  RSpec.describe Commands::CommandTemplate do
    let(:robot) { double('robot', { x: 1, y: 2, orientation: 'NORTH' }) }
    let(:surface) { double('surface', { with: 5, height: 5 }) }
    let(:params) { [] }
    subject { described_class.new(robot: robot, surface: surface, params: params) }

    it 'has appropiate accessors' do
      expect(subject).to have_attr_accessor(:robot)
      expect(subject).to have_attr_accessor(:surface)
      expect(subject).to have_attr_accessor(:params)
    end

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

    describe 'is_integer?' do
      context 'when is not an integer' do
        it 'returns false if string' do
          expect(described_class.is_integer?('Ruby')).to be_falsy
        end

        it 'returns false if float' do
          expect(described_class.is_integer?('2.5')).to be_falsy
        end
      end

      context 'when is an integer' do
        it 'returns true' do
          expect(described_class.is_integer?('2')).to be_truthy
        end
      end
    end
  end
end
