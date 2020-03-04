require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'

class ArtistTest < Minitest::Test

  def test_it_exists
    attributes = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    artist = Artist.new(attributes)
    assert_instance_of Artist, artist
  end


  def test_it_has_attributes
    skip
  end

  def test_it_can_calculate_age_of_death
    skip
  end
end
