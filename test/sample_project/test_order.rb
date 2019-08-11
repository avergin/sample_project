require "./test/test_helper"
require "./lib/sample_project/order"

class TestOrder < Minitest::Test
	def setup
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

		@random_orders = SampleProject::Order.generate_random(order_count: 100, deals: @deals, organizations: @organizations)

		@orders = []
		@orders << SampleProject::Order.new(organization: @organizations[0], quantity: 100, organization_type: @organizations[0].organization_type, sales_price: @organizations[0].sales_price)
		@orders << SampleProject::Order.new(organization: @organizations[1], quantity: 1000, organization_type: @organizations[1].organization_type, sales_price: @organizations[1].sales_price)
		@orders << SampleProject::Order.new(organization: @organizations[2], quantity: 1200, organization_type: @organizations[2].organization_type, sales_price: @organizations[2].sales_price)
		@orders << SampleProject::Order.new(organization: @organizations[3], quantity: 300, organization_type: @organizations[3].organization_type, sales_price: @organizations[3].sales_price)
		@orders << SampleProject::Order.new(organization: @organizations[4], quantity: 100, organization_type: @organizations[4].organization_type, sales_price: @organizations[4].sales_price)
		@orders << SampleProject::Order.new(organization: @organizations[5], quantity: 200, organization_type: @organizations[5].organization_type, sales_price: @organizations[5].sales_price)

	end

	def test_order_is_initialized
		order = @orders[0]
		assert_equal order.organization.name, "Direct Sales Company"
		assert_equal order.quantity, 100
		assert_equal order.sales_price, 100
		assert_equal order.organization_type, :direct
	end

	def test_order_count
		assert_equal @orders.count, 6
	end

	def test_randomly_generated_order_count
		assert_equal @random_orders.count, 100
	end

end