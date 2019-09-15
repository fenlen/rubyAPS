=begin
The ordering of the output here is different than what is described in task 2.1 since this implementation sorts the array before querying it to meet
the required time complexity.
=end

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

def buildList(n, initArray = [])        # If you want to just add an element to an already existing array, call this function with the element and the array as arguments
    len = n.size
    for i in 0..len-1
        initArray.push(n[i])
    end
    return mergesort(initArray)
end

def query(array, xs, xf)
    outputArray = []
    if array.size == 1
        currentElementIndex = 0
    else
        currentElementIndex = array.bsearch_index {|x| x >= xs }  # ruby's built-in binary search that returns the index of the found element
    end
    while true
        if currentElementIndex.nil?
            break
        end
        currentElement = array[currentElementIndex]
        currentElementIndex += 1
        if currentElement != nil && currentElement <= xf
            outputArray.push(currentElement)
        else
            break
        end
    end
    return outputArray
end

# inp = 1.times.map {rand(100)}
# inp.unshift("1 2")
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
inp = $stdin.read.chomp.split(/\n+/)
firstLine = inp.shift().split()
numOfQueries = firstLine[1].to_i
queries = inp.pop(numOfQueries)
inp = inp.map{|chr| chr.to_i}
sortedArray = buildList(inp)

for i in 0..numOfQueries-1
    limiters = queries[i].split().map{|chr| chr.to_i}
    p query(sortedArray, limiters[0], limiters[1]).join(' ')
end
