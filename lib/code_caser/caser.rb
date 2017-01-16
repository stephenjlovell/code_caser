require 'fileutils'

module CodeCaser

  class Caser
    def initialize(opts = {})
      @converter         = opts[:converter]
      @path              = opts[:path]
      @save              = opts[:save] || true
      @ignore_title_case = opts[:ignore_title_case] || false
    end

    def start
      if File.directory?(@path)
        Dir[@path + "/*"].each { |f| convert_file(f) if File.file?(f) }
      elsif File.file?(@path)
        convert_file(@path)
      else
        puts "file or folder location not found: #{@path}"
      end
    end

    def convert_file(file_path)
      # if the option is set, preserve the original file.
      original = File.join(File.dirname(file_path), File.basename(file_path, ".*") +
        "_#{Time.new.to_i}" + File.extname(file_path))
      FileUtils.cp(file_path, original)
      FileUtils.rm(file_path)

      f = File.new(file_path, "w+")
      IO.foreach(original) do |line|
        f.puts(@converter.convert_line(line))
      end

      FileUtils.rm(original) unless @save
      puts "-> #{file_path}"
    end

  end

end
