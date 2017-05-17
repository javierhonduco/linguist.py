echo "==> Benchmarking on demand process spawning..."
time python -c "
from client import popen_helper, write_to_process, ruby_binary

for i in range(100):
  popen = popen_helper(ruby_binary())
  print(write_to_process(popen, b'../linguist\n'))
" > /dev/null

echo
echo

echo "==> Benchmarking long-running subprocess with IPC..."
time python -c "
from client import popen_helper, write_to_process, ruby_binary

popen = popen_helper(ruby_binary())
for i in range(100):
  print(write_to_process(popen, b'../linguist\n'))
" > /dev/null
