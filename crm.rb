require 'sinatra'
require "sinatra/reloader" if development? 
require_relative 'rolodex'
require 'better_errors'
require 'data_mapper'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
	include DataMapper::Resource

	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :email, String
	property :note, String
end

DataMapper.finalize
DataMapper.auto_upgrade!


$rolodex = Rolodex.new
$rolodex.add_contact(Contact.new("Super", "Man", "superman@email.com", "He\'s super"))

get '/' do 
	@crm_app_name = "Super Cool CRM"
	erb :index
end

get '/contacts' do 
	erb :contacts 
end

# VIEW NEW CONTACT PAGE
get '/contact/new' do 
	erb :new_contact
end

# SHOW CONTACT
get '/contacts/:id' do
	@contact = $rolodex.find(params[:id].to_i)
	if @contact
		erb :show_contact
	else
		raise Sinatra::NotFound
	end
end

# EDIT CONTACT
get '/contacts/:id/edit' do
	@contact = $rolodex.find(params[:id].to_i)
	if @contact
		erb :edit_contact
	else
		raise Sinatra::NotFound
	end
end

# CREATE NEW CONTACT
post '/contacts' do
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	$rolodex.add_contact(new_contact)

	redirect to('/contacts')
end

# UPDATE CONTACT
put '/contacts/:id' do
	@contact = $rolodex.find(params[:id].to_i)
	if @contact
		@contact.first_name = params[:first_name]
		@contact.last_name = params[:last_name]
		@contact.email = params[:email]
		@contact.email = params[:note]

		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end

# DELETE CONTACT
delete '/contacts/:id' do
	@contact = $rolodex.find(params[:id].to_i)
	if @contact
		$rolodex.remove_contact(@contact)
		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end




