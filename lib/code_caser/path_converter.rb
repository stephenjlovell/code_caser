module CodeCaser
  class PathConverter
    attr_reader :path

    def initialize(path)
      @path = File.directory?(path) ? File.join(path, "*") : path
    end

    def get_files
      Dir.glob(File.expand_path(@path))
    end
  end
end
