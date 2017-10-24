require_relative('transaction.rb')
class User
  attr_reader :id
  attr_accessor :name, :budget

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @budget = options['budget'].to_i
  end

  def save()
    sql = "INSERT INTO users (name, budget)
    VALUES ($1, $2) RETURNING *"
    values = [@name, @budget]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def subtract(transaction)
    amount = transaction.amount
    @budget = @budget - amount
  end
end



# sql = "SELECT * FROM transactions WHERE user_id = $1"
# values = [@id]
# results = SqlRunner.run(sql, values)
# transactions = results.map {|result| result["amount"]}
# return transactions
