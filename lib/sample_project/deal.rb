module SampleProject
	# Deal class initializes a deal instance.
	# organization_type, unit_cost and min_quantity and max_quantity are attributes for this class.
	class Deal
			attr_accessor :organization_type, :unit_cost, :min_quantity, :max_quantity

			def initialize(organization_type:, unit_cost:, min_quantity: nil, max_quantity: nil)
				@organization_type = organization_type
				@unit_cost = unit_cost
				@min_quantity = min_quantity
				@max_quantity = max_quantity
			end
	end
end