module CodeCaser
  class CamelConverter
    def convert_line(str)
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

  class SnakeConverter
    def convert_line(str)
      str.gsub(/([a-z0-9])_([a-z0-9])/) { |s| $1 + $2.upcase }
    end

    def description
      "snake_case to camelCase"
    end
  end
end
