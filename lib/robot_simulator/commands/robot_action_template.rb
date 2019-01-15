module Commands
  class RobotActionTemplate < CommandTemplate
    CARDINAL_POINTS = %W(WEST NORTH WEST SOUTH).freeze

=begin
    Configure the params that command will receive using something like:
      PARAMS_CONFIG = %w(x y orientation)
=end

    # By default, all params are valid
    self.class.PARAMS_CONFIG.each do |param|
      define_singleton_method "#{param}_validation" { |param| true }
    end

=begin
  Override this by defining the validation (class method) in corresponding command class,
  using _validation suffix, for example:

  def self.x_validation(param)
    # Validation conditions
  end
=end
  end
end
