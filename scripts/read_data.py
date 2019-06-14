import os

proj_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
data_path = os.path.join(proj_dir, "cmake-build-debug", "out.txt")
print(data_path)

with open(data_path, 'rb') as infile:
    data = infile.read()

print(data)