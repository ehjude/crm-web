class Rolodex
	attr_reader :contacts

	def initialize
		@contacts = []
		@index_id = 1
	end

	def add_contact(contact)
		contact.id = @index_id
		@contacts << contact 
		@index_id += 1
	end

	def find(contact_id)
		@contacts.find {|contact| contact.id == contact_id }
	end

	def remove_contact(contact)
		@contacts.delete(contact)
	end
end
