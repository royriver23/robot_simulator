require_relative '../commands/move'
require_relative '../commands/place'
require_relative '../commands/left'
require_relative '../commands/right'
require_relative '../commands/report'

module RobotSimulator
  module Factories
    class CommandFactory
      def self.instance(type, *params)
        command_class(type).new(*params)
      end

      def self.command_class(type)
        Commands::const_get("#{type.capitalize}")
      rescue NameError => e
        nil
      end
    end
  end
end
