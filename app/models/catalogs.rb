module Catalogs
	KNOWN_CATALOGS = [
		Catalogs::Customer,
		Catalogs::Organization,
		Catalogs::Product,
		Catalogs::User
	]
	def self.table_name_prefix
		'catalogs_'
	end
end