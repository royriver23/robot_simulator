require_relative 'command_data_extractor'
require_relative 'factories/command_factory'

module RobotSimulator
  class RobotCli
    def initialize(robot:, surface:, report_on_every_command:)
      @robot = robot
      @surface = surface
      @report_on_every_command = report_on_every_command
      puts "\n\n"
    end

    def loop_user_input
      user_input = nil
      loop do
        print "> ".cyan
        user_input = $stdin.gets&.chomp
        break if user_input.nil? || user_input.downcase == 'exit'
        cli = CommandDataExtractor.new(command: user_input)
        run_command(cli) if cli.valid?
        trigger_report if report?(user_input)
      end
    end

    private

    def run_command(cli)
      params = {
        params: cli.cli_data[:command_params],
        robot: @robot,
        surface: @surface
      }
      command = Factories::CommandFactory.instance(cli.cli_data[:command_verb], params)
      command.perform? && command.perform
    end

    def trigger_report
      cli = CommandDataExtractor.new(command: 'report')
      run_command(cli) if cli.valid?
    end

    def report?(user_input)
      @report_on_every_command && user_input.downcase != 'report' && @robot.placed
    end
  end
end
