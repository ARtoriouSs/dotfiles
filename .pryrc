# hit enter key to repeat last command
Pry::Commands.command(/^$/, 'repeat last command') do
  last_command = Pry.history.to_a.last
  unless ['c', 'continue', 'q', 'exit-program', 'quit'].include? last_command
    _pry_.run_command last_command
  end
end

# aliases
Pry.commands.alias_command 'q', 'exit-program'
Pry.commands.alias_command 'e', 'exit'
if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

# turn off the automatic pager
Pry.config.pager = false

# set prompt name as current directiry
Pry.config.prompt_name = File.basename(Dir.pwd)
