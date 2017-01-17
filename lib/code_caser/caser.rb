require 'fileutils'

module CodeCaser

  class Caser
    def initialize(opts = {})
      @converter         = opts[:converter]
      @path              = opts[:path]
      @save              = opts[:save] || true
      # @ignore_title_case = opts[:ignore_title_case] || false
    end

    def start
      convert_files(File.directory?(@path) ? @path + "*" : @path)
    end

    private

    def convert_files(file_path)
      files = get_files(file_path)
      return if files.empty? || user_aborted?(files)
      files.each { |f| convert_file(f) if File.file?(f) }
    end

    def get_files(file_path)
      Dir.glob(File.expand_path(file_path))
    end

    def convert_file(file_path)
      file_name = File.basename(file_path)
      puts "-> converting #{file_name}..."
      # if the save option is set, preserve the original file in a backup folder.
      backup_folder = File.dirname(file_path) + "_backup_#{Time.new.to_i}"
      FileUtils.mkdir_p(backup_folder)
      backup_file_path = File.join(backup_folder, file_name)
      FileUtils.cp(file_path, backup_file_path)
      # Replace the file with its converted equivalent.
      FileUtils.rm(file_path)
      f = File.new(file_path, "w+")
      IO.foreach(backup_file_path) do |line|
        f.puts(@converter.convert_line(line))
      end

      FileUtils.rm_r(backup_folder) unless @save
    end

    def user_aborted?(files)
      puts "Warning: This will convert all files listed below from #{@converter.description}:\n"
      puts files
      puts "\nMake sure your files are checked in to source control before converting."
      puts "To confirm, type 'CONVERT':"
      STDIN.gets.chomp != "CONVERT"
    end

  end

end
