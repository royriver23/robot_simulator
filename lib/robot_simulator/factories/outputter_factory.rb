require 'robot_simulator/outputters/json_outputter'
require 'robot_simulator/outputters/ascii_outputter'
require 'robot_simulator/outputters/plain_text_outputter'

module RobotSimulator
  class OutputterFactory
    def self.get_outputter(type, *params)
      outputter_class(type).new(*params)
    end

    def self.outputter_class(type)
      name =  type.split('_').map(&:capitalize).join
      RobotSimulator::Outputters::const_get("#{name}Outputter")
    rescue NameError => e
      nil
    end
  end
end
