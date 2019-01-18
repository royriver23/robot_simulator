require_relative 'base_outputter'

module RobotSimulator
  module Outputters
    class PlainTextOutputter < BaseOutputter
      def report
        puts "\n"
        puts "#{robot.x},#{robot.y},#{robot.orientation}"
        puts "\n"
      end

      def error(error)
        puts error
      end
    end
  end
end
