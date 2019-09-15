def querry(array,dims,range)
    points = []
    for i in 0..array.size-1
        checkLess = 0
        checkGreat = 0
        for j in 0..dims-1
            for k in 0..dims-1
                if array[i][k] >= range[j][k]
                    checkGreat += 1
                elsif array[i][k] <= range[j][k]
                    checkLess += 1
                end
            end
        end
        if checkLess == dims && checkGreat == dims 
            points.push(array[i])
        end
    end
    return points
end
inp = $stdin.read.chomp.split(/\n+/)
# inp = ["8 2 1", "3 2", "10 4", "10 6", "23 6", "30 10", "62 8", "47 14", "105 9", "89 7", "[7 2] [47 12]"]    # for testing purposes
firstLine = inp.shift().split()
dimensionality = firstLine[1].to_i
numOfQueries = firstLine[2].to_i
queries = inp.pop(numOfQueries)
inp = inp.map{|char| char.split().map{|charjr| charjr.to_i}}
queries = queries.map{|char| char.split(/\D/).select{ |v| v =~ /[0-9]/}.each_slice(dimensionality).map{|charjr| charjr.map{|char3rd| char3rd.to_i}}}
=begin
I know that above line may be difficult to read so I'll walk you through it. We start with querries - an array with the last Q lines of the input string, Q being the 3rd number in the 1st line.
Then on each element of querries we apply the split function, splitting on digits and then we have some leftover empty strings. The select funcion takes care of these empty strings.
At this point we have a list of Q lists, containing the numbers in the querries stored as strings. 
Then we slice those lists in D equally sized parts, D being the dimensionality. And now since we have a list containing Q lists, each of them containing D lists we have to do go 2 more
levels deeper into the map function in order to convert the stored strings into integers. 
=end

for i in 0..numOfQueries-1
    p(querry(inp, dimensionality, queries[i]))
end
