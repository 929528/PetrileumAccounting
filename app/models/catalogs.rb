module Catalogs
	KNOWN_CATALOGS = {
		'customers' => Catalogs::Customer
	}
	def self.table_name_prefix
		'catalogs_'
	end
	def self.initialize_self_from request_path
		str = request_path.split('/').reject {|i| i.empty? }.second
		(str.in? KNOWN_CATALOGS.keys) ? KNOWN_CATALOGS[str] : false
	end
end