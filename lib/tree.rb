# frozen_string_literal: true

require_relative 'node'

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

  def find(value, root = @root)
    return nil if root.nil?

    return root if value == root.data

    if value < root.data
      find(value, root.left)
    elsif value > root.data
      find(value, root.right)
    end
  end

  def level_order(queue = [], node = @root)
    return if node.nil?

    queue << node
    values = []

    until queue.empty?
      current_node = queue.shift

      if block_given?
        values.push(yield current_node)
      else
        values << current_node.data
      end

      queue.push(current_node.left) unless current_node.left.nil?
      queue.push(current_node.right) unless current_node.right.nil?
    end

    values
  end

  def level_order_rec(queue = [], values = [], node = @root, &block)
    return if node.nil?

    if block_given?
      values.push(yield node)
    else
      values << node.data
    end

    queue << node.left unless node.left.nil?
    queue << node.right unless node.right.nil?

    level_order_rec(queue, values, queue.shift, &block)

    values
  end

  def preorder(values = [], node = @root, &block)
    return if node.nil?

    if block_given?
      values.push(yield node)
    else
      values << node.data
    end

    preorder(values, node.left, &block) unless node.left.nil?
    preorder(values, node.right, &block) unless node.right.nil?

    values
  end

  def inorder(values = [], node = @root, &block)
    return if node.nil?

    inorder(values, node.left, &block) unless node.left.nil?

    if block_given?
      values.push(yield node)
    else
      values << node.data
    end

    inorder(values, node.right, &block) unless node.right.nil?

    values
  end

  def postorder(values = [], node = @root, &block)
    return if node.nil?

    postorder(values, node.left, &block) unless node.left.nil?
    postorder(values, node.right, &block) unless node.right.nil?

    if block_given?
      values.push(yield node)
    else
      values << node.data
    end

    values
  end

  def height(node)
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  def depth(node, root = @root)
    return nil if node.nil?

    return 0 if node == root || root.nil?

    if node.data < root.data
      depth(node, root.left) + 1
    elsif node.data > root.data
      depth(node, root.right) + 1
    end
  end

  def balanced?(queue = [], node = @root)
    return if node.nil?

    queue << node

    until queue.empty?
      current_node = queue.shift
      left_height = current_node.left.nil? ? 0 : height(current_node.left)
      right_height = current_node.right.nil? ? 0 : height(current_node.right)

      return false if (left_height - right_height).abs > 1

      queue.push(current_node.left) unless current_node.left.nil?
      queue.push(current_node.right) unless current_node.right.nil?
    end

    true
  end

  def rebalance
    @root = build_tree(inorder)
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
