Dir["./outputters/*.rb"].each {|file| require_relative file }

class OutputterFactory
  def instantiate(type, *params)
    command_class(type).new(*params)
  end

  def self.command_class(type)
    @command_class ||= Object.const_get "Outputters::#{type.capitalize}Outputter"
  rescue NameError => e
    nil
  end
end
