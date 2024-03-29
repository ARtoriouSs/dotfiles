# frozen_string_literal: true

# hit enter key to repeat last command unless it is exit-program
Pry::Commands.command(/^$/, 'repeat last command') do
  last_command = Pry.history.to_a.last
  pry_instance.run_command(last_command) unless %w[exit-program quit q].include?(last_command)
end

Pry::Commands.command('cpl', 'copy last execuded command to clipboard') do
  system("echo '#{Pry.history.to_a[-2]}' | xclip -rmlastnl -selection clipboard")
end

Pry::Commands.command('trace', 'caller with only local trace') do
  puts(caller.filter { |trace_item| trace_item.include?(`pwd`.delete("\n")) })
end

# copies argument to clipboard
def cp(arg)
  system("echo '#{arg}' | xclip -rmlastnl -selection clipboard")
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

# set prompt as object name and cut it if it's too long (for tests)
Pry.config.prompt = Pry::Prompt.new(
  'Prompt',
  'Prompt with long class names truncation',
  [
    proc do |object, _nesting_level, _|
      object_string = object.class.to_s
      if object_string.length > 50
        modules = object_string.split('::')
        object_string = "#{modules.first}::<...>::#{modules.last}" if modules.count >= 3
      end
      "#{object_string} > "
    end
  ]
)
