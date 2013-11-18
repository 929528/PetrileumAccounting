class Catalogs::Promotion < ActiveRecord::Base
	has_attached_file :image, styles: {large:'x300',thumb: 'x180'}, default_url: "/assets/promotions/missing.png"
	validates :title, presence: true
	validates_attachment :image, presence: true,
	content_type: { content_type: "image/png" },
	size: { in: 0..10.megabytes }
end