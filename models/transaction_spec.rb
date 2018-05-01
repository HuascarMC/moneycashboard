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
   result = Transaction.all()
   assert_equal(1, result.count)
  end

  def test_total()
    result = Transaction.total()
    assert_equal('200', result)
  end

  def test_total_by_tag()
    result = Transaction.totaltag('food')
    assert_equal('200', result)
  end
end
