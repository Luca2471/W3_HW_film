require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :funds, :name


  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
   sql = "INSERT INTO customer
   (
   name,
   funds
      )
    VALUES
    (
    $1, $2
    )
    RETURNING id;"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values)[0]
    @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE FROM customer SET (name, funds, ) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

   def delete()
     sql = "DELETE FROM customer WHERE id = $1"
     values = [@id]
     SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM customer"
    movie_data = SqlRunner.run(sql)
    return Customer.map_items(_data)
  end

  def self.delete_all()
      sql = "DELETE FROM customer"
      SqlRunner.run(sql)
  end

  def self.map_items(data)
    result = data.map{|customer| Customer.new(customer)}
    return result
  end

end
