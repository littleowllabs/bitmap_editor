RSpec.describe BitmapEditor::Bitmap do
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
end
