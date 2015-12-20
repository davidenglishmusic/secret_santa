class Participant
  attr_accessor :name
  attr_accessor :partner

  def initialize(name, partner = nil)
    @name = name
    @partner = partner
  end
end
