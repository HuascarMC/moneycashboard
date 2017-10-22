require('minitest/autorun')
require_relative('transaction.rb')

class TestTransaction < MiniTest::Test

  def setup
    @transaction = Transaction.new({
      'amount' => 200,
      'tag' => 'food',
      'shop' => 'tesco'
    })
  end

  def test_save()
   assert_equal(1, @transaction.save())
  end

  def test_all()
   assert(1)
  end
end
