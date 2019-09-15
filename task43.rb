class KDTree
    class Node
        attr_reader :value
        attr_accessor :left, :right

        def initialize(value=nil, left=nil, right=nil)
            @value = value
            @left = left
            @right = right
        end

        def isLeaf
            if self.left != nil || self.right != nil
                return false
            else
                return true
            end
        end

        def reportSubtree(reportedPoints=[]) # returns list of points
            v = self
            if v.nil?
                return
            elsif v.isLeaf
                reportedPoints.push(v.value)
            elsif v.left != nil && v.right != nil
                v.left.reportSubtree(reportedPoints)
                reportedPoints.push(v.value)
                v.right.reportSubtree(reportedPoints)
            elsif v.left.nil?
                reportedPoints.push(v.value)
                v.right.reportSubtree(reportedPoints)
            else
                v.left.reportSubtree(reportedPoints)
                reportedPoints.push(v.value)
            end
            return reportedPoints
        end
    end

    attr_accessor :root_node
    attr_accessor :dims
    
    
    def initialize(points, dimensionality)
        @dims = dimensionality
        @root_node = build(points)
    end

    def halfLength(array)
        return (array.size/2.0).round()
    end

    def build(points, depth=0)
        if points.size == 0
            return nil
        end
        if points.size == 1
            return Node.new(points[0])
        end
        axis = depth % @dims
        points = points.sort{|a,b| a[axis] <=> b[axis]}         # this bit could be optimised to just create d presorted lists, but implementing that while maitaining the recursion would be rather complicated
        medianPoint = points[halfLength(points)-1]
        pointsL, pointsR = points.each_slice(halfLength(points)).to_a
        pointsL.pop
        vl = build(pointsL, depth+1)
        vr = build(pointsR, depth+1)
        return Node.new(medianPoint, vl, vr)
    end
end

inp = $stdin.read.chomp.split(/\n+/)
# inp = ["8 2 1", "3 2", "10 4", "23 6", "30 10", "62 8", "47 14", "105 9", "89 7", "[7 2] [47 12]"]    # for testing purposes

firstLine = inp.shift().split()
dimensionality = firstLine[1].to_i
numOfQueries = firstLine[2].to_i
queries = inp.pop(numOfQueries)
inp = inp.map{|char| char.split().map{|charjr| charjr.to_i}}
queries = queries.map{|char| char.split(/\D/).select{ |v| v =~ /[0-9]/}}
queries.flatten!
queries = queries.each_slice(dimensionality).map{|charjr| charjr.map{|char3rd| char3rd.to_i}}
=begin
    I noticed that the previous iteration of my queries transformation created an obsolete third array layer and I fixed this here.
    However fixing it in task31 would break other parts of the program so it is unchanged there.
=end
tree = KDTree.new(inp, dimensionality)
# p(tree.root_node.reportSubtree)