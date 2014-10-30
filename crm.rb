require 'sinatra'
require "sinatra/reloader" if development?
require './contact' 
require './rolodex'

$rolodex = Rolodex.new
$rolodex.add_contact(Contact.new("Super", "Man", "superman@email.com", "He\'s super"))

get '/' do 
	@crm_app_name = "Super Cool CRM"
	erb :index
end

get '/contacts' do 
	erb :contacts 
end

get '/contacts/1' do
	@contact = $rolodex.find(1)
	erb :show_contact
end

get '/contact/new' do 
	erb :new_contact
end

post '/contacts' do
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	$rolodex.add_contact(new_contact)
	redirect to('/contacts')
end
