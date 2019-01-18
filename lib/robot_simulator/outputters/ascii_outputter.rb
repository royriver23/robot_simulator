require_relative 'base_outputter'

module RobotSimulator
  module Outputters
    class AsciiOutputter < BaseOutputter
      def report
        puts "\n"
        (surface.height - 1).downto(0) do |y|
          (0).upto(surface.width - 1) do |x|
            print ((x == robot.x && y == robot.y) ? " #{orientation} " : ' . ').green.bold.bg_blue
          end
          puts ''.green.bold.bg_blue
        end
        puts "\n"
      end

      def error(_error); end

      private

      def orientation
        { 'NORTH' => '^', 'SOUTH' => 'v', 'WEST' => '<', 'EAST' => '>' }[robot.orientation]
      end
    end
  end
end
