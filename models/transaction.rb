require_relative('../db/sql_runner.rb')

class Transaction
  def initialize(options)
    @id = options['id'].to_i
    @amount = options['amount'].to_i
    @tag = options['tag']
    @shop = options['shop']
  end

  def save()
    sql = "INSERT INTO transactions (amount, tag, shop)
     VALUES ($1, $2, $3)RETURNING *"
     values = [@amount, @tag, @shop]
     @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end
end
