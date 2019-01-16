module Commands
  class Move < RobotActionTemplate
    PARAMS_CONFIG = []

    def perform?
      output_error('Robot must be placed in surface first') unless robot.placed
      robot.placed && safe?
    end

    def execute
      self.robot.x = new_position[:new_x]
      self.robot.y = new_position[:new_y]
    end

    private

    def safe?
      (
        surface.include_x_y?(x: new_position[:new_x], y: new_position[:new_y])
      ) || output_error('The movement is not safe, robot would fall from surface')
    end

    def new_position
      unless @new_position
        x_step, y_step = cardinal_mappings[robot.orientation]
        @new_position = {
          new_x: robot.x + x_step,
          new_y: robot.y + y_step
        }
      end
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
