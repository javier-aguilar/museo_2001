class Curator

  attr_reader :photographs

  def initialize
    @photographs = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

end