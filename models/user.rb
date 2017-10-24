class User
  attr_reader :id
  attr_accessor :name, :budget

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @budget = options['budget'].to_i
  end
end
