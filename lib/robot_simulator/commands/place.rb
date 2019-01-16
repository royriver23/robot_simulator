module Commands
  class Place < RobotActionTemplate
    PARAMS_CONFIG = %w(x y orientation)

    class << self
      def x_validation(param)
        param.is_a? Object.const_get('Integer')
      end

      def y_validation(param)
        param.is_a? Object.const_get('Integer')
      end

      def orientation_validation(param)
        param.is_a? Object.const_get('String') && self.class.superclass.CARDINAL_POINTS.include? param
      end
    end

    def perform?
      surface.include_x_y?(x: params[:x], y: params[:y])
    end

    def execute
      self.robot.orientation = params[:orientation]
      self.robot.x = params[:x]
      self.robot.y = params[:y]
      self.placed = true
    end
  end
end
