class Profiles::CustomerController < ApplicationController
	def show 
		@user = current_user
		customer = current_user
		@talons = Catalogs::Talon.customer(customer).includes(:product, :amount)
		@issues = Documents::Actions::Talons::Issue.customer(customer).includes(talon: [:product, :amount]).includes(talons_issue: :contract).order('created_at DESC').last(20)
		@repaids = Documents::Actions::Talons::Repaid.customer(customer).includes(talon: [:product, :amount]).order('created_at DESC').last(20)
		@products = Catalogs::Product.joins(talons: [:product, :amount]).where(catalogs_talons: {contract_id: customer.contract_ids}).select('catalogs_products.name, SUM(value) liters, COUNT(catalogs_talons.id) talons_count').group('catalogs_products.name').load

	end
end