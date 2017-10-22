require_relative('../models/transaction.rb')
require_relative('../db/sql_runner.rb')
require('pry')

transaction_1 = Transaction.new({
  'amount' => 200,
  'tag' => 'food',
  'shop' => 'tesco'
})

transaction_1.save()

binding.pry
nil
