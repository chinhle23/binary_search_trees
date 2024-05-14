# frozen_string_literal: true

require_relative 'lib/tree'

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

binary_search_tree = Tree.new(array)
binary_search_tree.insert(1000)
binary_search_tree.insert(1500)
binary_search_tree.insert(15)
binary_search_tree.insert(10)
binary_search_tree.pretty_print
p binary_search_tree.balanced?
binary_search_tree.rebalance
binary_search_tree.pretty_print
p binary_search_tree.balanced?
