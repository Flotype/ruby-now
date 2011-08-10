# A ruby newbie am I!

require 'eventmachine'
require 'json'
require 'util'
require 'namedblock'

module RubyNow
  @@conn = []
  def self.conn
    @@conn
  end

  def self.getUserFunction user, fqn
    Util.makeUsercaller user, fqn
  end

  def self.getGroupFunction group, fqn
    Util.makeMulticaller group, fqn
  end

  def self.registerFunction name, block
    Util.registerFunction name, block
  end

  def initialize
    @@conn.push self
  end

  def post_init
    #send_data Util.functions.keys.to_json
  end

  def receive_data data
    Util.processData(JSON.parse data)
  end

  def unbind
    @@conn.delete self
  end
end
