require 'eventmachine'
Gem::Specification.new do |s|
  s.name = 'n00by'
  s.version = '0.0.1'
  s.homepage = 'http://nowjs.org'

  s.authors = ["Flotype"]
  s.email   = ["team@nowjs.org"]

  s.files = `git ls-files`.split("\n")

  s.add_dependency('eventmachine', '>= 1.0.0.beta.1')
  s.add_dependency('json', '>= 1.5.0')

  s.summary = 'Ruby/NowJS library'

  s.description = "n00by is a Ruby interface for NowJS, designed to be
  used as the layer of communication between a Node server running
  NowJS and a Rails server running whatever Ruby app you might have."

end
