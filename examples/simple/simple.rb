require '~/workspace/ruby-now/lib/ruby-now.rb'

EventMachine::run {
  EventMachine::start_server "127.0.0.1", 8081, RubyNow
  RubyNow.registerFunction('a', lambda{|*a|
                             puts a.join(' ')})
  RubyNow.registerFunction('b', lambda{|cb, *a|
                             cb.call(a.join(' '))})

  RubyNow.registerFunction('c', lambda{|cb|
                             fn = RubyNow.getGroupFunction("everyone", "now.callMe")
                             fn.call(cb)
                           })

  puts 'Running TCP server on port 8081. Awaiting orders.'
}
