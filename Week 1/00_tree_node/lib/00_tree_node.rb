class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(new_parent)
    @parent.children.delete(self) unless @parent.nil?
    @parent = nil if new_parent.nil?
    unless new_parent.nil?
      @parent = new_parent
      @parent.children << self unless @parent.children.include?(self)
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child)
    raise "Error" unless @children.include?(child)
    child.parent = nil
  end

  # def dfs(target_value, &prc)
  #   prc ||= Proc.new { |node| node.value == target_value }
  #   return self if prc.call(self)
  #   result = nil
  #
  #   @children.each do |child|
  #     result = child.dfs(target_value, &prc)
  #     return result if result
  #   end
  #   result
  # end

  def dfs(target_value)
    return self if target_value == @value
    result = nil

    @children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    result
  end

  def bfs(target_value, &prc)
    prc ||= Proc.new {|node| node.value == target_value}
    queue = []

    queue << self
    until queue.size == 0
      curr = queue.shift
      return curr if prc.call(curr)
      queue + children
    end
    nil
  end

  # def bfs(target_value)
  #   nodes = []
  #   nodes << self
  #   until nodes.empty?
  #     node = nodes.shift
  #     if target_value == node.value
  #       return node
  #     else
  #       nodes.concat(node.children)
  #     end
  #   end
  #   nil
  # end
end
