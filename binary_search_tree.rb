require_relative 'lib/tree.rb'
require_relative 'lib/node.rb'

array = Array.new(15) { rand(1..100 )}
tree = Tree.new(array)
tree.pretty_print
p tree.balanced?
p tree.levelorder
p tree.preorder
p tree.postorder
p tree.inorder
tree.insert(1000)
tree.insert(1500)
tree.insert(2000)
tree.pretty_print
p tree.balanced?
tree.rebalance
tree.pretty_print
p tree.balanced?
p tree.levelorder
p tree.preorder
p tree.postorder
p tree.inorder