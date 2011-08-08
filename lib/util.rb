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
    obj = hash['args'][0];
    case hash['name']
    when 'closurecall'
      self.callFunc(@@functions[obj['fqn']], obj['args'])
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
         self.remoteCall(a['fqn']))):
       (a.is_a?(Proc) ?
        (((@@closures[a.to_s] = a) && true) ||
         {"fqn" => a.to_s}) :
        a))
    }
  end

  def self.callFunc func, args
    func.call *(self.serializeArgs args)
  end

  def self.remoteCall a
    (lambda{|*args| 
       self.send_data({ "name" => "closurecall",
                        "args" => [{ "fqn" => a,
                                     "args" => (self.serializeArgs args)}] }.to_json)
     })
  end

  def self.send_data str
    RubyNow.conn[0].send_data str
  end
end
