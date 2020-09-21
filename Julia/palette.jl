using Images,FileIO,JSON

function Load(imgPath)
    img = load(imgPath)
    data = Dict()
    for p in img
        c = convert(RGB,p)
        data[c] = c
    end
    return collect(values(data))    
end

function SaveJson(fileName,dat)
    f = open(fileName,"w")
    json = JSON.json(dat)
    write(f,json)
    close(f)
end

function CvtColor(img,palette)
    img_c = img
    for index = 1:length(img)
        c = img_c[index]
        src = convert(RGB,c)
        minDst = 256*3
        minClr = RGB()
        for p in palette
            dis = abs(src-p)
            if dis<minDst
                minDst = dis
                minClr = p
            end
        end
        img_c[index] = RGBA(minClr,alpha(c))
    end
    return img_c
end

println("start")

dat = Load("colored.png")
#SaveJson("t.json",dat)

img = load("Sample.png")
img = CvtColor(img,dat)
save(File(format"PNG","t.png"),img)

println("end")