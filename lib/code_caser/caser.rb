module CodeCaser

  class Caser
    def initialize(opts = {})
      @converter = opts[:converter]
      @target = opts[:target]
      @save      = opts[:save] || true
    end

    def start
      files = Dir.glob(@target)
      unless files.empty?
        puts "converting files from #{@converter.description}:"
        files.each do |f|
          convert_file(f)
          puts "-> #{f}"
        end
      else
        puts "file or folder location not found: #{@target}"
      end
    end

    def convert_file(file_path)
      # if the option is set, preserve the original file.
      original = File.join(File.dirname(file_path), File.basename(file_path, ".*") +
        "_old" + File.extname(file_path))
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
