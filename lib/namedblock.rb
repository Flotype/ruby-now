class NamedBlock < Proc
  def name name
    @name = name
  end
  def to_s
    @name
  end
end
