from subprocess import Popen, PIPE
import os
import json


def write_to_process(process, data):
    process.stdin.write(data)
    process.stdin.write('\n')

    read_line = process.stdout.readline()
    read_line = read_line.strip()

    return json.loads(read_line)

def popen_helper(ruby_binary):
    return Popen([ruby_binary, 'linguist_server.rb'], stdin=PIPE, stdout=PIPE, bufsize=1, universal_newlines=True)

default_ruby_binary = '/Users/javierhonduco/.rbenv/shims/ruby'

def ruby_binary():
    return os.environ.get('RUBY_BINARY', default_ruby_binary)

if __name__ == '__main__':
    popen = popen_helper(ruby_binary())
    print(write_to_process(popen, '../linguist\n'))