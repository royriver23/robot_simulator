require 'json'

module Outputters
  class JsonOutputter < BaseOutputter
    def print
      JSON.pretty_generate ({
        x: robot.x,
        y: robot.y,
        orientation: robot.orientation
      })
    end

    def error(error)
      JSON.pretty_generate({ error: error })
    end
  end
end
