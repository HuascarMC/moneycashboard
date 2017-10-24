require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')

require_relative('./models/transaction.rb')
require_relative('./models/user.rb')

get '/transaction' do
  @users = User.all()
  if (@users.count() != 0)
    erb(:index)
  else
    redirect to '/transaction/new_user'
  end
end

post '/transaction' do
  @transaction = Transaction.new(params)
  @transaction.save()
  @user = User.findt(@transaction)
  @user.subtract(@transaction)
  redirect to '/transaction'
end

get '/transaction/all/:user' do
  @users = User.all()
  erb(:all)
end

post '/transaction/all/:user' do
  if @user = User.find(params[:id])
    @transactions = @user.find_transactions()
    @total = Transaction.total(@user.id)
    erb(:show)
  else
    redirect to '/transaction/all/:user'
  end
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
  @users = User.all()
  if @users.count() != 0
    @tags = Transaction.alltags()
    erb(:by_tag)
  else
    redirect to '/transaction/new_user'
  end
end

post '/transaction/by_tag' do
  @tags = Transaction.alltags()
  @total = Transaction.totaltag(params['sum'])
  erb(:by_tag)
end

post '/transaction/:id/delete' do
  @transaction = Transaction.find(params[:id])
  @transaction.delete()
  redirect to '/transaction/all/:user'
end

get '/transaction/new_user' do
  erb(:create)
end

post '/transaction/new_user' do
  @user = User.new(params)
  @user.save()
  redirect to '/transaction'
end
