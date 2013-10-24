module Documents
	KNOWN_DOCUMENTS = [
		Documents::TalonsIssue,
		Documents::TalonsRepaid
	]
  def self.table_name_prefix
    'documents_'
  end
end
