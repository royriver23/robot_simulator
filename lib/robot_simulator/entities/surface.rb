module RobotSimulator
  module Entities
    class Surface
      attr_reader :width, :height

      def initialize(width:, height:)
        @width = width.to_i
        @height = height.to_i
      end

      def include_x_y?(x:, y:)
        (0..(width - 1)) === x && (0..(height - 1)) === y
      end
    end
  end
end
