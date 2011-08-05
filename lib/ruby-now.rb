# A ruby newbie am I!

require 'eventmachine'
require 'json'
require 'util'
require 'namedblock'

module BidirectionalJsonRadio
  @@conn = []
  def self.conn
    @@conn
  end
  def self.registerFunction name, block
    Util.registerFunction name, block
  end
  def initialize
    @@conn.push self
  end
  def post_init
    send_data Util.functions.keys.to_json
  end
  def receive_data data
    Util.processData(JSON.parse data)
  end
  def unbind
    @@conn.delete self
  end
end

EventMachine::run {
  EventMachine::start_server "127.0.0.1", 8081, BidirectionalJsonRadio
  BidirectionalJsonRadio.registerFunction('aFunctionObject', lambda{|*a|
                                            puts a.join(' ')})
  BidirectionalJsonRadio.registerFunction('otherFunc', lambda{|cb, *a|
                                            cb.call(a.join(' '))})
  puts 'running json radio of happiness on port 8081 of your microwave'
}
