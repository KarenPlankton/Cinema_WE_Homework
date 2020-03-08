require_relative("films.rb")
require_relative("tickets.rb")

require( 'pry-byebug' )


class Customer



    attr_reader :id
    attr_accessor :name, :funds

    def initialize( options )
      @id = options['id'].to_i if options['id']
      @name = options['name']
      @funds = options['funds'].to_i
      # @budget=options['budget'].to_i
    end

    def save()
      sql = "INSERT INTO customers
      (
        name,
        funds
      )
      VALUES
      (
        $1, $2
      )
      RETURNING id"
      values = [@name, @funds]
      customers = SqlRunner.run( sql, values ).first
      @id = customers['id'].to_i
    end

    def update
    sql = "UPDATE customers SET name = $1,funds = $2 WHERE id = $3"
    values = [@name,@funds,@id]
    SqlRunner.run(sql, values)
  end

  def self.find_all_customers_per_film_id(film_id)
     sql ="select * from customers
     inner join tickets
     on tickets.customer_id=customers.id  where film_id=$1"
     values = [film_id.to_i]
    customers =SqlRunner.run(sql,values)
    result=customers.map {|customer| Customer.new(customer)}
   return result
   end


      def remaining_budget(film)
       @funds=@funds-film.price
       self.update

      end


    def self.all()
      sql = "SELECT * FROM customers"
      customers = SqlRunner.run(sql)
      result = customers.map { |customer| Customer.new( customer ) }
      return result
    end

    def self.delete_all()
      sql = "DELETE FROM customers"
      SqlRunner.run(sql)
    end

  end
