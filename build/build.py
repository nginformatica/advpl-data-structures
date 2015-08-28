from os import listdir, remove
from os.path import isfile, join

src = "./src"
dist = "./dist"

def list_files():
  return [f for f in listdir(src) if isfile(join(src, f))]

def build():
  data = []
  for struct in list_files():
    with open(src + "/" + struct) as f:
      data.append(f.read())
  gen_dist("\n".join(data))

def gen_dist(data):
  filename = dist + "/DataStructures.prw"
  if isfile(filename):
    remove(filename)
  target = open(dist + "/DataStructures.prw", "w")
  target.write(data)

build()
