namespace :db do
	desc "Initialize db"
	task init: :environment do
		org = Catalogs::Organization.new name: "ООО Белком", fullname: "Общество с ограниченной ответственностью \"Белком\""
		org.departments.build name: "Трактора"
		org.departments.build name: "Жуки"
		org.departments.build name: "Высокий"
		org.save!
		Catalogs::User.create!(name: "oleg", 
			password: "9700477", 
			password_confirmation: "9700477", 
			email: "929528@gmail.com",
			department: Catalogs::Department.find_by(name: 'Трактора'))
		Catalogs::Talons::State.create!(name: "new")
		Catalogs::Talons::State.create!(name: "issued")
		Catalogs::Talons::State.create!(name: "repaid")
		Catalogs::Talons::Amount.create!(value: 20, symbol: "2")
		Catalogs::Talons::Amount.create!(value: 5, symbol: "5")
		Catalogs::Product.create!(name: "А-92", fullname: "Бензин автомобильный А-92", symbol: "4")
		Catalogs::Product.create!(name: "А-95", fullname: "Бензин автомобильный А-95", symbol: "5")
		Catalogs::Product.create!(name: "Аб-92", fullname: "Биоэтанол автомобильный Аб-92", symbol: "3")
		Catalogs::Product.create!(name: "ДТ", fullname: "Топливо дизельное", symbol: "2")
		Catalogs::Product.create!(name: "Газ", fullname: "Газ углеводородный", symbol: "1")
		Catalogs::ContractType.create!(name: "Покупка-Продажа", freebie: false)
		Catalogs::ContractType.create!(name: "Внутренние расходы", freebie: true)
		Catalogs::ContractType.create!(name: "Внешние обязательства", freebie: false)
		Catalogs::Users::Role.create!(name: "Guest")
		Catalogs::Users::Role.create!(name: "Employee")
		p "ALL DONE !"
	end
end