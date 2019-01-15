Dir["./commands/*.rb"].each {|file| require_relative file }

module CommandError
  def output_error(error)
    $OUTPUTTERS.each do |outputter|
      OutputterFactory.get_outputter
    end
  end
end
