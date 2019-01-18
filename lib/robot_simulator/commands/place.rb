require_relative 'robot_action_template'

module RobotSimulator
  module Commands
    class Place < RobotActionTemplate
      PARAMS_CONFIG = %w(x y orientation).freeze

      class << self
        # ---- Parameters Validations ----
        def x_validation(param)
          is_integer?(param)
        end

        def y_validation(param)
          is_integer?(param)
        end

        def orientation_validation(param)
          param.is_a?(Object.const_get('String')) && self::CARDINAL_POINTS.include?(param.upcase)
        end
      end

      def perform?
        (@surface.include_x_y?(x: params['x'].to_i, y: params['y'].to_i)) ||
          Errors::CommandError.output_error('The movement is not safe, robot would fall from surface')
      end

      def perform
        self.robot.orientation = params['orientation'].upcase
        self.robot.x = params['x'].to_i
        self.robot.y = params['y'].to_i
        self.robot.placed = true
      end
    end
  end
end
