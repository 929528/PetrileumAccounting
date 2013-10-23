module Documents
	KNOWN_DOCUMENTS = [
		Documents::TalonsIssue
	]
  def self.table_name_prefix
    'documents_'
  end
end
