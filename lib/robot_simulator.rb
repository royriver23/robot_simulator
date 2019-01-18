require 'robot_simulator/version'
require 'robot_simulator/entities/surface'
require 'robot_simulator/entities/robot'
require 'robot_simulator/robot_cli'

module RobotSimulator
  class Error < StandardError; end

  def self.start(width:, height:, outputters:, report_on_every_command:)
    $OUTPUTTERS = outputters
    robot = Entities::Robot.new
    surface = Entities::Surface.new(width: width, height: height)
    RobotCli.new(robot: robot, surface: surface, report_on_every_command: report_on_every_command).loop_user_input
  end
end
