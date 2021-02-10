import platform
import numpy as np
print(platform.system())

if platform.system() == "Linux":
    import sys

if platform.system() == "Windows":
    from PIL import ImageGrab
    img = ImageGrab.grab(0,0,600,400)
    img.save("grab.jpg")