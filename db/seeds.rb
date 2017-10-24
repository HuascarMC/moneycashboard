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
  'shop' => 'tesco',
  'user_id' => user_1.id
})

transaction_2 = Transaction.new({
  'amount' => 300,
  'tag' => 'clothes',
  'shop' => 'tesco',
  'user_id' => user_1.id
})

# transaction_1.save()
# transaction_2.save()

binding.pry
nil
