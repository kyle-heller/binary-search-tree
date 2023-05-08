class Tree
  attr_accessor :root
  def initialize(array)
    if array.empty?
      @root = Node.new(nil)
    else
      @root = build_tree(array)
    end
  end

  def build_tree(array)
    arr = array.dup.sort.uniq
    startpoint = 0
    endpoint = (arr.length) -1
    mid = startpoint + endpoint / 2
    unless arr.empty?
      node = Node.new(arr[mid])
      node.left = build_tree(arr[0...mid])
      node.right = build_tree(arr[(mid + 1)..-1])
      node
    end
  end

  def insert(value, current = @root)
    if current.data == nil
      current.data = value
      return
    end
    if current.data == value 
      return
    elsif value < current.data
      unless current.left == nil
        insert(value, current.left)
      end
      if current.left == nil
        current.left = build_tree([value])
      end
    elsif value > current.data
      unless current.right == nil
        insert(value, current.right)
      end
      if current.right == nil
        current.right = build_tree([value])
      end
    end
  end

  def remove(value, current = @root)
    if current.nil?
      # If current node is nil, the value is not in the tree
      return current
    elsif value < current.data
      # If value is less than current node's data, traverse left subtree
      current.left = remove(value, current.left)
    elsif value > current.data
      # If value is greater than current node's data, traverse right subtree
      current.right = remove(value, current.right)
    else
      # If value matches current node's data, it is the node to remove
      if current.left.nil?
        # Case 1: Node has no left child (i.e., it is a leaf node)
        # Replace node with its right child (which may be nil)
        temp = current.right
        current = nil
        return temp
      elsif current.right.nil?
        # Case 2: Node has no right child
        # Replace node with its left child
        temp = current.left
        current = nil
        return temp
      else
        # Case 3: Node has two children
        # Find the inorder successor (i.e., minimum value in right subtree)
        temp = find_min(current.right)
        # Replace node's data with inorder successor's data
        current.data = temp.data
        # Remove inorder successor from right subtree
        current.right = remove(temp.data, current.right)
      end
    end
    current
  end

  def find_min(node)
    current = node
    current = current.left while current.left
    current
  end

  def find(value, current = @root)
    if current.nil?
      return nil
    end
    if current.data == value
      return current
    elsif value < current.data
      find(value, current.left)
    elsif value > current.data
      find(value, current.right)
    end
  end

  def levelorder
    raise "Error: Tree is empty" unless @root
  
    result = []
    nodes_to_process = [@root]
  
    while !nodes_to_process.empty?
      current = nodes_to_process.shift
  
      if block_given?
        result << yield(current.data)
      else
        result << current.data
      end
  
      nodes_to_process << current.left if current.left
      nodes_to_process << current.right if current.right
    end
  
    result
  end

  def preorder(current = @root)
    result = []

    if current.nil?
      return result
    end

    if block_given?
      result << yield(current.data)
    else
      result << current.data
    end

    result += preorder(current.left)
    result += preorder(current.right)

    result
  end

  def inorder(current = @root)
    result = []
  
    if current.nil?
      return result
    end

    result += inorder(current.left)

    if block_given?
      result << yield(current.data)
    else
      result << current.data
    end

    result += inorder(current.right)
  
    result
  end

  def postorder(current = @root)
    result = []
  
    if current.nil?
      return result
    end

    result += postorder(current.left)

    result += postorder(current.right)

    if block_given?
      result << yield(current.data)
    else
      result << current.data
    end
  
    result
  end

  def height(node)
    if node == nil
      return -1
    else
      leftHeight = height(node.left)
      rightHeight = height(node.right)
      return [leftHeight, rightHeight].max  + 1
    end
  end
  
  def depth(node, current = @root)
    if current == nil
      return nil
    elsif node.data < current.data
      depth(node, current.left) + 1
    elsif node.data > current.data
      depth(node, current.right) + 1
    else 
      return 0
    end
  end

  def balanced?
    left_height = height(@root.left)
    right_height = height(@root.right)
    if left_height - right_height > 1 || left_height - right_height < -1
      return false
    end
    true
  end

  def rebalance
    arr = self.inorder
    @root = build_tree(arr)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end