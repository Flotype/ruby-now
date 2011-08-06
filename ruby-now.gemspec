require 'eventmachine'
Gem::Specification.new do |s|
  s.name = 'ruby-now'
  s.version = '0.0.2'
  s.homepage = 'http://nowjs.org'

  s.authors = ["Flotype"]
  s.email   = ["team@nowjs.org"]

  s.files = `git ls-files`.split("\n")

  s.add_dependency('eventmachine', '>= 1.0.0.beta.1')
  s.add_dependency('json', '>= 1.5.0')

  s.summary = 'Ruby/NowJS library'

  s.description = "ruby-now is a Ruby interface for NowJS, designed to be
  used as the layer of communication between a Node server running
  NowJS and a Rails server running whatever Ruby app you might have."

end
