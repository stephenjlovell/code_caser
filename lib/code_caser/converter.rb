module CodeCaser
  class CamelConverter
    def convert_line(str)
      # str.gsub(/(.)([A-Z][a-z]+)/,'\1_\2').gsub(/([a-z0-9])([A-Z])/,'\1_\2').downcase
      str.gsub(/([a-z])([A-Z][a-z]+)/, '\1_\2').gsub(/([a-z])([A-Z][a-z]+)/, '\1_\2').downcase
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
