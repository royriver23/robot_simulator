require_relative 'command_factory'
require_relative 'surface'
require_relative 'robot'
require_relative 'command_data_extractor'

$OUTPUTTERS = %i[json stdout ascii]

robot = Robot.new
surface = Surface.new(width: 5, height: 5)
cli = CommandDataExtractor.new(command: 'PLACE 1,2,NORTH', robot: robot)

if cli.valid?
  params = {
    params: cli[:command_params],
    robot: robot,
    surface: surface
  }
  command = CommandFactory.instance(cli[:command_verb], params)
  command.perform? && command.execute
end
