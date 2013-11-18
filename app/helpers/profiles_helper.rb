module ProfilesHelper
	def progress_bar talon 
		exp = (talon.expires.to_datetime - DateTime.now).to_i
		return (exp / (talon.contract.validity.to_f / 100)).to_i
	end
end