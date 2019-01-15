module Outputters
  class JsonOutputter < BaseOutputter
    def print
      {
        x: robot.x,
        y: robot.y,
        orientation: robot.orientation
      }
    end

    def error; end
  end
end
