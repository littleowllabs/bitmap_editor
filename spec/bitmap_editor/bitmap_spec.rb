RSpec.describe BitmapEditor::Bitmap do
  describe 'initialise' do
    subject { bitmap.to_s }

    context 'with the default empty value' do
      let(:bitmap) { described_class.new(2, 3) }
      it { is_expected.to eq("OO\nOO\nOO") }
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

    it { is_expected.to eq("OO\nOO\nOO") }
  end

  describe '#fill' do
    let(:bitmap) { described_class.new(2, 3) }
    before(:each) { bitmap.fill('A') }
    subject { bitmap.to_s }

    it { is_expected.to eq("AA\nAA\nAA") }
  end

  describe '#set' do
    context 'with invalid values' do
      let(:bitmap) { described_class.new(2, 3) }
      let(:x_min) { 1 }
      let(:x_max) { 2 }
      let(:y_min) { 1 }
      let(:y_max) { 3 }

      subject { bitmap.set(x_min, x_max, y_min, y_max, 'A') }

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

      context 'when everything is wrong' do
        let(:x_min) { 0 }
        let(:x_max) { 3 }
        let(:y_min) { 0 }
        let(:y_max) { 4 }
        it 'raises an error' do
          expect { subject }.to raise_error(
            RuntimeError, "minimum x (#{x_min}) cannot be less than 1, maximum x (#{x_max}) cannot be greater than 2, minimum y (#{y_min}) cannot be less than 1, maximum y (#{y_max}) cannot be greater than 3"
          )
        end
      end
    end

    describe 'with all values in range' do
      let(:bitmap) { described_class.new(4, 4) }
      before(:each) { bitmap.set(2, 3, 2, 3, 'A') }
      subject { bitmap.to_s }

      it { is_expected.to eq("OOOO\nOAAO\nOAAO\nOOOO") }
    end
  end

  describe '#set_cell' do
    let(:x) { 2 }
    let(:y) { 2 }
    let(:bitmap) { described_class.new(2, 3) }
    subject { bitmap.set_cell(x, y, 'A') }

    context 'when x is less than 1' do
      let(:x) { 0 }
      it 'raises an error' do
        expect { subject }.to raise_error(
          RuntimeError, "minimum x (#{x}) cannot be less than 1"
        )
      end
    end

    context 'when x is greater than the width' do
      let(:x) { 3 }
      it 'raises an error' do
        expect { subject }.to raise_error(
          RuntimeError, "maximum x (#{x}) cannot be greater than 2"
        )
      end
    end

    context 'when y is less than 1' do
      let(:y) { 0 }
      it 'raises an error' do
        expect { subject }.to raise_error(
          RuntimeError, "minimum y (#{y}) cannot be less than 1"
        )
      end
    end

    context 'when y is greater than the height' do
      let(:y) { 4 }
      it 'raises an error' do
        expect { subject }.to raise_error(
          RuntimeError, "maximum y (#{y}) cannot be greater than 3"
        )
      end
    end

    describe 'with all values in range' do
      before(:each) { bitmap.set_cell(x, y, 'A') }
      subject { bitmap.to_s }
      it { is_expected.to eq("OO\nOA\nOO") }
    end
  end
end
