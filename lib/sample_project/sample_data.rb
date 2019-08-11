require "./lib/sample_project/organization"
require "./lib/sample_project/deal"

module SampleProject
	# SampleData class initializes aforementioned deals and organizations
	# in memory without a persistance layer.
	class SampleData
			attr_accessor :deals, :organizations

			def initialize()
				direct = :direct
				affiliate = :affiliate
				reseller = :reseller

				@organizations = []
				@organizations << SampleProject::Organization.new(name: "Direct Sales Company", organization_type: direct, sales_price: 100)
				@organizations << SampleProject::Organization.new(name: "A Company", organization_type: affiliate, sales_price: 75)
				@organizations << SampleProject::Organization.new(name: "Another Company", organization_type: affiliate, sales_price: 65)
				@organizations << SampleProject::Organization.new(name: "Even More Company", organization_type: affiliate, sales_price: 80)
				@organizations << SampleProject::Organization.new(name: "Resell This", organization_type: reseller, sales_price: 75)
				@organizations << SampleProject::Organization.new(name: "Sell More Things", organization_type: reseller, sales_price: 85)

				@deals = []
				@deals << SampleProject::Deal.new(organization_type: reseller, unit_cost: 50)
				@deals << SampleProject::Deal.new(organization_type: affiliate, unit_cost: 60, min_quantity: 0, max_quantity: 500)
				@deals << SampleProject::Deal.new(organization_type: affiliate, unit_cost: 50, min_quantity: 501, max_quantity: 1000)
				@deals << SampleProject::Deal.new(organization_type: affiliate, unit_cost: 40, min_quantity: 1001, max_quantity: nil)
			end
	end
end