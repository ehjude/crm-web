require 'sinatra'
require './contact' 
require './rolodex'

$rolodex = Rolodex.new

get '/' do 
	@crm_app_name = "My CRM"
	erb :index
end

get '/contacts' do 
	erb :contacts
end

