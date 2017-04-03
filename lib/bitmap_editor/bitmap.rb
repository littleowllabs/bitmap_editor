module BitmapEditor
  class Bitmap
    def initialize(width, height)
      @matrix = Array.new(height) { Array.new(width, 0) }
    end

    def to_s
      @matrix.map do |row|
        row.join('')
      end.join("\n")
    end
  end
end
