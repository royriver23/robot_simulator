require 'robot_simulator/factories/outputter_factory'
module RobotSimulator
  module Errors
    module CommandError
      def self.output_error(error)
        puts "\n[ERROR] Your command couldn't be performed: \n".red
        $OUTPUTTERS.each do |outputter|
          OutputterFactory.get_outputter(outputter).error(error)
          puts "\n\n"
        end
        false
      end
    end
  end
end
