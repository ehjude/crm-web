require 'sinatra'
require "sinatra/reloader" if development? 
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

get '/' do 
	@crm_app_name = "Super Cool CRM"
	erb :index
end

# SHOW CONTACTS PAGE
get '/contacts' do 
	@contacts = Contact.all
	erb :contacts 
end

# VIEW NEW CONTACT PAGE
get '/contact/new' do 
	erb :new_contact
end

# SHOW CONTACT
get '/contacts/:id' do
	@contact = Contact.get(params[:id].to_i)
	if @contact
		erb :show_contact
	else
		raise Sinatra::NotFound
	end
end

# EDIT CONTACT
get '/contacts/:id/edit' do
	@contact = Contact.get(params[:id].to_i)
	if @contact
		erb :edit_contact
	else
		raise Sinatra::NotFound
	end
end

# CREATE NEW CONTACT
post '/contacts' do 
	contact = Contact.create(
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:email],
		:note => params[:note]
	)

	redirect to('/contacts')
end

# UPDATE CONTACT
put '/contacts/:id' do
	@contact = Contact.get(params[:id].to_i)
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
	@contact = Contact.get(params[:id].to_i)
	if @contact
		@contact.destroy
		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end




