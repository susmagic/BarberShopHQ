require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
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

get '/contacts' do
    erb :contacts
end

post '/visit' do
    c = Client.new params[:client]
    c.save
    
    erb "<h2>Спасибо, Вы записались!</h2>"

end

post '/contacts' do
    @contact_name = params[:contact_name]
    @contact_phone = params[:contact_phone]

    contacts = Contact.new name: @contact_name, phone: @contact_phone
    contacts.save

    erb "<h2>Спасибо, Мы Вам перезвоним!</h2>"
end