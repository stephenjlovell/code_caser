module CodeCaser

  # This class scans the provided files to determine if any converted identifiers
  # overlap with existing identifiers.
  class Analyzer
    def initialize(opts)
      @converter               = opts[:converter]
      @files                   = opts[:files] || []
      @existing_identifiers    = {}
      @new_identifiers         = {}
      @overlapping_identifiers = []
    end

    def analyze
      @files.each { |f| analyze_file(f) if File.file?(f) }
      @new_identifiers.each { |id,v| @overlapping_identifiers << id if @existing_identifiers.has_key(id) }
      if @overlapping_identifiers.empty?
        puts "No overlapping identifiers found".colorize(:green)
      else
        puts "The following identifiers would overlap with existing names:".colorize(:yellow)
        @overlapping_identifiers.each {|i| puts i.colorize(:yellow) }
      end
    end


    def analyze_file(file_path)
      IO.foreach(file_path) { |line| analyze_line(line) }
    end

    private

    def analyze_line(original_line)
      store_identifiers(original_line, @existing_identifiers)
      store_identifiers(@converter.convert_line(original_line), @new_identifiers)
    end

    def store_identifiers(line, identifiers)
      parse_identifiers(line).each {|id| identifiers[id] = true }
    end

    def parse_identifiers(line)
      line = @converter.split(line)[0] # discard anything after the ignore_after identifier, if any
      line.split(/\W+/)
    end

  end

end
