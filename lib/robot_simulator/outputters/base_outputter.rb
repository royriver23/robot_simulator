module RobotSimulator
  module Outputters
    class BaseOutputter
      attr_accessor :robot, :surface

      def initialize(robot: nil, surface: nil)
        self.robot = robot
        self.surface = surface
      end

      def report
        raise Errors::AbstractClassError.new(method: 'report')
      end

      def error(_error)
        raise Errors::AbstractClassError.new(method: 'error')
      end
    end
  end
end
