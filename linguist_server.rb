require 'linguist'
require 'rugged'
require 'json'

STDOUT.sync = true
@work = true

def show_error(message)
  STDOUT.write(JSON.dump({error: true, message: message}))
  STDOUT.write("\n")
end

# tbd: handle gracefull shutdown
loop do
  break unless @work
  # tbd: EOF error when we are finished
  begin
    line = STDIN.readline.chomp
  rescue EOFError
    @work = false
    break
  end

  next if line.empty?

  begin
    rugged = Rugged::Repository.new(line)
  rescue Rugged::OSError
    show_error('rugged OS Error')
    next
  rescue Rugged::RepositoryError
    show_error('rugged Repository Error')
    next
  end

  repo = Linguist::Repository.new(rugged, rugged.head.target_id)

  output = {
    languages: repo.languages,
    breakdown: repo.breakdown_by_file,
  }

  STDOUT.write(JSON.dump(output))
  STDOUT.write("\n")
end
