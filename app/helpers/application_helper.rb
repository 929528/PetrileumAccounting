module ApplicationHelper
	include SessionsHelper
	def full_title page_title
		title = 'Учет нефтепродуктов корпорации ХАДО'
		page_title.empty? ? title : "#{title} | #{page_title}"
	end
end
