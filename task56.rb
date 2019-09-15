require_relative "task51.rb"

def fullyContained(points, r)
    edges = r.size 
    count = 0
    points.each do |point|
        for e in 0..edges-1
            temp = (r[e][0]-r[e-1][0])*(point[1]-r[e-1][1]) - (point[0]-r[e-1][0])*(r[e][1]-r[e-1][1])
            if temp <= 0
                count += 1
            end
        end
    end
    if count == edges * points.size
        return true
    else
        return false
    end
end

# inp = ["3 2 1", "3 2", "10 4", "23 6", "[5 5] [5 20] [20 20] [20 5]"]
# inp = ["19 2 1", "3 2", "10 4", "23 6", "30 10", "23 10", "62 8", "45 8", "45 10", "47 14", "105 9", "89 8","10 20","14 69","15 20","32 35","1 95","21 43","78 28","20 2","32 47","8 25","21 14","78 21","100 3","32 25","1 35","21 14","77 20","100 2", "[5 5] [5 20] [20 20] [20 5]"]    # for testing purposes

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
