module BitmapEditor
  class Bitmap
    EMPTY_VALUE = 'O'
    MAX_SIZE = 250

    def initialize(width, height, initial_value = EMPTY_VALUE)
      @width = width
      @height = height
      validate_size

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

    def set_vertical_segment(x, y1, y2, val)
      set(x, x, y1, y2, val)
    end

    def set_horizontal_segment(x1, x2, y, val)
      set(x1, x2, y, y, val)
    end

    def clear
      fill(EMPTY_VALUE)
    end

    def fill(value)
      @matrix.each do |row|
        row.fill(value)
      end
    end

    def print
      puts to_s
    end

    def to_s
      @matrix.map do |row|
        row.join('')
      end.join("\n")
    end

    private

    def validate_size
      errors = []
      errors << "width (#{@width}) must be a positive, non-zero integer" if (@width < 1)
      errors << "height (#{@height}) must be a positive, non-zero integer" if (@height < 1)
      errors << "width (#{@width}) cannot be greater than #{MAX_SIZE}" if (@width > MAX_SIZE)
      errors << "height (#{@height}) cannot be greater than #{MAX_SIZE}" if (@height > MAX_SIZE)
      raise errors.join(', ') if !errors.empty?
    end

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
