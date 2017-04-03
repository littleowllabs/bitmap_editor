RSpec.describe BitmapEditor::Bitmap do
  describe 'initialise' do
    let (:bitmap) { described_class.new(2,3) }
    subject { bitmap.to_s }

    it { is_expected.to eq( "00\n00\n00" )}
  end
end
