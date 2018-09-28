# класс 
  class Node
    include Comparable
    attr_accessor :left,:right,:value

    def initialize(value = nill, left = nil, right = nil)
        @value = value
        @left = left
        @right = right
    end

    def <=>(otherNode)
      @value <=> otherNode.value
    end

    def to_s
      "[value: #{@value} left=> #{@left} right=> #{@right}]"
    end
  end    

  class BinarySearchTree
    attr_reader :root

    def initialize(root = nil)
        @root = root
    end

    def search(value)
        search_for_node(@root, Node.new(value))
    end

    def insert(value)
        @root = insert_value(@root, value)
    end

    def delete(value)
      @root = delete_node(@root, Node.new(value))
    end

    def in_order_list
        vals = []
         inorder(vals, @root)
        vals
    end

    private

      def search_for_node(tnode, node)
        if tnode.nil?
          return nil
        end

        if tnode == node
          tnode = node
        elsif node < tnode
          tnode = search_for_node(tnode.left, node)
        else
          tnode = search_for_node(tnode.right, node)
        end
        tnode
      end

      def insert_value(tnode, value)
        if tnode.nil?
          tnode = Node.new(value)
        elsif value < tnode.value
          tnode.left = insert_value(tnode.left, value)
        elsif value > tnode.value
          tnode.right = insert_value(tnode.right, value)
        elsif value == tnode.value
          tnode.value = value
        end
        tnode
      end

      def delete_node(tnode, node)
        if tnode == node
          tnode = remove(tnode)
        elsif node < tnode
          tnode.left = delete_node(tnode.left, node)
        else
          tnode.right = delete_node(tnode.right, node)
        end
        tnode
      end

      def remove(node)
        if node.left.nil? && node.right.nil?
          node = nil
        elsif !node.left.nil? && node.right.nil?
          node = node.left
        elsif node.left.nil? && !node.right.nil?
          node = node.right
        else
          node = replace_parent(node)
        end
          node
      end
      
      def replace_parent(node)
        node.value = successor_value(node.right)
        node.right = update(node.right)
        node
      end

      def successor_value(node)
        unless node.left.nil?
          successor_value(node.left)
        end
          node.value
      end

      def update(node)
        unless node.left.nil?
          node.left = update(node)
        end
          node.right
      end

      def inorder(list, node)
        unless node.nil?
          inorder(list, node.left)
          list.push(node.value)
          inorder(list, node.right)
        end
      end
    end

tr = BinarySearchTree.new
tr.insert(9)
tr.insert(8)
tr.insert(7)
tr.insert(4)
tr.insert(3)
p tr.in_order_list
tr.delete(8)
p tr.in_order_list
