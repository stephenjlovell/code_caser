
Dir["./lib/code_caser/*.rb"].each {|file| require file }

module CodeCaser

  def self.to_camel(opts)
    caser = Caser.new(opts.merge({ converter: CamelConverter.new }))
    caser.start
  end

  def self.to_snake(opts)
    caser = Caser.new(opts.merge({ converter: SnakeConverter.new }))
    caser.start
  end

end
