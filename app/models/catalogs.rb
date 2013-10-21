module Catalogs
	KNOWN_CATALOGS = {
		'customers' => Catalogs::Customer,
		'organizations' => Catalogs::Organization
	}
	def self.table_name_prefix
		'catalogs_'
	end
	def self.initialize_self_from request_path
		str = request_path.split('/').reject {|i| i.empty? }.second
		(str.in? KNOWN_CATALOGS.keys) ? KNOWN_CATALOGS[str] : false
	end
	def self.catalog_path model_name, action
		str = KNOWN_CATALOGS.key model_name
		case action.to_s
		when 'new'
			"#{str}/new"
		end
	end
end