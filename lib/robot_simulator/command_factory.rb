Dir["./commands/*.rb"].each {|file| require_relative file }

class CommandFactory
  def instance(type, *params)
    command_class(type).new(*params)
  end

  def self.command_class(type)
    @command_class ||= Object.const_get "Commands::#{type.capitalize}"
  rescue NameError => e
    nil
  end
end
