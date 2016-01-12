require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

before do
    @barbers = Barber.all
end

get '/' do
	erb :index
end

get '/visit' do
    erb :visit
end

post '/visit' do
    @username = params[:username]
    @phone = params[:phone]
    @datetime = params[:datetime]
    @barber = params[:barber]
    @color = params[:color]

    hh = { username: 'Введите имя',
           phone: 'Введите телефон',
           datetime: 'Введите дату и время' }
    #для каждой пары ключ-значение
    @error = hh.select {|key,_| params[key] == ""}.values.join(", ")

    if @error != ''
      return erb :visit
    end

    clients = Client.new name: @username, phone: @phone, datestamp: @datetime, barber: @barber, color: @color
    clients.save

    erb "<h2>Спасибо, Вы записались!</h2>"

end