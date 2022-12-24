class Node
  include Comparable
  attr_accessor :value :left :right

  def initialize(value)
    @value = value
    @left
    @right
  end

end

class Tree
  attr_accessor :root

  def initialize(array)
    @root
  end

  def build_tree(array, min = 0, max = (array.length - 1))
    mid = (min + max) / 2
    left_array = array[min...mid]
    right_array = array[(mid + 1)..max]
    self.root = Node.new(array[mid])
    if min > max
      return false
    elsif
      self.root.left = self.build_tree(left_array, min, array[mid - 1])
      self.root.right = self.build_tree(right_array, array[mid + 1], max)
      
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

## Node has value left and right
## Tree has a root value
