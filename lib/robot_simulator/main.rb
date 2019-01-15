require_relative 'command_factory'
require_relative 'surface'
require_relative 'robot'
require_relative 'command_data_extractor'

$OUTPUTTERS = %i[json stdout ascii]

s = Surface.new(width: 5, height: 5)
robot = Robot.new(surface: s)
cli = CommandDataExtractor.new(command: 'PLACE 1,2,NORTH', robot: robot)

if cli.valid?
  params = {
    params: cli[:command_params],
    robot: robot
  }
  command = CommandFactory.instance(cli[:command_verb], params)
  command.perform? && command.execute
end
