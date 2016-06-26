# encoding: utf-8
require File.expand_path("../lib/code_caser/version", __FILE__)

Gem::Specification.new do |s|
  s.name                        = "code_caser"
  s.version                     = "#{CodeCaser::VERSION}"
  s.date                        = Time.now.strftime('%Y-%m-%d')
  s.summary                     = "Convert files from snake_case to camelCase and back."
  s.description                 = "A simple utility gem to convert files from snake_case to camelCase and back."
  s.homepage                    = "https://github.com/stephenjlovell/code_caser"
  s.email                       = [ "sjlovell34@gmail.com" ]
  s.authors                     = [ "Steve Lovell" ]
  s.platform                    = Gem::Platform::RUBY
  s.license                     = 'MIT'

  s.executables                 = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.files                       = %w[Gemfile Rakefile] + Dir.glob("{lib}/**/*")
  s.extra_rdoc_files            = %w[LICENSE README.md CHANGELOG.md]
  s.require_paths               = ["lib"]
  s.add_dependency              "thor"
  s.add_development_dependency  "rspec"
end
