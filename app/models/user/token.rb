class User::Token
  attr_reader :value

  delegate :present?, :blank?, to: :value

  def initialize(value)
    @value = value&.strip
  end
end
