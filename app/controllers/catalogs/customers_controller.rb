class Catalogs::CustomersController < CatalogsController
	respond_to :html, :json
	def index
		super Catalogs::Customer
	end
	def new
		@customer = Catalogs::Customer.new.tap {|customer| customer.contracts.build name: 'Основной договор'}
		render 'new'
	end
	def create
		@customer = Catalogs::Customer.new customer_params
		if @customer.save
			flash.now[:success] = "Клиент: #{@customer.name} создан!"
			super @customer
		else
			super @customer, errors = true
		end
	end
	def edit
		@customer = Catalogs::Customer.find params[:id]
		render 'edit'
	end
	def update
		@customer = Catalogs::Customer.find params[:id]
		if @customer.update_attributes customer_params
			flash.now[:success] = "Клиент: #{@customer.name} обновлен!"
			render 'update'
		else
			render partial: 'errors', locals: {item: @customer}
		end
	end
	def new_contract
		contract = Catalogs::Contract.new name: 'Новый договор'
		@id = Time.now.to_i
		render partial: 'add_tab', locals: {item: contract}
	end
	def get_contracts
		customer = Catalogs::Customer.find_by_name params[:name]
		contracts = customer.contracts.load
		respond_with contracts
	end
	private

	def customer_params
		params.require(:customer).permit [
			:name, 
			:fullname, 
			contracts_attributes: [
				:id, 
				:contract_type_id, 
				:validity, 
				:name, 
				:def
				],
				discounts_attributes: [
					:id,
					:value,
					:customer_id,
					:product_id,
					:_destroy
				]
			]
		end
	end