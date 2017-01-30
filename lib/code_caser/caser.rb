require 'fileutils'
require 'colorize'

module CodeCaser
  class Caser
    def initialize(opts = {})
      @converter      = opts.fetch(:converter)
      @path_converter = PathConverter.new(opts.fetch(:path))
      @save           = opts.fetch(:save, true)
      @verbose        = opts.fetch(:verbose, false)
    end

    def start
      files = @path_converter.get_files
      if files.empty?
        puts "File or folder not found.\n"
        return
      elsif user_aborted?(files)
        puts "File conversion aborted.\n"
        return
      end
      convert_files(files)
      puts "\n#{files.count} file(s) converted.".colorize(:green)
      if @save
        puts "Backup copies of the original files can be found here:".colorize(:green)
        puts "#{backup_folder}\n"
      end
    end

    private

    def backup_folder
      @backup_folder ||= File.dirname(@path_converter.path) + "_backup_#{Time.new.to_i}"
    end

    def convert_files(files)
      FileUtils.mkdir_p(backup_folder) # Original files will be cached to this backup folder.
      files.each { |f| convert_file(f) if File.file?(f) }
      FileUtils.rm_r(backup_folder) unless @save
    end

    def convert_file(file_path)
      file_name = File.basename(file_path)
      puts "-> Converting #{file_name}...".colorize(:blue) if @verbose
      backup_file_path = File.join(backup_folder, file_name)
      FileUtils.cp(file_path, backup_file_path)
      # Replace the file with its converted equivalent.
      FileUtils.rm(file_path)
      f = File.new(file_path, "w+")
      IO.foreach(backup_file_path) do |line|
        f.puts(convert_line(line.chomp))
      end
    end

    def convert_line(line)
      @converter.convert_line(line, @verbose)
    end

    def user_aborted?(files)
      puts "Warning: This will convert all files listed below from #{@converter.description}.\n".colorize(:yellow)
      puts "No back-ups of these files will be created.\n".colorize(:yellow) unless @save
      puts files
      puts ("\nMake sure your files are checked in to source control before converting." +
            "\nTo confirm, type 'CONVERT':").colorize(:yellow)
      STDIN.gets.chomp != "CONVERT"
    end

  end

end
