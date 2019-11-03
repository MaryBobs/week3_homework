require("pry-byebug")
require_relative("models/customer.rb")
require_relative("models/film.rb")
require_relative("models/ticket.rb")

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({'name' => 'Bill', 'funds' => 10})
customer2 = Customer.new({'name' => 'Ben', 'funds' => 20})
customer1.save()
customer2.save()


film1 = Film.new({'title' => 'Goodfellas', 'price' => 5})
film2 = Film.new({'title' => 'The Princess Bride', 'price' => 7})
film1.save
film2.save

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket1.save()
ticket2.save()

customers = Customer.all()
films = Film.all()
tickets = Ticket.all

binding.pry
nil
