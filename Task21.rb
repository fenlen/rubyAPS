class Tree
    class Node
        attr_reader :value
        attr_accessor :left, :right

        def initialize(value=nil)
            @value = value
            left = right = nil
        end

        def isLeaf
            if self.left != nil || self.right != nil
                return false
            else
                return true
            end
        end

        def reportSubtree(reportedLeaves=[])
            v = self
            if v.isLeaf
                reportedLeaves.push(v.value)
            else
                v.left.reportSubtree(reportedLeaves)
                v.right.reportSubtree(reportedLeaves)
            end
            return reportedLeaves
        end
    end

    attr_accessor :root_node

    def initialize(array)
        @root_node = Node.new(array[halfLength(array)])
        if array.size > 1
            build(array)
        end
    end

    def halfLength(array)   # rounds up
        return (array.size/2.0-1).round()
    end

    def build(array, current_node = @root_node)
        leftArray, rightArray = array.each_slice(halfLength(array)+1).to_a
        if leftArray.size >= 2
            current_node.left = Node.new(leftArray[halfLength(leftArray)])
            build(leftArray, current_node.left)
        elsif leftArray.size < 2
            current_node.left = Node.new(leftArray[0])
            if leftArray.size == 2
                current_node.right = Node.new(leftArray[1])
            end
        end
        if current_node.right == nil
            if rightArray.size >= 2
                current_node.right = Node.new(rightArray[halfLength(rightArray)])
                build(rightArray, current_node.right)
            elsif rightArray.size == 1
                current_node.right = Node.new(rightArray[0])
            else
                current_node.right = Node.new(rightArray[0])
                current_node = current_node.right
                current_node.left = Node.new(rightArray[0])
                current_node.right = Node.new(rightArray[1])
            end
        end
    end
end

def mergesort(array)
    if array.size <= 1
        return array
    end

    mid = array.size / 2
    part_a = mergesort(array.slice(0, mid))
    part_b = mergesort(array.slice(mid, array.size - mid))

    array = []
    offset_a = 0
    offset_b = 0
    while offset_a < part_a.size && offset_b < part_b.size
        a = part_a[offset_a]
        b = part_b[offset_b]

        if a <= b
            array.push(a)
            offset_a += 1
        else
            array.push(b)
            offset_b += 1
        end
    end

    while offset_a < part_a.size
        array.push(part_a[offset_a])
        offset_a += 1
    end

    while offset_b < part_b.size
        array.push(part_b[offset_b])
        offset_b += 1
    end

    return array
end

def findSplitNode(tree, xs, xf)
    v = tree.root_node
    if tree.root_node.left.nil? && tree.root_node.right.nil?
        return tree.root_node
    end
    xv = v.value
    while v.isLeaf == false && (xf <= xv && xs > xv)
        if xf <= xv
            v = v.left
        else
            v = v.right
        end
        xv = v.value
    end
    return v  
end

def oneDRangeQuery(tree, xs, xf)
    vsplit = findSplitNode(tree, xs, xf)
    reportedNodes = []
    if vsplit.isLeaf
        if vsplit.value.between?(xs,xf)
            reportedNodes.push(vsplit.value)
        end
        return reportedNodes
    end
    v = vsplit.left
    while v.isLeaf == false
        if xs <= v.value
            reportedNodes.push(v.right.reportSubtree)
            v = v.left
        elsif v.right.isLeaf && v.right.value >= xs
            reportedNodes.push(v.right.value)
            v = v.right
        else
            v = v.right
        end
    end
    v = vsplit.right
    while v.isLeaf == false
        if xf >= v.value
            reportedNodes.push(v.left.reportSubtree)
            v = v.right
        elsif v.left.isLeaf && v.left.value <= xf
            reportedNodes.push(v.left.value)
            v = v.left
        else
            v = v.left
        end
    end
    return reportedNodes
end

# inp = ["8 2", "3", "10", "23", "30", "62", "47", "105", "89", "55", "7 47", "10 89"]
# inp = ["8 2", "3", "10", "23", "30", "47", "62", "89", "105", "7 47", "10 89"]

# inp = 1000000.times.map {rand(1000000)}
# inp.unshift("1000000 10")
# inp.push("70000 470000")
# inp.push("1000 89000")
# inp.push("105 894")
# inp.push("101 8955")
# inp.push("1000 8900")
# inp.push("1456 81159")
# inp.push("10000 890000")
# inp.push("156 85213")
# inp.push("10000 89000")
# inp.push("15 1089")

inp = $stdin.read.chomp.split(/\n+/)
firstLine = inp.shift().split()
numOfQueries = firstLine[1].to_i
queries = inp.pop(numOfQueries)
inp = inp.map{|chr| chr.to_i}
inp = mergesort(inp)


tree = Tree.new(inp)
for i in 0..numOfQueries-1
    query = queries[i].split().map{|chr| chr.to_i}
    xs = query[0]
    xf = query[1]
    p oneDRangeQuery(tree, xs, xf)
end
