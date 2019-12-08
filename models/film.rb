require_relative("../db/sql_runner")

class Film

  attr_reader :id, :title
  attr_accessor :price


  def initialize( options )
     @id = options['id'].to_i if options['id']
     @title = options['title']
     @price = options['price']
  end

  def save()
     sql = "INSERT INTO film
      (
     title,
      price
     )
     VALUES
     (
       $1, $2
       )
       RETURNING id;"
       values = [@title, @price]
       film = SqlRunner.run(sql, values)[0]
       @id = film['id'].to_i
   end

   def update()
        sql = "UPDATE film SET (title, price, ) = ($1, $2) WHERE id = $3"
        values = [@title, @price, @id]
        SqlRunner.run(sql, values)
   end

   def delete()
     sql = "DELETE FROM film WHERE id = $1"
     values = [@id]
     SqlRunner.run(sql, values)
   end

   def delete()
     sql = "DELETE FROM film WHERE id = $1"
     values = [@id]
     SqlRunner.run(sql, values)
   end

   def self.all()
    sql = "SELECT * FROM film"
    movie_data = SqlRunner.run(sql)
    return Film.map_items(_data)
  end

  def self.delete_all()
    sql = "DELETE FROM film;"
    SqlRunner.run(sql)
  end

  def self.map_items(data)
    result = data.map{|film| Film.new(film)}
    return result
  end

  def customer()
    sql = "
      SELECT customer.* FROM customer
      INNER JOIN tickets ON tickets.customer_id = customer.id
      WHERE tickets.film_id = $1;
    "
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{ |hash| Customer.new(hash) }
  end

end
