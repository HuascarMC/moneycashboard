require_relative('transaction.rb')
require_relative('../db/sql_runner.rb')
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

  def self.find(transaction)
    return if transaction != nil
    sql = "SELECT * FROM users WHERE id = $1"
    values = [transaction.user_id]
    result = SqlRunner.run(sql, values)[0]
    user = User.new(result)
  end

  def self.find(id)
    sql = "SELECT * FROM users WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    user = User.new(result)
    return user
  end

  def find_transactions()
    sql = "SELECT * FROM transactions WHERE user_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    transactions = results.map {|transaction| Transaction.new(transaction)}
    return transactions
  end

  def self.budget(id)
    return if User.all() != nil
    sql = "SELECT budget FROM users WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)[0]['budget']
  end

  def self.all()
    sql = "SELECT * FROM users"
    values = []
    results = SqlRunner.run(sql, values)
    users = results.map {|user| User.new(user)}
    return users
  end

  def update()
    sql = "UPDATE users SET (budget) = ($1) WHERE id = $2"
    values = [@budget, @id]
    SqlRunner.run(sql, values)
  end

  def subtract(transaction)
    amount = transaction.amount
    @budget = @budget - amount
    update()
  end
end
