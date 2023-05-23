# frozen_string_literal: true

require_relative "lib/peplum/john/version"

Gem::Specification.new do |spec|
  spec.name = "peplum-john"
  spec.version = Peplum::John::VERSION
  spec.authors = ["Tasos Laskos"]
  spec.email = ["tasos.laskos@ecsypno.com"]

  spec.summary = "Peplum john project."
  spec.description = "Peplum john project."
  spec.homepage = "http://ecsypno.com/"
  spec.required_ruby_version = ">= 2.6.0"

  spec.files  = Dir.glob( 'bin/*')
  spec.files += Dir.glob( 'lib/**/*')
  spec.files += Dir.glob( 'examples/**/*')
  spec.files += %w(peplum-john.gemspec)


  spec.add_dependency "peplum"
end
