module Outputters
  class StdOutOutputter < BaseOutputter
    def print
      "#{robot.x},#{robot.y},#{robot.orientation}"
    end

    def error(error)
      error
    end
  end
end
