# encoding: utf-8
require File.expand_path("../lib/code_caser/version", __FILE__)

Gem::Specification.new do |s|
  s.name                        = "code_caser"
  s.version                     = "#{CodeCaser::VERSION}"
  s.date                        = Time.now.strftime('%Y-%m-%d')
  s.summary                     = "Convert files from snake_case to camelCase and vice versa."
  s.description                 = "A simple utility gem to convert files from snake_case to camelCase and and vice versa."
  s.homepage                    = "https://github.com/stephenjlovell/code_caser"
  s.email                       = [ "sjlovell34@gmail.com" ]
  s.authors                     = [ "Steve Lovell" ]
  s.platform                    = Gem::Platform::RUBY
  s.license                     = "MIT"
  s.files                       = %w[Gemfile Rakefile] + Dir.glob("{lib}/**/*")
  s.executables                 = Dir.glob("bin/*").map { |f| File.basename(f) }
  s.extra_rdoc_files            = %w[LICENSE README.md CHANGELOG.md]
  s.require_paths               = ["lib"]
  s.required_ruby_version       = '>= 1.9.3'
  s.add_dependency              'thor', '~> 0.19.1'
  s.add_dependency              'colorize', '~> 0.8.1'
  s.add_development_dependency  'rspec', '~> 3.4'
end
