require_relative 'validators/command_validator'

module RobotSimulator
  class CommandDataExtractor
    attr_reader :cli_data

    def initialize(command:)
      @command = command.squeeze(' ').strip
      extract_data
    end

    def valid?
      Validators::CommandValidator.new(cli_data: cli_data).valid_syntax?
    end

    private

    def extract_data
      @cli_data = {
        command_verb: command_verb,
        command_params: command_params,
        full_command: @command,
      }
    end

    def command_verb
      @command.split(' ').first
    end

    def command_params
      @command_params ||= @command.match(/(?<=#{command_verb} ).*/).to_s.split(',').map(&:strip)
    end
  end
end
