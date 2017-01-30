require 'colorize'
# require 'pry'

module CodeCaser
  class Converter
    def initialize(opts={})
      if opts[:ignore_after]
        @ignore_after = Regexp.new('(^.*?)(' + Regexp.escape(opts[:ignore_after]) + '.*)')
      end
    end

    def convert_line(line, verbose=false)
      converted_line = if @ignore_after && (data = match_data(line))
        convert_string(data[1]) + data[2]
      else
        convert_string(line)
      end
      if verbose && converted_line != line
        puts "\n   " + line.strip
        puts "   " + converted_line.strip.colorize(:green)
      end
      # binding.pry
      converted_line
    end

    def chop(line)
      @ignore_after && (data = match_data(line)) ? data[1] : line
    end

    def convert_string # concrete Converter implementations must supply this method
      raise NotImplementedError
    end

    private

    def match_data(line)
      line.match(@ignore_after)
    end
  end

  class CamelConverter < Converter
    def convert_string(str)
      match = false
      output = str.reverse.gsub(/([a-z]+[A-Z]\B)(.)(?!\w*[A-Z]\b)/) { |s|
        match = true
        ($1.to_s + '_' + $2.to_s)
      }.gsub(/([A-Z])([a-z0-9])(?!\w*[A-Z]\b)/) { |s|
        match = true
        ($1.to_s + '_' + $2.to_s)
      }.reverse
      match ? output.downcase : output
    end

    def description
      "camelCase to snake_case"
    end
  end

  class SnakeConverter < Converter
    def convert_string(str)
      str.gsub(/([a-z0-9])_([a-z0-9])/) { |s| $1 + $2.upcase }
    end

    def description
      "snake_case to camelCase"
    end
  end
end
