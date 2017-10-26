require_relative('user.rb')

class Transaction
  attr_reader :id
  attr_accessor :amount, :tag, :shop, :date, :user_id
  def initialize(options)
    @id = options['id'].to_i
    @amount = options['amount'].to_i
    @tag = options['tag']
    @shop = options['shop']
    @date = options['date']
    @user_id = options['user_id'].to_i
  end

  def save()
    sql = "INSERT INTO transactions (amount, tag, shop, date, user_id)
     VALUES ($1, $2, $3, current_date, $4) RETURNING *"
     values = [@amount, @tag, @shop, @user_id]
     @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM transactions"
    values = []
    results = SqlRunner.run(sql, values)
    transactions = results.map {|result| Transaction.new(result)}
    return transactions
  end

  def self.total(id)
    sql = "SELECT SUM(amount) FROM transactions WHERE user_id = $1"
    values = [id]
    SqlRunner.run(sql, values)[0]['sum']
  end

  def self.totaltag(tag)
    sql = "SELECT SUM(amount) FROM transactions WHERE tag = $1"
    values = [tag]
    SqlRunner.run(sql, values)[0]['sum']
  end

  def self.alltags()
    sql = "SELECT DISTINCT tag FROM transactions"
    values = []
    results = SqlRunner.run(sql, values)
    transactions = results.map {|transaction| Transaction.new(transaction)}
    return transactions
  end

  def self.find(id)
    sql = "SELECT * FROM transactions WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    transaction = Transaction.new(result)
  end

  def update()
    sql = "UPDATE transactions SET (amount, tag, shop, date) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@amount, @tag, @shop, @date, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM transactions WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.dates()
    sql = "SELECT DISTINCT date FROM transactions"
    values = []
    results = SqlRunner.run(sql, values)
    transactions = results.map {|transaction| Transaction.new(transaction)}
    return transactions
  end

  def self.totaldate(date)
    return if date == "none"
    sql = "SELECT SUM(amount) FROM transactions WHERE date = $1"
    values = [date]
    SqlRunner.run(sql, values)[0]['sum']
  end
end
