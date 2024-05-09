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
    @root = build_tree(array.sort.uniq)
  end

  def build_tree(array)
    mid = (array.length / 2)
    root = Node.new(array[mid]) unless array[mid].nil?

    if mid.positive?
      root.left = build_tree(array.values_at(0..(mid - 1)))
      root.right = build_tree(array.values_at((mid + 1)..-1))
    end

    root
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true) if node.left
  end

  def insert(value, root = @root)
    node = Node.new(value)

    if root.nil?
      root = node
    else
      return root if root.data == value

      if root.data < value
        root.right = insert(value, root.right)
      else
        root.left = insert(value, root.left)
      end
    end

    root
  end

  def delete(value, root = @root)
    return root if root.nil?

    if value < root.data
      root.left = delete(value, root.left)
    elsif value > root.data
      root.right = delete(value, root.right)
    else
      if root.left.nil?
        return root.right
      elsif root.right.nil?
        return root.left
      end

      root.data = min_value(root.right)
      root.right = delete(root.data, root.right)
    end

    root
  end

  private

  def min_value(root)
    min_val = root.data

    until root.left.nil?
      min_val = root.left.data
      root = root.left
    end

    min_val
  end
end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

binary_search_tree = Tree.new(array)
binary_search_tree.insert(1000)
binary_search_tree.pretty_print
binary_search_tree.delete(1)
binary_search_tree.pretty_print
binary_search_tree.insert(2)
binary_search_tree.pretty_print
p binary_search_tree
