# The MIT License (MIT)
#
# Copyright (c) 2015 Marcelo Camargo <marcelocamargo@linuxmail.org>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from os import listdir, remove
from os.path import isfile, join

src = "./src"
dist = "./dist"

def header():
  """
    Returns the header to append to the source
  """
  return "\n".join([
    "#xtranslate \<<obj>\> => <obj>():New",
    "#include \"protheus.ch\""
  ])

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
