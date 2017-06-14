from subprocess import Popen, PIPE
import os
import json
import signal
import sys


def write_to_process(process, data):
    process.stdin.write(data)
    process.stdin.write('\n')

    read_line = process.stdout.readline()
    read_line = read_line.strip()

    return json.loads(read_line)

def popen_helper(ruby_binary):
    p = Popen([ruby_binary, 'linguist_server.rb'], stdin=PIPE, stdout=PIPE, bufsize=1, universal_newlines=True)

    def sigint_handler(signal, frame):
        print('[info] about to kill child with pid={}'.format(p.pid))
        os.kill(p.pid, 9)
        print('[info] exiting...')
        sys.exit(0)

    signal.signal(signal.SIGINT, sigint_handler)

    return p

default_ruby_binary = '/Users/javierhonduco/.rbenv/shims/ruby'

def ruby_binary():
    return os.environ.get('RUBY_BINARY', default_ruby_binary)

if __name__ == '__main__':
    popen = popen_helper(ruby_binary())
    print(write_to_process(popen, '../linguist\n'))
