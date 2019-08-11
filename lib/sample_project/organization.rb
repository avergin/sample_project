module SampleProject
	# Organization class initializes an organization instance.
	# name, organization_type and sales_price are attributes for this class.
	class Organization
		attr_accessor :name, :organization_type, :sales_price

		def initialize(name:, organization_type:, sales_price:)
			@name = name
			@organization_type = organization_type
			@sales_price = sales_price
		end

	end
end