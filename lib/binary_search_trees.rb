# frozen_string_literal: true

# The node objects that make up a BST
class Node
  attr_accessor :data, :left, :right

  def initialize(value)
    @data = value
    @left = nil
    @right = nil
  end
end

# This houses the methods of a binary search tree (BST)
class Tree
  attr_accessor :root

  def initialize(array)
    @sorted_arr = array.sort.uniq
    @root = build_tree(@sorted_arr)
  end

  def build_tree(array)
    mid = (array.length / 2)
    root = Node.new(array[mid])

    if mid > 0
      root.left = build_tree(array.values_at(0..(mid - 1)))
      root.right = build_tree(array.values_at((mid + 1)..-1))
    end

    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

binary_search_tree = Tree.new(array)

binary_search_tree.pretty_print