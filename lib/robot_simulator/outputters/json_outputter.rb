require 'json'
require_relative 'base_outputter'

module RobotSimulator
  module Outputters
    class JsonOutputter < BaseOutputter
      def report
        puts "\n"
        puts JSON.pretty_generate ({
          x: robot.x,
          y: robot.y,
          orientation: robot.orientation
        })
        puts "\n"
      end

      def error(error)
        puts JSON.pretty_generate({ error: error })
      end
    end
  end
end
