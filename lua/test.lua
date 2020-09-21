require("module")
print("hello world")

function PrintLine()
    print("#")
end

print(module.value1)
print(module.value2)
module.func1()

--[[
while(true)
do
    print("loop")
    PrintLine()
end
--]]

