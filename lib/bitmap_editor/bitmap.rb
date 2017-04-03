module BitmapEditor
  EMPTY_VALUE = 'O'

  class Bitmap
    def initialize(width, height, initial_value = EMPTY_VALUE)
      @width = width
      @height = height
      @matrix = Array.new(height) { Array.new(width, initial_value) }
    end

    def set(x_min, x_max, y_min, y_max, val)
      validate_range(x_min, x_max, y_min, y_max)
      # modify indices to work with 1-base-indexing
      ((y_min-1)..(y_max-1)).each do |row|
        @matrix[row].fill(val, x_min-1, x_max-x_min+1)
      end
    end

    def set_cell(x, y, val)
      set(x, x, y, y, val)
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

    private

    def validate_range(x_min, x_max, y_min, y_max)
      errors = []
      errors << "minimum x (#{x_min}) cannot be less than 1" if (x_min < 1)
      errors << "maximum x (#{x_max}) cannot be greater than #{@width}" if (x_max > @width)
      errors << "minimum y (#{y_min}) cannot be less than 1" if (y_min < 1)
      errors << "maximum y (#{y_max}) cannot be greater than #{@height}" if (y_max > @height)

      raise errors.join(', ') if !errors.empty?
    end
  end
end
