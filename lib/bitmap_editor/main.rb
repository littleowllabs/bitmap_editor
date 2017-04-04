module BitmapEditor
  module Main
    def self.run(file)
      return puts "please provide correct file" if file.nil? || !File.exists?(file)

      bitmap = nil
      begin
        File.open(file).each do |line|
          line = line.chomp
          bitmap = modify_bitmap(line, bitmap)
        end
      rescue RuntimeError => e
        puts e.message
      end
    end

    def self.modify_bitmap(line, original_bitmap = nil)
      bitmap = original_bitmap
      case line
        when /^I (\d+) (\d+)$/
          bitmap = Bitmap.new($1.to_i, $2.to_i)
        when /^L (\d+) (\d+) ([A-Z])$/
          check_bitmap_exists(bitmap)
          bitmap.set_cell($1.to_i, $2.to_i, $3)
        when 'C'
          check_bitmap_exists(bitmap)
          bitmap.clear
        when /^V (\d+) (\d+) (\d+) ([A-Z])$/
          check_bitmap_exists(bitmap)
          bitmap.set_vertical_segment($1.to_i, $2.to_i, $3.to_i, $4)
        when /^H (\d+) (\d+) (\d+) ([A-Z])$/
          check_bitmap_exists(bitmap)
          bitmap.set_horizontal_segment($1.to_i, $2.to_i, $3.to_i, $4)
        when 'S'
          check_bitmap_exists(bitmap)
          bitmap.print
        else
          raise 'unrecognised command :('
      end
      bitmap
    end

    def self.check_bitmap_exists(bitmap)
      raise 'Bitmap not created yet' if bitmap.nil?
    end
  end
end
