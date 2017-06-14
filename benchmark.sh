# improve this
trap 'exit -1' INT

ITERATIONS="${1:-50}"

echo "==> Iterations=$ITERATIONS"
echo

echo "==> Benchmarking on demand process spawning..."
time python -c "
from client import popen_helper, ruby_binary, classify

for i in range($ITERATIONS):
  popen = popen_helper(ruby_binary())
  print(classify(popen, '../linguist\n'))
" > /dev/null

echo
echo

echo "==> Benchmarking long-running subprocess with IPC..."
time python -c "
from client import popen_helper, ruby_binary, classify

popen = popen_helper(ruby_binary())
for i in range($ITERATIONS):
  print(classify(popen, '../linguist\n'))
" > /dev/null
