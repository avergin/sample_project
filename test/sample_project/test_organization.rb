require "./test/test_helper"
require "./lib/sample_project/organization"

class TestOrganization < Minitest::Test
	def setup
		@organization1 = SampleProject::Organization.new(name: "Test Org", organization_type: :affiliate, sales_price: 10)
	end

	def test_organization_is_initialized
		assert_equal @organization1.name, "Test Org"
		assert_equal @organization1.organization_type, :affiliate
		assert_equal @organization1.sales_price, 10
	end

end