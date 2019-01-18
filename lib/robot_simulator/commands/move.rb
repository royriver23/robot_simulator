require_relative 'robot_action_template'

module RobotSimulator
  module Commands
    class Move < RobotActionTemplate
      PARAMS_CONFIG = [].freeze

      def perform?
        Errors::CommandError.output_error('Robot must be placed in surface first') unless robot.placed
        robot.placed && safe?
      end

      def perform
        self.robot.x = new_position[:new_x]
        self.robot.y = new_position[:new_y]
      end

      private

      def safe?
        (surface.include_x_y?(x: new_position[:new_x], y: new_position[:new_y])) ||
          Errors::CommandError.output_error('The movement is not safe, robot would fall from surface')
      end

      def new_position
        @new_position ||= {
          new_x: robot.x + cardinal_mappings[robot.orientation].first,
          new_y: robot.y + cardinal_mappings[robot.orientation].last
        }
      end

      def cardinal_mappings
        {
          'NORTH' => [0,1],
          'SOUTH' => [0,-1],
          'WEST' => [-1,0],
          'EAST' => [1,0]
        }
      end
    end
  end
end
