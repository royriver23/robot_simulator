require_relative 'command_hub'
require_relative 'command_error_handling'

module Validators
  class CommandValidator
    include CommandError
    attr_accessor :cli_data, :robot

    def initialize(cli_data:, robot:)
      self.cli_data = cli_data
      self.robot = robot
    end

    def valid_syntax?
      valid_command_verb? && valid_number_of_params? && specific_params_valid?
    end

    private

    def valid_command_verb?
      output_error() unless command_class
      command_class
    end

    def command_class
      @command_class ||= CommandHub.command_class(cli_data[:command_verb])
    end

    def valid_number_of_params?
      command_class::PARAMS_CONFIG.size == cli_data[:command_params].size ||
        output_error "Given: #{cli_data[:command_params].size},
          Expected: #{command_class::PARAMS_CONFIG.size}"
    end

    def specific_params_valid?
      return true if command_class::PARAMS_CONFIG.empty?
      invalid_field = nil
      command_class::PARAMS_CONFIG.to_enum.with_index.all? do |field, index|
        valid = command_class.send("#{field}_validation", cli_data[:command_params][index])
        invalid_field = field
        valid
      end
      result || output_error("The #{invalid_field} value is not valid")
    end
  end
end
