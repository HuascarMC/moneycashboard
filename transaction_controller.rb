require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')

require_relative('./models/transaction.rb')
require_relative('./models/user.rb')

get '/transaction' do
  @users = User.all()
  erb(:index)
end

post '/transaction' do
  @transaction = Transaction.new(params)
  @saved = @transaction.save()
  @user = User.find(@transaction)
  @user.subtract(@transaction)
  redirect to '/transaction'
end

get '/transaction/:id/all' do
  @users = User.all()
  erb(:all)
end

post '/transaction/:id/all' do
  @users = User.all()
  @user = User.find(params[:id])
  @transactions = @user.find_transactions()
  redirect to '/transaction/:id/all'
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

post '/transaction/:id/delete' do
  @transaction = Transaction.find(params[:id])
  @transaction.delete()
  redirect to '/transaction/all'
end

get '/transaction/new_user' do
  erb(:create)
end

post '/transaction/new_user' do
  @user = User.new(params)
  @user.save()
  redirect to '/transaction'
end
