require_relative("../db/sql_runner.rb")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'] if options['id']
    @name = options['name']
    @funds = options['funds']
  end

def save()
  sql = "INSERT INTO customers
  (name, funds)
  VALUES
  ($1, $2)
  RETURNING id;"
  values = [@name, @funds]
  @id = SqlRunner.run(sql, values)[0]['id'].to_i
end

def delete()
  sql = "DELETE FROM customers
  WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def details()
  sql = "SELECT * FROM customers WHERE id =$1"
  values = [@id]
  return SqlRunner.run(sql,values).map{|customer| Customer.new(customer)}
end

def update()
  sql = "UPDATE customers
  SET (name, funds) = ($1, $2)
  WHERE id = $3;"
  values = [@name, @funds, @id]
  SqlRunner.run(sql, values)
end

def films_booked()
  sql = "SELECT films.* FROM films
  INNER JOIN tickets ON films.id = tickets.film_id
  WHERE customer_id = $1;"
  values = [@id]
  return SqlRunner.run(sql, values).map{|film| Film.new(film)}
end

def self.all()
  sql = "SELECT * FROM customers;"
  return SqlRunner.run(sql).map{|customer| Customer.new(customer)}
end

def self.delete_all()
  sql = "DELETE FROM customers;"
  SqlRunner.run(sql)
end


end
