require_relative 'command_error_handling'
require_relative 'errors/abstract_class_error'

module Commands
  class CommandTemplate
    include CommandError
    attr_accessor :params, :robot, :surface

    def initialize(params:, robot:, surface:)
      self.params = Hash[*[self.class.PARAMS_CONFIG, params].transpose.flatten(1)]
      self.robot = robot
      self.surface = surface
    end

    def perform?
      raise Errors::AbstractClassError.new(method: 'perform?')
    end

    def execute
      raise Errors::AbstractClassError.new(method: 'execute')
    end
  end
end
