using Metalhead
using Metalhead: classify

using Images

img = load("tile.png")
vgg = VGG19()

classify(vgg,img)