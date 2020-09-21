maze = zeros(Int8, 8, 6)
#maze = [i+j*width  for j = 0:height for i = 0:width]

function generate_maze(width,height,arg...)
    maze = zeros(Int8,width,height)
    maze = [(i+j*width)%10 for i = 0:width-1,j = 0:height-1]
    return (m=maze,w=width,h=height,a=arg)
end

function print_maze(maze)
    for r = 1:size(maze,2) 
        txt = ""
        for c in maze[:,r]
            txt *= "$c"
        end
        println(txt)
    end
end

function save_maze(maze,file)
    file = open(file,"w")
    for r = 1:size(maze,2)
        txt = ""
        for c in maze[:,r]
            txt *= "$c"
        end
        txt *= "\n"
        write(file,txt)
    end
    close(file)
end

res = generate_maze(8,6,"dungeon maze")
println(res)
print_maze(res.m)
save_maze(res.m,"maze.txt")

using Sockets
ip = "www.baidu.com"
connect(ip,80)
getaddrinfo(ip)
#print(maze[2:3,5:7])
cmd = `echo hello`
run(cmd)