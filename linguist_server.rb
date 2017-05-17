require 'linguist'
require 'rugged'
require 'json'

STDOUT.sync = true

# tbd: handle gracefull shutdown
loop do
  # tbd: EOF error when we are finished
  line = STDIN.readline.chomp

  next if line.empty?

  begin
    rugged = Rugged::Repository.new(line)
  rescue Rugged::OSError, Rugged::RepositoryError
    STDOUT.write(JSON.dump({error: true}))
    STDOUT.write("\n")
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
