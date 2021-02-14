import random

loc = ["A","B","C","D"]
chara = ["A","B","C","D"]
event = ["a","b","c","d"]

story = {
    "time":random.randrange(-65000,9999),
    "location":loc[random.randint(0,0xffff)%len(loc)],
    "chara":chara[random.randint(0,0xffff)%len(chara)],
    "event":event[random.randint(0,0xffff)%len(event)]
}

print(story)