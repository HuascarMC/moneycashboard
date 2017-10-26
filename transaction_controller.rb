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
  @transactions = Transaction.all()
  if @users.count > 0 && @transactions.count > 0
    erb(:all)
  elsif @users.count > 0 && @transactions.count == 0
    redirect to '/transaction'
  else
    redirect to '/transaction/new_user'
  end
end

get '/transaction/all' do
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
  redirect to '/transaction/all/:user'
end

get '/transaction/search/:id' do
  @users = User.all()
  @tags = Transaction.alltags()
  if @users.count() != 0 && @tags.count() != 0
    erb(:by_tag)
  elsif @users.count() != 0 && @tags.count() == 0
    redirect to '/transaction'
  else
    redirect to '/transaction/new_user'
  end
end

get '/transaction/search' do
  @tags = Transaction.alltags()
  @total = Transaction.totaltag(params['sum'])
  erb(:by_tag)
end

get '/transaction/search' do
  @dates = Transaction.dates()
  @total = Transaction.totaldate(params['sum'])
  erb(:by_tag)
end

post '/transaction/:id/delete' do
  @transaction = Transaction.find(params[:id])
  @transaction.delete()

  redirect to "/transaction/all?id=#{@transaction.user_id.to_s}"
end

get '/transaction/new_user' do
  erb(:create)
end

post '/transaction/new_user' do
  @user = User.new(params)
  @user.save()
  redirect to '/transaction'
end
