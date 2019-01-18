require 'robot_simulator/errors/command_error'
require 'robot_simulator/errors/abstract_class_error'

module RobotSimulator
  module Commands
    class CommandTemplate
      attr_accessor :params, :robot, :surface
      PARAMS_CONFIG = [].freeze

=begin
  1. Configure the params that command will receive using something like:
     PARAMS_CONFIG = %w(x y orientation)

  2. Configure your validations as class methods in corresponding command class,
     using _validation suffix, for example:

    def self.x_validation(param)
      # Validation conditions
    end
=end

      def initialize(params:, robot:, surface:)
        self.params = Hash[*[self.class::PARAMS_CONFIG, params].transpose.flatten(1)]
        self.robot = robot
        self.surface = surface
      end

      def perform?
        raise Errors::AbstractClassError.new(method: 'perform?')
      end

      def perform
        raise Errors::AbstractClassError.new(method: 'perform')
      end

      def self.is_integer?(val)
        val =~ /^[-+]?[0-9]([0-9]*)?$/
      end
    end
  end
end
