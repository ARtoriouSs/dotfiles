# hit enter key to repeat last command unless it is exit-program
Pry::Commands.command(/^$/, 'repeat last command') do
  last_command = Pry.history.to_a.last
  unless ['exit-program', 'quit', 'q'].include? last_command
    _pry_.run_command last_command
  end
end

# aliases
Pry.commands.alias_command 'w', 'whereami'
Pry.commands.alias_command 'q', 'exit-program'
Pry.commands.alias_command 'e', 'exit'
if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

# turn off the automatic pager for long output
Pry.config.pager = false

# set prompt as object name and cut it if it's too long
Pry.config.prompt = proc do |object, nesting_level, _|
  object_string = object.class.to_s
  if object_string.length > 50
    modules = object_string.split('::')
    object_string = "#{modules.first}::<...>::#{modules.last}" if modules.count >= 3
  end
  "#{object_string} > "
end
