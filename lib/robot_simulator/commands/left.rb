require_relative 'robot_action_template'

module RobotSimulator
  module Commands
    class Left < RobotActionTemplate
      PARAMS_CONFIG = [].freeze

      def perform
        self.robot.orientation = CARDINAL_POINTS.rotate(-1)[CARDINAL_POINTS.index(robot.orientation)]
      end

      def perform?
        robot.placed ? true : Errors::CommandError.output_error('Robot must be placed in surface first')
      end
    end
  end
end
