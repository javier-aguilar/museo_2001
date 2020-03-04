class Curator

  attr_reader :photographs, :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find { |artist| artist.id == id}
  end

  def find_photos_by_artist(artist_id)
    @photographs.find_all { |photo| photo.artist_id == artist_id}
  end

  def photographs_by_artist
    @artists.reduce({}) do | photographs_by_artist, artist |
    end
  end

end