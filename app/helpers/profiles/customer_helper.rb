module Profiles::CustomerHelper
	def tr_class talon
		if (expires = talon.expires) < Time.now
			result = 'error'
		elsif (expires > Time.now) && ((expires - 1.month) < Time.now)
			result = 'warning'
		else
			result = 'success'
		end
		result
	end
	def expires talon 
		if (expires = talon.expires) < Time.now
			result = "талон просрочен %s" % (expires.strftime "%d/%m/%Y")
		elsif (expires > Time.now) && ((expires - 1.month) < Time.now)
			result = " %s срок действия заканчивается" % (expires.strftime "%d/%m/%Y")
		else
			result = (expires.strftime "%d/%m/%Y")
		end
		result
	end
end
