from subprocess import Popen, PIPE
import os
import json


def write_to_process(process, data):
    process.stdin.write(data)
    process.stdin.write(b'\n')
    process.stdin.flush()

    read_line = p.stdout.readline()
    read_line = read_line.strip().decode()

    return json.loads(read_line)

default_ruby_binary = '/Users/javierhonduco/.rbenv/shims/ruby'
ruby_binary = os.environ.get('RUBY_BINARY', default_ruby_binary)

p = Popen([ruby_binary, 'linguist_server.rb'], stdin=PIPE, stdout=PIPE)


print(write_to_process(p, b'../\n'))
print(write_to_process(p, b'../linguist\n'))
print(write_to_process(p, b'../\n'))
