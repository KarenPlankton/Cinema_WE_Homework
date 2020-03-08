require_relative("../db/sql_runner")
require_relative("films.rb")
require_relative("customers.rb")

require( 'pry-byebug' )

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    # @fee = options['fee'].to_i
  end

  def save()
    sql = "INSERT INTO tickets
    (
      customer_id,
      film_id

    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@customer_id, @film_id] #, @fee
    tickets = SqlRunner.run( sql,values ).first
    @id = tickets['id'].to_i
  end

  def how_many_tickets_per_customer_id
    sql= "select * from tickets
    where customer_id =$1"
    values = [@customer_id]
    result =SqlRunner.run(sql,values)

    tickets_by_customer = result.reduce(0) {|total,result| total+1}
    return tickets_by_customer
  end

#how many customers are going to watch a certain film
  def how_many_tickets_per_film_id
    sql= "select * from tickets
          where film_id =$1"
     values = [@film_id]
    result =SqlRunner.run(sql,values)

    tickets_per_film_id = result.reduce(0) {|total,result| total+1}
    return tickets_per_film_id
end

  def update
  sql = "UPDATE tickets SET film_id = $1,customer_id=$2 WHERE id = $3"
  values = [@film_id,@customer_id,@id]
  SqlRunner.run(sql, values)
end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| Ticket.new( ticket ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end
