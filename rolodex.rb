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
end
