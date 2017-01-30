module CodeCaser

  # This class scans the provided files to determine if any converted identifiers
  # overlap with existing identifiers.
  class Analyzer
    def initialize(opts)
      @converter               = opts.fetch(:converter)
      @files                   = PathConverter.new(opts.fetch(:path)).get_files
      @verbose                 = opts.fetch(:verbose, false)
      @existing_identifiers    = {}
      @new_identifiers         = {}
      @overlapping_identifiers = []
    end

    def analyze
      load_existing_identifiers
      @files.each { |f| analyze_file(f) if File.file?(f) }
      # puts @existing_identifiers.inspect
      puts @new_identifiers.inspect
      @overlapping_identifiers = @new_identifiers.select {|k,v| @existing_identifiers.key?(k) }.keys
      print_overlap
    end

    def load_existing_identifiers
      @files.each { |f| load_existing_identifiers_from_file(f) if File.file?(f) }
    end

    def load_existing_identifiers_from_file(file_path)
      puts "loading file: #{file_path}" if @verbose
      IO.foreach(file_path) { |line| load_existing_identifiers_from_line(line) }
    end

    def load_existing_identifiers_from_line(line)
      split_line(line).each { |l| @existing_identifiers[l] = true }
    end

    def analyze_file(file_path)
      puts "loading file: #{file_path}" if @verbose
      IO.foreach(file_path) { |line| analyze_line(line) }
    end

    def print_overlap
      if @overlapping_identifiers.empty?
        puts "No overlapping identifiers found".colorize(:green)
      else
        puts "The following identifiers would overlap with existing names:".colorize(:yellow)
        puts @overlapping_identifiers.join(",").colorize(:yellow)
      end
    end

    private

    def analyze_line(original_line)
      # discard anything after the ignore_after identifier
      original_identifiers = @converter.chop(original_line).split(/\W+/)
      original_identifiers.each do |identifier|
        if identifier != (new_identifier = @converter.convert_line(identifier))
          @new_identifiers[new_identifier] = identifier
        end
      end
    end

    def split_line(line)
      @converter.chop(line).split(/\W+/)
    end

  end

end
