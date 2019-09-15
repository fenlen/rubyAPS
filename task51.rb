require_relative "task43"

def intersect(minMax1, minMax2)
    d = minMax1[0].size
    for i in 0..d-1
        if !((minMax2[i][0] <= minMax1[i][0] && minMax1[i][0] <= minMax2[i][1]) || (minMax2[i][0] <= minMax1[i][1] && minMax1[i][1] <= minMax2[i][1]) ||
                (minMax1[i][0] <= minMax2[i][0] && minMax2[i][0] <= minMax1[i][1]) || (minMax1[i][0] <= minMax2[i][1] && minMax2[i][1] <= minMax1[i][1]))
            return false
        end
    end
    return true
end

def minMax(points)
    d = points[0].size
    minMaxArray = []
    if points[1] != nil && points[1].size == 1  #adaption for circles/spheres/etc.
        radius = points[1][0]
        for i in 0..d-1
            minMaxArray.push([points[0][i]-radius, points[0][i]+radius])
        end
        return minMaxArray
    end
    for i in 0..d-1
        tempArray = []
        points.each do |point|
            tempArray.push(point[i])
        end
        minMaxArray.push(tempArray.minmax)
    end
    return minMaxArray
end

def fullyContained(points, r)
# This function satisfies task 5.2, however I have also used it throughout this program universally, to check whether a point/list of sorted points is contained within a range.
    d = r[0].size
    firstPoint = points[0]
    lastPoint = points[-1]
    count = 0
    for i in 0..d-1
        if firstPoint[i] >= r[0][i] && lastPoint[i] <= r[1][i]
            count += 1
        end
    end
    if count == d
        return true
    else
        return false
    end
end

def searchKDTree(v, r, points=[], minMaxR=minMax(r))
# I had intended to implement this using purely recursion instead of returning an array. However that produced some very unexpected behaviour which I was ultimately unable to fix. 
    if v.isLeaf
        if fullyContained(v.reportSubtree, r)
            points.push(v.value)
        end
    end
    if fullyContained([v.value], r)
        points.push(v.value)
    end
    if v.left != nil
        leftSubtree = v.left.reportSubtree
        if fullyContained(leftSubtree, r)
            leftSubtree.each do |point|
                points.push(point)
            end
        elsif intersect(minMax(leftSubtree), minMaxR)
            searchKDTree(v.left, r, points, minMaxR)
        end
    end
    if v.right != nil
        rightSubtree = v.right.reportSubtree
        if fullyContained(rightSubtree, r)
            rightSubtree.each do |point|
                points.push(point)
            end
        elsif intersect(minMax(rightSubtree), minMaxR)
            searchKDTree(v.right, r, points, minMaxR)
        end
    end
    return points
end

inp = $stdin.read.chomp.split(/\n+/)
# inp = ["3 2 1", "3 2", "10 4", "23 6", "[7 2] [44 12]"]
# inp = ["8 2 1", "3 2", "10 4", "23 6", "30 10", "23 10", "62 8", "45 8", "45 10", "47 14", "105 9", "89 7", "[7 2] [44 12]"]    # for testing purposes
# inp = ["3 5 1", "3 2 5 1 4", "8 6 7 2 3", "7 12 3 10 14", "[1 2 3 2 3] [10 10 10 10 10"]
# inp = ["9 5 1", "3 2 5 1 4", "8 6 7 2 3", "7 12 3 10 14","3 2 5 1 4", "8 62 74 25 3", "72 12 3 100 14","3 22 55 1 4", "8 16 17 12 3", "27 12 31 10 14", "[1 2 3 2 3] [10 50 30 40 20"]
# inp = ["9 10 1", "272 191 281 242 253 183 77 62 216 162", "274 115 78 198 48 84 52 4 48 32", "242 197 75 212 170 78 291 95 100 43","272 191 281 242 253 183 77 62 216 162", "274 115 78 198 48 84 52 4 48 32", "242 197 75 212 170 78 291 95 100 43","272 191 281 242 253 183 77 62 216 162", "274 115 78 198 48 84 52 4 48 32", "242 197 75 212 170 78 291 95 100 43", "[122 12 1 1 111 1 111 1 1 251] [3820 2950 2400 1390 2940 1740 4600 1270 2500 2046]"]

firstLine = inp.shift().split()
dimensionality = firstLine[1].to_i
numOfQueries = firstLine[2].to_i
queries = inp.pop(numOfQueries)
inp = inp.map{|char| char.split().map{|charjr| charjr.to_i}}
tree = KDTree.new(inp, dimensionality)

queries.each do |querry|
    querry = [querry]
    querry = querry.map{|char| char.split(/\D/).select{ |v| v =~ /[0-9]/}}
    querry.flatten!
    querry = querry.each_slice(dimensionality).map{|charjr| charjr.map{|char3rd| char3rd.to_i}}
    p searchKDTree(tree.root_node, querry)
end

# p(queries)
# p(searchKDTree(tree.root_node,queries))
# p(tree.root_node.reportSubtree)
# p(fullyContained([[89, 7], [30, 10]], [[7, 2], [47, 12]]))
# p(searchKDTree(tree.root_node, queries))
# p(tree.root_node)