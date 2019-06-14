import os
from collections import defaultdict
from pathlib import Path
from datetime import datetime
import struct
import matplotlib.pyplot as plt

DT_FORMAT = "%Y-%m-%dT%H:%M:%S"


def timestamp_from_filename(path_obj):
    return datetime.strptime(path_obj.stem, DT_FORMAT).timestamp()

class VibrationPacket:
    def __init__(self, data:bytes):
        self.x= self.unpack_acc(data[:3])
        self.y= self.unpack_acc(data[3:6])
        self.z= self.unpack_acc(data[6:9])
        self.us = self.unpack_us(data[9:])

    def unpack_acc(self, binary):
        h, m, l = list(binary)
        value = (h << 12) | (m << 4) | (l >> 4)
        if value > 524287:
            value = -1 * (1048576 - value)
        return value

    def unpack_us(self, binary):
        return struct.unpack(">I", binary)[0]

proj_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
data_dir = Path(os.path.join(proj_dir, "cmake-build-debug"))
data_files = list(data_dir.glob("*.vib"))
data_files.sort(key=timestamp_from_filename)

print(data_files)

with open(str(data_files[1].absolute()), 'rb') as infile:
    data = infile.read()

splitted = data.split(b'\x00\x01\x02')
print(len(splitted))
occurences = defaultdict(int)
for d in splitted:
    occurences[len(d)]+=1
binaries = [d for d in splitted if len(d) == 13]
# datum = packets[0]
packets = []
for binary in binaries[:2000]:
    packets.append(VibrationPacket(binary))
for idx in range(len(packets)):
    if idx>0:
        diff = packets[idx].us - packets[idx-1].us
        if abs(diff) > 1000:
            print(idx, diff)

acc_x = [p.x for p in packets]
us = [p.us for p in packets]
plt.plot(us, acc_x, linestyle='solid', color='r')
plt.xlabel('Time(us)')
plt.ylabel('x acceleration')
plt.title('ADXL357')
plt.savefig("out.png")
# plt.show()