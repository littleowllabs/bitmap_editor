RSpec.describe BitmapEditor::Main do
  describe '#modify_bitmap' do
    describe 'I M N' do
      subject { BitmapEditor::Main.modify_bitmap('I 3 3') }

      it { is_expected.to be_instance_of(BitmapEditor::Bitmap) }
    end

    describe 'C' do
      context 'with no bitmap defined' do
        it 'raises an error' do
          expect { BitmapEditor::Main.modify_bitmap('C', nil) }
            .to raise_error(RuntimeError, 'Bitmap not created yet')
        end
      end

      context 'with a bitmap defined' do
        let (:bitmap) { instance_double("BitmapEditor::Bitmap") }
        it 'sends the clear instruction on to the bitmap' do
          expect(bitmap).to receive(:clear)
          BitmapEditor::Main.modify_bitmap('C', bitmap)
        end
      end
    end

    describe 'L X Y C' do
      context 'with no bitmap defined' do
        it 'raises an error' do
          expect { BitmapEditor::Main.modify_bitmap('L 1 1 A', nil) }
            .to raise_error(RuntimeError, 'Bitmap not created yet')
        end
      end

      context 'with a bitmap defined' do
        let(:bitmap) { instance_double("BitmapEditor::Bitmap") }
        it 'passes the instructions on to the bitmap' do
          expect(bitmap).to receive(:set_cell).with(1, 1, 'A')
          BitmapEditor::Main.modify_bitmap('L 1 1 A', bitmap)
        end
      end
    end

    describe 'V X Y1 Y2 C' do
      context 'with no bitmap defined' do
        it 'raises an error' do
          expect { BitmapEditor::Main.modify_bitmap('V 1 1 2 A', nil) }
            .to raise_error(RuntimeError, 'Bitmap not created yet')
        end
      end

      context 'with a bitmap defined' do
        let(:bitmap) { instance_double("BitmapEditor::Bitmap") }
        it 'passes the instructions on to the bitmap' do
          expect(bitmap).to receive(:set_vertical_segment).with(1, 1, 2, 'A')
          BitmapEditor::Main.modify_bitmap('V 1 1 2 A', bitmap)
        end
      end
    end

    describe 'H X1 X2 Y C' do
      context 'with no bitmap defined' do
        it 'raises an error' do
          expect { BitmapEditor::Main.modify_bitmap('H 1 2 1 A', nil) }
            .to raise_error(RuntimeError, 'Bitmap not created yet')
        end
      end

      context 'with a bitmap defined' do
        let(:bitmap) { instance_double("BitmapEditor::Bitmap") }
        it 'passes the instructions on to the bitmap' do
          expect(bitmap).to receive(:set_horizontal_segment).with(1, 2, 1, 'A')
          BitmapEditor::Main.modify_bitmap('H 1 2 1 A', bitmap)
        end
      end
    end

    describe 'S' do
      context 'with no bitmap defined' do
        it 'raises an error' do
          expect { BitmapEditor::Main.modify_bitmap('S', nil) }
            .to raise_error(RuntimeError, 'Bitmap not created yet')
        end
      end

      context 'with a bitmap defined' do
        let (:bitmap) { instance_double("BitmapEditor::Bitmap") }
        it 'sends the clear instruction on to the bitmap' do
          expect(bitmap).to receive(:print)
          BitmapEditor::Main.modify_bitmap('S', bitmap)
        end
      end
    end
  end
end
