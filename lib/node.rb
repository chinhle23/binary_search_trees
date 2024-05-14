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
