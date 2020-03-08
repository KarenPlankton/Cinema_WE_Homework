require_relative("films.rb")
require_relative("tickets.rb")

require( 'pry-byebug' )
class Film



    attr_reader :id
    attr_accessor :title, :price

    def initialize( options )
      @id = options['id'].to_i if options['id']
      @title = options['title']
      @price = options['price'].to_i
      # @budget=options['budget'].to_i
    end

    def save()
      sql = "INSERT INTO films
      (
        title,
        price
      )
      VALUES
      (
        $1, $2
      )
      RETURNING id"
      values = [@title, @price]
      films = SqlRunner.run( sql, values ).first
      @id = films['id'].to_i
    end

    def update
    sql = "UPDATE films SET title = $1,price = $2 WHERE id = $3"
    values = [@title,@price,@id]
    SqlRunner.run(sql, values)
  end

  def find_all_films_per_customer_id(cust_id)
    sql ="select * from films
    inner join tickets
    on tickets.film_id=films.id  where customer_id=$1"
    values = [cust_id.to_i]
    films =SqlRunner.run(sql,values)
    result=films.map {|film| Film.new(film)}
    return result
  end

    def self.all()
      sql = "SELECT * FROM films"
      films = SqlRunner.run(sql)
      result = films.map { |film| Film.new( film ) }
      return result
    end

    def self.delete_all()
      sql = "DELETE FROM films"
      SqlRunner.run(sql)
    end

  end
