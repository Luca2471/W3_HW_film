require_relative("../db/sql_runner")

class Ticket

  attr_reader :id, :film_id, :customer_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO ticket
    (
     customer_id,
     film_id
     )
     VALUES
     (
     $1, $2
     )
     RETURNING id"
     values = [@customer_id, @film_id]
       SqlRunner.run(sql, values)[0];
     @id = SqlRunner.run(sql,values)[0]['id'].to_i()
  end

  def delete()
    sql = "DELETE FROM ticket WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE ticket SET (customer_id, filmd_id, ) = ($1, $2) WHERE id = $3"
    values = [@customer_id, @filmd_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM ticket"
    movie_data = SqlRunner.run(sql)
    return Ticket.map_items(_data)
  end

  def self.delete_all()
    sql = "DELETE FROM ticket;"
    SqlRunner.run(sql)
  end

  def self.map_items(data)
    result = data.map{|ticket| Ticket.new(ticket)}
    return result
  end

end
