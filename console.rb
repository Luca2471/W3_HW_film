require_relative('./models/ticket')
require_relative('./models/film')
require_relative('./models/customer')

require('pry')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

film1 = Film.new({
  'title' => 'Suspiria',
  'price' => 7
  })

film1.save()

film2 = Film.new({
  'title' => 'The Seventh Seal',
  'price' => 7
  })

film2.save()

film3 = Film.new({
  'title' => 'Mean Streets',
  'price' => 7
  })

film3.save()

customer1 = Customer.new({
    'name' => 'Jose',
    'funds' => 100
    })

customer1.save()

customer2 = Customer.new({
    'name' => 'Carlos',
    'funds' => 75
    })

customer2.save()

ticket1 = Ticket.new({'film_id' => film1.id,
   'customer_id' => customer1.id})

   ticket1.save()


ticket2 = Ticket.new({'film_id' => film2.id,
  'customer_id' => customer2.id})

  ticket2.save()


ticket3 = Ticket.new({'film_id' => film3.id,
   'customer_id' => customer1.id})

   ticket3.save()


ticket4 = Ticket.new({'film_id' => film3.id,
  'customer_id' => customer2.id})

  ticket4.save()

binding.pry
nil
