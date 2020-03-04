require 'minitest/autorun'
require 'minitest/pride'
require './lib/artist'
require './lib/photograph'
require './lib/curator'

class CuratorTest < Minitest::Test

  def setup
    @curator = Curator.new

    @artist1 = Artist.new({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    })
    @artist2 = Artist.new({
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    })
    @artist3 = Artist.new({
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    })

    @photo1 = Photograph.new({
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    })
    @photo2 = Photograph.new({
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    })
    @photo3 = Photograph.new({
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    })
    @photo4 = Photograph.new({
      id: "4",
      name: "Monolith, The Face of Half Dome",
      artist_id: "3",
      year: "1927"
    })
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_it_has_attributes
    assert_equal [], @curator.photographs
    assert_equal [], @curator.artists
  end

  def test_it_can_add_photograph
    @curator.add_photograph(@photo1)
    @curator.add_photograph(@photo2)

    assert_equal [@photo1, @photo2], @curator.photographs
  end

  def test_it_can_add_artist
    @curator.add_artist(@artist1)
    @curator.add_artist(@artist2)

    assert_equal [@artist1, @artist2], @curator.artists
  end

  def test_it_can_find_artist_by_id
    @curator.add_artist(@artist1)
    @curator.add_artist(@artist2)

    assert_equal @artist1, @curator.find_artist_by_id("1")
  end

  def test_it_can_find_photos_by_artist
    @curator.add_artist(@artist1)
    @curator.add_artist(@artist3)

    @curator.add_photograph(@photo1)
    @curator.add_photograph(@photo2)
    @curator.add_photograph(@photo3)
    @curator.add_photograph(@photo4)

    assert_equal [@photo1], @curator.find_photos_by_artist("1")
    assert_equal [@photo3, @photo4], @curator.find_photos_by_artist("3")
  end

  def test_it_can_return_photographs_by_artist
    @curator.add_artist(@artist1)
    @curator.add_artist(@artist2)
    @curator.add_artist(@artist3)

    @curator.add_photograph(@photo1)
    @curator.add_photograph(@photo2)
    @curator.add_photograph(@photo3)
    @curator.add_photograph(@photo4)

    expected = {
      @artist1 => [@photo1],
      @artist2 => [@photo2],
      @artist3 => [@photo3, @photo4]
    }

    assert_equal expected, @curator.photographs_by_artist
  end

  def test_it_return_artists_with_multiple_photos
    @curator.add_artist(@artist1)
    @curator.add_artist(@artist2)
    @curator.add_artist(@artist3)

    @curator.add_photograph(@photo1)
    @curator.add_photograph(@photo2)
    @curator.add_photograph(@photo3)
    @curator.add_photograph(@photo4)

    assert_equal ["Diane Arbus"], @curator.artists_with_multiple_photographs
  end

  def test_it_can_return_photographs_taken_by_artist_from_country
    @curator.add_artist(@artist1)
    @curator.add_artist(@artist2)
    @curator.add_artist(@artist3)

    @curator.add_photograph(@photo1)
    @curator.add_photograph(@photo2)
    @curator.add_photograph(@photo3)
    @curator.add_photograph(@photo4)

    expected = [@photo2, @photo3, @photo4]
    country = "United States"
    country2 = "Argentina"

    assert_equal expected, @curator.photographs_taken_by_artist_from(country)
    assert_equal [], @curator.photographs_taken_by_artist_from(country2)
  end

  def test_it_can_load_photographs_by_csv
    assert_equal [], @curator.photographs
    @curator.load_photographs('./data/photographs.csv')

    first_photo = @curator.photographs.first
    last_photo = @curator.photographs.last

    assert_equal 4, @curator.photographs.size
    assert_equal "1", first_photo.artist_id
    assert_equal "1", first_photo.id
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", first_photo.name
    assert_equal "1954", first_photo.year

    assert_equal "3", last_photo.artist_id
    assert_equal "4", last_photo.id
    assert_equal "Child with Toy Hand Grenade in Central Park", last_photo.name
    assert_equal "1962", last_photo.year
  end

  def test_it_can_load_artists_by_csv
    assert_equal [], @curator.artists
    @curator.load_artists('./data/artists.csv')

    assert_equal 6, @curator.artists.size

    first_artist = @curator.artists.first
    last_artist = @curator.artists.last

    assert_equal "1", first_artist.id
    assert_equal "Henri Cartier-Bresson", first_artist.name
    assert_equal "1908", first_artist.born
    assert_equal "2004", first_artist.died
    assert_equal "France", first_artist.country

    assert_equal "6", last_artist.id
    assert_equal "Bill Cunningham", last_artist.name
    assert_equal "1929", last_artist.born
    assert_equal "2016", last_artist.died
    assert_equal "United States", last_artist.country
  end

  def test_it_can_return_photographs_taken_between_given_years
    @curator.load_photographs('./data/photographs.csv')
    photographs = @curator.photographs_taken_between(1950..1965)

    assert_equal 2, photographs.size

    assert photographs.first.year.to_i >= 1950
    assert photographs.first.year.to_i <= 1965

    assert photographs.last.year.to_i >= 1950
    assert photographs.last.year.to_i <= 1965
  end

end
