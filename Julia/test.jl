a = 100
println(a)
function test(x,y)
    x + y
end
println(test(2,4))
println(Char(0x2200))
println(1024//768)
str = "hello world\n"
print(str)
print(str[begin])
print(str[5])
print(str[end])
print(str[end-3])
print(str[begin+4])
print(str[3:5])
println("############")
print(str[7:2])

for i = 4:8
    println(i)
end
println("############")
for s in str
    println(s)
end
println("############")
for i = 5:10
    println(i)
end
println("length of ",length(str))

val1 = "value1"
val2 = "value2"

print("$val1 $val2\n")

print("$(4*4)\n")

println(repeat(".:Z:.",10))
println(collect(eachindex(str)))

println([1,2, 3, 4, 5, 6, 7, 8])
println([1 2 3 4 5 6 7 8])
println([1 2 3 4; 5 6 7 8])

width = 8
for i in 0:width
    for j in 0:width
        print(i)
    end
end

array = zeros(Int8,8,8)
println(array)

function producer(ch::Channel)
    for y = :8, x = :8
        put!(ch,"$x$y")
        println("put:",x,y)
    end
end

println("channel start")
chn1 = Channel(producer)

println("channel start1")
for i = :10
    println("take:",take!(chn1))
end
println("channel start2")

for t in chn1
    println(t)
end

function plot(x, y; style="solid", width=1, color="black")
    ###
    print(x,y,style,width,color)

end

plot(1,2,color = "white")