require_relative("../db/sql_runner.rb")

class Ticket

attr_reader :id
attr_accessor :customer_id, :film_id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @customer_id = options['customer_id'].to_i
  @film_id = options['film_id'].to_i
end

def save()
  sql = "INSERT INTO tickets
  (customer_id, film_id)
  VALUES
  ($1, $2)
  RETURNING id;"
  values = [@customer_id, @film_id]
  @id = SqlRunner.run(sql, values)[0]['id'].to_i
end

def delete()
  sql = "DELETE FROM tickets WHERE id =$1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def details()
  sql = "SELECT * FROM tickets WHERE id =$1;"
  values = [@id]
  return SqlRunner.run(sql, values).map{|ticket_details| Ticket.new(ticket_details)}
end

def update()
  sql = "UPDATE tickets SET
  (customer_id, film_id) = ($1, $2)
  WHERE id = $3"
  values = [@customer_id, @film_id, @id]
  SqlRunner.run(sql,values)
end

def self.ticket_sale(customer,film, num_of_tickets)
  ticket = 0
  while ticket < num_of_tickets
  customer.buy_ticket(film)
  sale = Ticket.new({'customer_id' => customer.id, 'film_id' => film.id})
  sale.save()
  ticket += 1
  end
  customer.update()
  return "#{customer.name}, thank you for your purchase of #{num_of_tickets} tickets for #{film.title}"
end

def self.number_of_tickets(customer)
  sql = "SELECT * FROM tickets
  WHERE customer_id = $1"
  values = [customer.id]
  tickets =  SqlRunner.run(sql, values).count
  return "#{customer.name} has bought #{tickets} ticket(s)"
end

def self.customers_booked(film)
  sql = "SELECT * FROM tickets
  WHERE film_id = $1"
  values = [film.id]
  tickets = SqlRunner.run(sql, values).count
  return "#{tickets} customers are going to watch #{film.title}"
end

def self.all()
  sql = "SELECT * FROM tickets;"
  return SqlRunner.run(sql).map{|ticket| Ticket.new(ticket)}
end

def self.delete_all()
  sql = "DELETE FROM tickets;"
  SqlRunner.run(sql)
end

end
