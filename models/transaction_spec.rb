require('minitest/autorun')
require_relative('transaction.rb')

class TestTransaction < MiniTest::Test
  def setup
    @transaction = Transaction.new({
      'amount' => 200,
      'tag' => 'food',
      'shop' => 'tesco',
      'user_id' => '1'
    })
  end

  def test_save()
   assert_equal(4, @transaction.save())
  end

  def test_all()
   result = Transaction.all()
   assert_equal(3, result.count)
  end

  def test_total()
    result = Transaction.total()
    assert_equal(nil, result)
  end

  def test_total_by_tag()
    result = Transaction.totaltag('food')
    assert_equal("600", result)
  end
end
