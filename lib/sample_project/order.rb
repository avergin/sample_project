require "./lib/sample_project/sample_data"

module SampleProject
	# Order class initializes an order instance.
	# organization, organization_type, quantity and sales_price are attributes for this class.
	class Order
		attr_accessor :organization, :organization_type, :quantity, :sales_price

		def initialize(organization:, organization_type:, quantity:, sales_price:)
			@organization = organization
			@quantity = quantity
			@sales_price = sales_price
			@organization_type = organization_type
		end

		# Generates specified number of orders from specified deals and organizations
		def self.generate_random(order_count:, deals:, organizations:)
			orders = []

			100.times.each do |n|
				organization = organizations[rand(0..(organizations.length - 1))]
				quantity = rand(1..order_count)
				order = new(
					organization: organization, 
					quantity: quantity, 
					organization_type: organization.organization_type, 
					sales_price: organization.sales_price
				)
				orders << order
			end

			orders
		end

	end
end