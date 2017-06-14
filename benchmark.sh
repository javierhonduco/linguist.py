# improve this
trap 'exit -1' INT

ITERATIONS="${1:-50}"

echo "==> Iterations=$ITERATIONS"
echo

echo "==> Benchmarking on demand process spawning..."
time python -c "
from client import popen_helper, write_to_process, ruby_binary

for i in range($ITERATIONS):
  popen = popen_helper(ruby_binary())
  print(write_to_process(popen, '../linguist\n'))
" > /dev/null

echo
echo

echo "==> Benchmarking long-running subprocess with IPC..."
time python -c "
from client import popen_helper, write_to_process, ruby_binary

popen = popen_helper(ruby_binary())
for i in range($ITERATIONS):
  print(write_to_process(popen, '../linguist\n'))
" > /dev/null
