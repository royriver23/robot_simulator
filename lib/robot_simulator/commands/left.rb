module Commands
  class Left < RobotActionTemplate
    PARAMS_CONFIG = []

    def execute
      new_cardinal_index = CARDINAL_POINTS.index(robot.orientation) - 1
      self.robot.orientation = CARDINAL_POINTS[new_cardinal_index]
    end

    def perform?
      true
    end
  end
end
