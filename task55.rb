require_relative "task51"

# inp = ["3 2 1", "3 2", "10 4", "23 6", "[7 2] 5"]
# inp = ["8 2 1", "3 2", "10 4", "23 6", "30 10", "23 10", "62 8", "45 8", "45 10", "47 14", "105 9", "89 7", "[7 2] 10"]    # for testing purposes
# inp = ["3 5 1", "3 2 5 1 4", "8 6 7 2 3", "7 12 3 10 14", "[1 2 3 2 3] 10"]
# inp = ["9 5 1", "3 2 5 1 4", "8 6 7 2 3", "7 12 3 10 14","3 2 5 1 4", "8 62 74 25 3", "72 12 3 100 14","3 22 55 1 4", "8 16 17 12 3", "27 12 31 10 14", "[1 2 3 2 3] 50"]
# inp = ["9 10 1", "272 191 281 242 253 183 77 62 216 162", "274 115 78 198 48 84 52 4 48 32", "242 197 75 212 170 78 291 95 100 43","272 191 281 242 253 183 77 62 216 162", "274 115 78 198 48 84 52 4 48 32", "242 197 75 212 170 78 291 95 100 43","272 191 281 242 253 183 77 62 216 162", "274 115 78 198 48 84 52 4 48 32", "242 197 75 212 170 78 291 95 100 43", "[122 12 1 1 111 1 111 1 1 251] 150"]

def fullyContained(points, r)
    d = r[0].size
    firstPoint = points[0]
    lastPoint = points[-1]
    count = 0
    for i in 0..d-1
        if firstPoint[i] >= (r[0][i] - r[1][0]) && lastPoint[i] <= (r[0][i] + r[1][0])
            count += 1
        end
    end
    if count == d
        return true
    else
        return false
    end
end

inp = $stdin.read.chomp.split(/\n+/)
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


