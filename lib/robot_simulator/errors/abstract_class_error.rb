class AbstractClassError < StandardError
  def initialize(method:)
    super "#{method} logic must be implemented in corresponding child class"
  end
end
