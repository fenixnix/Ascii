import threading
import datetime
from tkinter import *

def on_timer():
    print("hello")

print(datetime.datetime.now())
timer = threading.Timer(5,on_timer)
timer.start()

top = Tk()
top.mainloop()
