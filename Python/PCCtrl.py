import threading
import datetime
from tkinter import *
from tkinter import messagebox

def on_timer():
    print("hello")

def on_start():
    messagebox.showinfo("hello","welcome")

print(datetime.datetime.now())
timer = threading.Timer(5,on_timer)
timer.start()


gui = Tk()
ls = Listbox(gui)
ls2 = Listbox(gui)

for i in ["A","B","C"]:
    ls.insert(0,i)
ls.pack()

for j in range(5):
    ls2.insert(0,j)
ls2.pack()

btn = Button(gui,text="Click",command=on_start)
btn.pack()



gui.mainloop()