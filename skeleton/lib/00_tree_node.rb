require 'byebug'

class PolyTreeNode
  attr_writer :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def parent=(parent_node)
    @parent.children.delete(self) if !@parent.nil?

    @parent = parent_node

    if !@parent.nil? && !@parent.children.include?(self)
      @parent.children << self
    end
  end

  def children
    @children
  end

  def add_child(child_node)
    child_node.parent=(self)
  end

  def remove_child(child_node)
    raise "not a child" if !self.children.include?(child_node)
    self.children.delete(child_node)
    child_node.parent = nil
  end

  def value
    @value
  end

  def inspect
    "Node: #{@value} parent: #{@parent} children: #{@children}"
  end

  # def dfs(target_value)
  #   return self if self.value == target_value
  #   self.children.each do |child|
  #     examine = child.dfs(target_value)
  #     return examine if examine
  #   end
  #   nil
  # end

  def dfs(target_value)
    return self if @value == target_value
    self.children.reduce(nil) do |value, child|
      value ||= child.dfs(target_value)
      return value if value
    end
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      return queue[-1] if queue[-1].value == target_value
      queue[-1].children.each do |child|
        queue.unshift(child)
      end
      queue.pop
    end
  end

end
