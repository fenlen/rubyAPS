=begin
Since the specified input/output in task 2.1 does not match
the original problem description a slight alteration to the aproach
was necessary which changed the algorithm's complexity
Now it is O(nq), q being the number of queries.
=end

# inp = 1000000.times.map {rand(1000000)}
# inp.unshift("1000000 10")
# inp.push("7 47")
# inp.push("10 89")
# inp.push("105 894")
# inp.push("101 8955")
# inp.push("1000 8900")
# inp.push("1456 81159")
# inp.push("10000 890000")
# inp.push("156 85213")
# inp.push("10000 89000")
# inp.push("15 1089")
# inp = ["1 2", "3", "7 47","10 89"]
# inp = ["2 2", "3", "10", "7 47", "10 89"]
# inp = ["6 1", "3", "10", "23", "30", "62", "47", "10 89"]
# inp = ["6 2", "3", "10", "23", "30", "62", "47", "7 47","10 89"]
# inp = ["7 2", "2", "9", "32" , "52" , "11" ,"33" , "10", "7 47", "10 89"]
# inp = ["9 2", "3", "10", "23", "30", "62", "47", "105", "89", "55", "7 47", "10 89"]

inp = $stdin.read.chomp.split(/\n+/)
firstLine = inp[0].split
r = firstLine[0].to_i
q = firstLine[1].to_i

for i in 0..(q-1)
    rangeLine = inp[r+1+i].split
    min = rangeLine[0].to_i
    max = rangeLine[1].to_i
    dynarray = []   # It's called like this for consistency, in reality it's more akin to a stack.
    array = []
    for k in 1..r
        temp = inp[k].to_i
        array.push(temp)
        if temp>=min && temp<=max
            dynarray.push(temp)
        end
    end
    puts(dynarray.join(' '))
end
