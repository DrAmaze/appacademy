class PolyTreeNode

  attr_reader :value, :children, :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(parent)
    if @parent.nil?
      @parent = parent
      self.parent.children << self unless self.parent.children.include?(self)
      @parent
    else
      @parent.children.delete(self)
      @parent = parent
      self.parent.children << self unless @parent.nil? || self.parent.children.include?(self)
      # raise "bad parent=!" unless @parent == parent
      # raise "bad parent=!" unless @parent.children.include?(self)
    end

    def add_child(child_node)
      @children << child_node unless @children.include?(child_node)
      child_node.parent = self
    end

    def remove_child(child_node)
      if !@children.include?(child_node)
        raise "#{child_node} is not a child"
      else
        @children.delete(child_node)
        child_node.parent = nil
      end
    end

    def dfs(target_value)
      return self if self.value == target_value
      self.children.each do |child|
        result = child.dfs(target_value)
        return result if result
      end
      nil
    end

    def bfs(target_value)
      queue = [self]
      until queue.empty?
        current_node = queue.shift
        return current_node if current_node.value == target_value
        queue.concat(current_node.children)
      end
      nil
    end

  end


end
