require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')

require_relative('./models/transaction.rb')

get '/transaction' do
  erb(:index)
end

post '/transaction' do
  @transaction = Transaction.new(params)
  @transaction.save()
  redirect to '/transaction'
end

get '/transaction/all' do
  @transactions = Transaction.all()
  @total = Transaction.total()
  erb(:all)
end

get '/transaction/by_tag' do
  @transactions = Transacation.totaltag(params)
  erb(:by_tag)
end
