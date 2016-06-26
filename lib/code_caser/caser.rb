require 'fileutils'

module CodeCaser

  class Caser
    def initialize(opts = {})
      @converter = opts[:converter]
      @target = opts[:target]
      @save      = opts[:save] || true
    end

    def start
      if File.directory?(@target)
        puts "converting files from #{@converter.description}:"
        Dir[@target + "/*"].each do |f|
          convert_file(f)
          puts "-> #{f}"
        end
      elsif File.file?(@target)
        convert_file(@target)
      else
        puts "file or folder location not found: #{@target}"
      end
    end

    def convert_file(file_path)
      # if the option is set, preserve the original file.
      original = File.join(File.dirname(file_path), File.basename(file_path, ".*") +
        "_old" + File.extname(file_path))
      puts file_path, original
      FileUtils.cp(file_path, original)
      FileUtils.rm(file_path)

      f = File.new(file_path, "w+")
      IO.foreach(original) do |line|
        f.puts(@converter.convert_line(line))
      end

      FileUtils.rm(original) unless @save
    end

  end

end
