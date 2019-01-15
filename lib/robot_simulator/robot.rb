class Robot
  attr_accessor :x, :y, :orientation, :placed, :surface

  def initialize(surface:)
    self.surface = surface
  end
end
