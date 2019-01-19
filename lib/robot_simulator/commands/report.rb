require_relative 'command_template'
require 'robot_simulator/factories/outputter_factory'

module RobotSimulator
  module Commands
    class Report < CommandTemplate
      PARAMS_CONFIG = [].freeze

      def perform?
        robot.placed ? true : Errors::CommandError.output_error('Robot must be placed in surface first')
      end

      def report
        $OUTPUTTERS.each do |outputter|
          Factories::OutputterFactory.get_outputter(outputter, robot: robot, surface: surface).report
        end
      end

      alias perform report
    end
  end
end
