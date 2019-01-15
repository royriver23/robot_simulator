Dir["./outputters/*.rb"].each {|file| require_relative file }

class OutputterFactory
  def instantiate(type, *params)
    outputter_class(type).new(*params)
  rescue NameError => e
    nil
  end
end
