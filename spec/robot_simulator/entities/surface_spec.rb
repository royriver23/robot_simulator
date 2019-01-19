module RobotSimulator
  RSpec.describe Entities::Surface do
    let(:params) { { width: '5', height: '5' } }
    subject { described_class.new(params) }

    it 'has appropiate readers' do
      expect(subject).to have_attr_reader(:width)
      expect(subject).to have_attr_reader(:height)
    end

    describe 'initialize' do
      it 'sets attributes as integer' do
        subject.width.is_a? Integer
        subject.height.is_a? Integer
      end
    end

    describe 'include_x_y?' do
      context 'when x is out of surface' do
        it 'returns false' do
          expect(subject.include_x_y?(x: subject.width.to_i.next, y: 0)).to be_falsy
        end
      end

      context 'when y is out of surface' do
        it 'returns false' do
          expect(subject.include_x_y?(x: 0, y: subject.height.to_i.next)).to be_falsy
        end
      end

      context 'when coordinates are inside surface' do
        it 'returns true' do
          expect(subject.include_x_y?(x: 0, y: 0)).to be_truthy
        end
      end
    end
  end
end
