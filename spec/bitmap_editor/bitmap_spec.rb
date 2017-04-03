RSpec.describe BitmapEditor::Bitmap do
  shared_examples_for 'a validated method' do |method, args = []|
    let(:bitmap) { described_class.new(2, 3) }
    let(:x_min) { 1 }
    let(:x_max) { 2 }
    let(:y_min) { 1 }
    let(:y_max) { 3 }

    subject { bitmap.send(method, x_min, x_max, y_min, y_max, *args) }

    context 'when all values are valid' do
      it 'does not raise an error' do
        expect { subject }.not_to raise_error
      end
    end

    context 'when min_x is less than 1' do
      let(:x_min) { 0 }
      it 'raises an error' do
        expect { subject }.to raise_error(
          RuntimeError, "minimum x (#{x_min}) cannot be less than 1"
        )
      end
    end

    context 'when max_x is greater than the width' do
      let(:x_max) { 3 }
      it 'raises an error' do
        expect { subject }.to raise_error(
          RuntimeError, "maximum x (#{x_max}) cannot be greater than 2"
        )
      end
    end

    context 'when min_y is less than 1' do
      let(:y_min) { 0 }
      it 'raises an error' do
        expect { subject }.to raise_error(
          RuntimeError, "minimum y (#{y_min}) cannot be less than 1"
        )
      end
    end

    context 'when max_y is greater than the height' do
      let(:y_max) { 4 }
      it 'raises an error' do
        expect { subject }.to raise_error(
          RuntimeError, "maximum y (#{y_max}) cannot be greater than 3"
        )
      end
    end
  end

  describe 'initialise' do
    subject { bitmap.to_s }

    context 'with the default empty value' do
      let(:bitmap) { described_class.new(2, 3) }
      it { is_expected.to eq("00\n00\n00") }
    end

    context 'with a specified fill value' do
      let(:bitmap) { described_class.new(2, 3, 'A') }
      it { is_expected.to eq("AA\nAA\nAA") }
    end
  end

  describe '#clear' do
    let(:bitmap) { described_class.new(2, 3, 'A') }
    before(:each) { bitmap.clear }
    subject { bitmap.to_s }

    it { is_expected.to eq("00\n00\n00") }
  end

  describe '#fill' do
    let(:bitmap) { described_class.new(2, 3) }
    before(:each) { bitmap.fill('A') }
    subject { bitmap.to_s }

    it { is_expected.to eq("AA\nAA\nAA") }
  end

  describe '#set' do
    it_behaves_like 'a validated method', :set, 'A'

    describe 'with all values in range' do
      let(:bitmap) { described_class.new(4, 4) }
      before(:each) { bitmap.set(2, 3, 2, 3, 'A') }
      subject { bitmap.to_s }

      it { is_expected.to eq("0000\n0AA0\n0AA0\n0000") }
    end
  end
end
