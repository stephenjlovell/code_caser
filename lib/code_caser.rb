
Dir[File.dirname(__FILE__) + '/code_caser/*.rb'].each { |file| require file }

module CodeCaser
  def self.to_camel(opts)
    Caser.new(opts.merge(converter: SnakeConverter.new(opts))).start
  end

  def self.to_snake(opts)
    Caser.new(opts.merge(converter: CamelConverter.new(opts))).start
  end

  module Analyze
    def self.to_camel(opts)
      Analyzer.new(opts.merge(converter: SnakeConverter.new(opts))).analyze
    end

    def self.to_snake(opts)
      Analyzer.new(opts.merge(converter: CamelConverter.new(opts))).analyze
    end
  end
end
