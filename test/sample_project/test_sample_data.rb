require "./test/test_helper"
require "./lib/sample_project/sample_data"

class TestSampleData < Minitest::Test
	def setup
		@data = SampleProject::SampleData.new()
	end

	def test_sample_data_organizations_count
		assert_equal @data.organizations.count, 6
	end

	def test_sample_data_deals_count
		assert_equal @data.deals.count, 4
	end

end