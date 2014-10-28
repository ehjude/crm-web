require 'sinatra'
require './contact' 
require './rolodex'


get '/' do 
	@crm_app_name = "My CRM"
	erb :index
end

get '/contacts' do 
	@contacts = []
	@contacts << Contact.new("Jude", "Fiorillo", "boss@youdaboss.com", "Chief Dude")

	erb :contacts
end

get '/contacts/new' do 
end

