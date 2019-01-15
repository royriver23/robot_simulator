module Outputters
  class BaseOutputter
    attr_accessor :robot

    def initialize(robot)
      self.robot = robot
    end

    def print
      raise Errors::AbstractClassError.new(method: 'print')
    end
  end
end
