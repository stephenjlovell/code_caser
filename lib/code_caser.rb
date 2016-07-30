
Dir["./lib/code_caser/*.rb"].each {|file| require file }

module CodeCaser
  def self.to_camel(opts)
    Caser.new(opts.merge({ converter: SnakeConverter.new })).start
  end

  def self.to_snake(opts)
    Caser.new(opts.merge({ converter: CamelConverter.new })).start
  end
end
