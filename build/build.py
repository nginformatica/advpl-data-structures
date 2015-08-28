from os import listdir, remove
from os.path import isfile, join

src = "./src"
dist = "./dist"

def header():
  """
    Returns the header to append to the source
  """
  return "#xtranslate \<<obj>\> => <obj>():New"

def license():
  """
    Returns the license based on the license file
  """
  mit = map(lambda line: "// " + line, open("LICENSE").read().split("\n")[:-2])
  return "\n".join(mit)

def list_files():
  """
    Returns the list of the files in the source directory
  """
  return [f for f in listdir(src) if isfile(join(src, f))]

def build():
  """
    Merges all the files into one single
  """
  data = [license(), header()]
  for struct in list_files():
    with open(src + "/" + struct) as f:
      data.append(f.read())
  gen_dist("\n".join(data))

def gen_dist(data):
  """
    Writes merged files in a single file
  """
  filename = dist + "/DataStructures.prw"
  if isfile(filename):
    remove(filename)
  target = open(dist + "/DataStructures.prw", "w")
  target.write(data)

build()
