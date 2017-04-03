module BitmapEditor
  EMPTY_VALUE = 0

  class Bitmap
    def initialize(width, height, initial_value = EMPTY_VALUE)
      @width = width
      @height = height
      @matrix = Array.new(height) { Array.new(width, initial_value) }
    end

    def clear
      fill(EMPTY_VALUE)
    end

    def fill(value)
      @matrix.each do |row|
        row.fill(value)
      end
    end

    def to_s
      @matrix.map do |row|
        row.join('')
      end.join("\n")
    end
  end
end
