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

  def self.find(transaction)
    sql = "SELECT * FROM users WHERE id = $1"
    values = [transaction.user_id]
    result = SqlRunner.run(sql, values)[0]
    user = User.new(result)
  end

  def self.budget(id)
    sql = "SELECT budget FROM users WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)[0]["budget"]
  end

  def self.all()
    sql = "SELECT * FROM users"
    values = []
    results = SqlRunner.run(sql, values)
    users = results.map {|user| User.new(user)}
    users
  end
end
