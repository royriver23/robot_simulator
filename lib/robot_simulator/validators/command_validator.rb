require 'robot_simulator/factories/command_factory'
require 'robot_simulator/errors/command_error'

module RobotSimulator
  module Validators
    class CommandValidator
      include Errors::CommandError
      attr_accessor :cli_data

      def initialize(cli_data:)
        self.cli_data = cli_data
      end

      def valid_syntax?
        valid_command_verb? && valid_number_of_params? && specific_params_valid?
      end

      private

      def valid_command_verb?
        command_class ? true : Errors::CommandError.output_error('Command not found')
      end

      def command_class
        Factories::CommandFactory.command_class(cli_data[:command_verb])
      end

      def valid_number_of_params?
        command_class::PARAMS_CONFIG.size == cli_data[:command_params].size ||
          Errors::CommandError.output_error("Given: #{cli_data[:command_params].size},
            Expected: #{command_class::PARAMS_CONFIG.size}")
      end

      def specific_params_valid?
        return true if command_class::PARAMS_CONFIG.empty?
        invalid_field = nil
        result = command_class::PARAMS_CONFIG.to_enum.with_index.all? do |field, index|
          valid = command_class.send("#{field}_validation", cli_data[:command_params][index])
          invalid_field = field
          valid
        end
        result || Errors::CommandError.output_error("The #{invalid_field} value is not valid")
      end
    end
  end
end
