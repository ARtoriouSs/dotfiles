# hit enter key to repeat last command unless it is exit-program
Pry::Commands.command(/^$/, 'repeat last command') do
  last_command = Pry.history.to_a.last
  unless ['exit-program', 'quit', 'q'].include? last_command
    pry_instance.run_command last_command
  end
end

Pry::Commands.command('cpl', 'copy last execuded command') do
  system("echo '#{Pry.history.to_a[-2]}' | xclip -rmlastnl -selection clipboard")
end

if defined? Rails
  Pry::Commands.command('rel', 'alias for #reload!') do
    Rails.application.reloader.reload!
    true
  end
end

# aliases
Pry.commands.alias_command 'exot', 'exit' # for typos
Pry.commands.alias_command 'w', 'whereami'
Pry.commands.alias_command 'q', 'exit-program'
Pry.commands.alias_command 'e', 'exit'

# turn off the automatic pager for long output
Pry.config.pager = false

# set prompt as object name and cut it if it's too long (for tests)
Pry.config.prompt = Pry::Prompt.new(
  'Prompt',
  'Prompt with long class names truncation',
  [
    proc do |object, nesting_level, _|
      object_string = object.class.to_s
      if object_string.length > 50
        modules = object_string.split('::')
        object_string = "#{modules.first}::<...>::#{modules.last}" if modules.count >= 3
      end
      "#{object_string} > "
    end
  ]
)
