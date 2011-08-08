require '~/workspace/ruby-now/lib/ruby-now.rb'

EventMachine::run {
  EventMachine::start_server "127.0.0.1", 8081, RubyNow
  RubyNow.registerFunction('aFunctionObject', lambda{|*a|
                                            puts a.join(' ')})
  RubyNow.registerFunction('otherFunc', lambda{|cb, *a|
                                            cb.call(a.join(' '))})
  puts 'Running TCP server on port 8081. Awaiting orders.'
}
