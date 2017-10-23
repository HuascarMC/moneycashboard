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

get '/transaction/:id/edit' do
  @transaction = Transaction.find(params[:id])
  erb(:edit)
end

post '/transaction/:id/edit' do
  Transaction.new(params).update()
  redirect to '/transaction/all'
end

get '/transaction/by_tag' do
  @tags = Transaction.alltags()
  erb(:by_tag)
end

post '/transaction/by_tag' do
  @tags = Transaction.alltags()
  @total = Transaction.totaltag(params['sum'])
  erb(:by_tag)
end
