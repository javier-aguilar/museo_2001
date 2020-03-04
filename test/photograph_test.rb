require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'

class PhotographTest < Minitest::Test

  def test_it_exists
    attributes = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "4",
      year: "1954"
    }
    photograph = Photograph.new(attributes)
    assert_instance_of Photograph, photograph
  end
  
end
