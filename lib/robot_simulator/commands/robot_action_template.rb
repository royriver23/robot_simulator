require_relative 'command_template'

module RobotSimulator
  module Commands
    class RobotActionTemplate < CommandTemplate
      CARDINAL_POINTS = %W(WEST NORTH EAST SOUTH).freeze
    end
  end
end
