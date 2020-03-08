require_relative("db/sql_runner")
require_relative( 'models/customers' )
require_relative( 'models/films' )
require_relative( 'models/tickets' )
require_relative( 'models/screenings' )
require( 'pry-byebug' )

Screening.delete_all()
Ticket.delete_all()
 Film.delete_all()
Customer.delete_all()

film1 =Film.new({ 'title' => 'The Shining','price'=>8 })
film1.save()
film2 = Film.new({ 'title' => 'The Labyrinth','price'=>7 })
film2.save()

film1.title= 'The Birds'
film1.update

 customer1 = Customer.new({ 'name' => 'Jack', 'funds' => 50})
 customer1.save()
 customer2 = Customer.new({ 'name' => 'David', 'funds' => 30})
 customer2.save()

 customer1.name='Fred'
 customer1.update
 customer1.remaining_budget(film1)

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' =>film1.id })
ticket1.save()
 ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id})
ticket2.save()

number_of_tickets = ticket1.how_many_tickets_per_customer_id
  tickets_per_film_id = ticket2.how_many_tickets_per_film_id

  Customer.find_all_customers_per_film_id(film1.id)

 all_films_per_customer_id = film1.find_all_films_per_customer_id(customer1.id)


   screening1 = Screening.new({ 'film_time' => '18:50', 'tickets_per_screening' => ticket1.id,'max_seats'=>15})
  screening1.save()

  screening2 = Screening.new({ 'film_time' => '21:00', 'tickets_per_screening' => ticket2.id,'max_seats'=>15})
  screening2.save()



    binding.pry
nil
