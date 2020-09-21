from PIL import Image
import numpy as np
import numpy.ma as ma

srcPath = "./X/images/ships/eng_1.png"
mskPath = "./X/Battle/image/crack-3.png"

src = Image.open(srcPath) 
msk = Image.open(mskPath)
src = src.resize(src.size)
msk = msk.resize(src.size)

src_np = np.asarray(src)
msk_np = np.asarray(msk)
msk_alpha_msk = (1-msk_np[:,:,3]/255)

# # src_alpha_msk = src_np[:,:,3]

r = src_np[:,:,0]*msk_alpha_msk
g = src_np[:,:,1]*msk_alpha_msk
b = src_np[:,:,2]*msk_alpha_msk
msk_np = np.dstack((r.astype('uint8'),g.astype('uint8'),b.astype('uint8'),
src_np[:,:,3]))
#np.zeros(shape=(src.height,src.width),dtype='uint8')))
#np.ones(shape=(src.height,src.width),dtype='uint8')))*255

src_np = src_np - msk_np

res = Image.fromarray(msk_np)

res.save("res.png")