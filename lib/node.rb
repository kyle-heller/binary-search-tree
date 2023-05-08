class Node
  attr_accessor :left, :right, :data
  def initialize(value)
    @data = value
    @left = nil
    @right = nil
  end
end