import torch
import time

print(torch.cuda.is_available())
print(torch.version.cuda)
for x in range(1, 1000):
    x = torch.rand(5, 3)
time.sleep(5)
print(x)
