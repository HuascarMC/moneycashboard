require_relative('../models/transaction.rb')
require_relative('../models/user.rb')
require_relative('../db/sql_runner.rb')
require('pry')

user_1 = User.new({
  'name' => 'Maggie',
  'budget' => 300
})

user_1.save()

transaction_1 = Transaction.new({
  'amount' => 200,
  'tag' => 'food',
  'shop' => 'tesco'
})

transaction_1.save()

binding.pry
nil
