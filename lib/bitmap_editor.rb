require_relative 'bitmap_editor/main'
require_relative 'bitmap_editor/bitmap'

module BitmapEditor
  def self.run(file)
    BitmapEditor::Main.run(file)
  end
end
