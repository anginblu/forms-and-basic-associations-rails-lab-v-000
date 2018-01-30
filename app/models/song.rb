class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes
  accepts_nested_attributes_for :note_contents

  def genre_name
    self.genre.name unless self.genre == nil
  end

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def artist_name
    self.artist.name unless self.artist == nil
  end

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def note_contents
    array = []
    self.notes.each {|note| array << note.content}
    array
  end

  def note_contents=(notes)
    notes.each do |note_content|
      unless note_content == ""
        note = Note.find_or_create_by(content: note_content)
        self.notes << note
      end
    end
  end

end
