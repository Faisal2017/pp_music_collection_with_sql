require('pg')
require_relative('../db/sql_runner.rb')
require_relative('artist.rb')

class Album

  attr_reader :id, :title, :artist_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums
    (
    title,
    artist_id
    )
    VALUES
    (
    '#{@title}',
    #{@artist_id}
    ) 
    RETURNING id;"
    @id = SqlRunner.run(sql)[0]["id"].to_i
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = #{artist_id}"
    results = SqlRunner.run(sql)
    artist_data = results[0]
    artist = Artist.new(artist_data)
    return artist
  end

  def update()
    sql = "
    UPDATE albums SET (
    name
    ) 
    = 
    (
    '#{name}'
    ) 
    WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM albums where id = #{@id}"
    SqlRunner.run(sql) 
  end

  def Album.find(id)
    sql = "SELECT * albums WHERE id = #{id}"
    result = SqlRunner.run(sql) 
    order_hash = result.first
    order = Album.new(order_hash)
    return order
  end
  
  def Album.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    albums.map { |album| Album.new(album) }
  end

  def Album.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  


end