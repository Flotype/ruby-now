module Util
  @@closures = {}
  @@functions = {}

  def self.functions
    @@functions
  end

  def self.registerFunction name, block
    block = NamedBlock.new(&block)
    block.name name
    @@functions[name] = block
  end

  def self.processData hash
    case hash['type']
    when 'rfc'
      self.callFunc(@@functions[hash['fqn']], hash['args'])
    when 'closurecall'
      self.callFunc(@@closures[hash['fqn']], hash['args']);
    when 'new'
      self.send_data({"type" => "functionList", 
                       "functions" => @@functions.keys}.to_json)
      puts "Accepted new connection"
    else
      puts 'unidentified json, json'
    end
  end

  def self.serializeArgs args
    args.collect {|a|
      ((a.is_a?(Hash) && a.has_key?('fqn')) ?
       (@@functions.has_key?(a['fqn']) ?
        @@functions[a['fqn']] :
        (@@closures.has_key?(a['fqn']) ?
         @@closures[a['fqn']] :
         self.makeClosure(a['fqn']))):
       (a.is_a?(Proc) ?
        (((@@closures[a.to_s] = a) && false) ||
         {"fqn" => a.to_s}) :
        a))
    }
  end

  def self.callFunc func, args
    func.call *(self.serializeArgs args)
  end

 def self.makeUsercaller user, fqn
    lambda{|*args| 
       self.send_data({ "type" => "usercall",
                        "id" => user,
                        "fqn" => fqn,
                        "args" => (self.serializeArgs args)}.to_json)
     }
 end

 def self.makeMulticaller group, fqn
    lambda{|*args| 
       self.send_data({ "type" => "multicall",
                        "groupName" => group,
                        "fqn" => fqn,
                        "args" => (self.serializeArgs args)}.to_json)
     }
 end

 def self.makeClosure a
    lambda{|*args| 
       self.send_data({ "type" => "closurecall",
                        "fqn" => a,
                        "args" => (self.serializeArgs args)}.to_json)
     }
  end

  def self.send_data str
    RubyNow.conn[0].send_data str
  end

end
