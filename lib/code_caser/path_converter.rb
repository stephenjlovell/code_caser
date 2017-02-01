module CodeCaser
  class PathConverter

    def initialize(path)
      @path = File.directory?(path) ? File.join(path, "*") : path
    end

    def dirname
      File.expand_path(File.dirname(@path))
    end

    def join(name)
      File.join(dirname + name)
    end

    def get_files
      Dir.glob(File.expand_path(@path))
    end
  end
end
