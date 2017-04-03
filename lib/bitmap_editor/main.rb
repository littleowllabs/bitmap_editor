module BitmapEditor
  module Main
    def self.run(file)
      return puts "please provide correct file" if file.nil? || !File.exists?(file)

      File.open(file).each do |line|
        line = line.chomp
        case line
        when 'S'
          bitmap = Bitmap.new(2,3)
          puts bitmap
        else
          puts 'unrecognised command :('
        end
      end
    end
  end
end
