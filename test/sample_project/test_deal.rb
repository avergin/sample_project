require "./test/test_helper"
require "./lib/sample_project/deal"

class TestDeal < Minitest::Test
	def setup
		@deal1 = SampleProject::Deal.new(organization_type: :reseller, unit_cost: 50)
	end

	def test_deal_is_initialized
		assert_equal @deal1.organization_type, :reseller
		assert_equal @deal1.unit_cost, 50
	end

end