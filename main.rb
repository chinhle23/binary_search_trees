# frozen_string_literal: true

require_relative 'lib/tree'

tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print
p tree.balanced?
p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder
tree.insert(101)
tree.insert(102)
tree.pretty_print
p tree.balanced?
tree.rebalance
tree.pretty_print
p tree.balanced?
p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder
