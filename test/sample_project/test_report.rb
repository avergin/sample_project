require "./test/test_helper"
require "./lib/sample_project/report"
require "./lib/sample_project/organization"
require "./lib/sample_project/deal"

class TestReport < Minitest::Test
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

		@orders = []
		@orders << SampleProject::Order.new(organization: @organizations[0], quantity: 100, organization_type: @organizations[0].organization_type, sales_price: @organizations[0].sales_price)
		@orders << SampleProject::Order.new(organization: @organizations[1], quantity: 1000, organization_type: @organizations[1].organization_type, sales_price: @organizations[1].sales_price)
		@orders << SampleProject::Order.new(organization: @organizations[2], quantity: 1200, organization_type: @organizations[2].organization_type, sales_price: @organizations[2].sales_price)
		@orders << SampleProject::Order.new(organization: @organizations[3], quantity: 300, organization_type: @organizations[3].organization_type, sales_price: @organizations[3].sales_price)
		@orders << SampleProject::Order.new(organization: @organizations[4], quantity: 100, organization_type: @organizations[4].organization_type, sales_price: @organizations[4].sales_price)
		@orders << SampleProject::Order.new(organization: @organizations[5], quantity: 200, organization_type: @organizations[5].organization_type, sales_price: @organizations[5].sales_price)

		@order_summary = SampleProject::Report.order_summary(orders: @orders, deals: @deals)
	end

	def test_order_summary_lines_count
		assert_equal @order_summary.count, 6
	end

	def test_total_revenue_report
		revenue = (100*100 + 1000*75 + 1200*65 + 300*80 + 100*75 + 200*85)
		assert_equal SampleProject::Report.get_total_revenue(@order_summary), revenue
	end

	def test_total_bill_to_be_paid_report
		a_company_bill = (1000*50)
		another_company_bill = (1200*40)
		resell_this_bill = (100*50)
		
		bill_amount_per_organization = SampleProject::Report.get_total_bill_amount_by_organization(@order_summary)

		assert_equal bill_amount_per_organization.count, 5
		assert_equal bill_amount_per_organization.find{ |i| i[:organization] == "A Company" }[:total_cost], a_company_bill
		assert_equal bill_amount_per_organization.find{ |i| i[:organization] == "Another Company" }[:total_cost], another_company_bill
		assert_equal bill_amount_per_organization.find{ |i| i[:organization] == "Resell This" }[:total_cost], resell_this_bill
	end

	def test_total_profit_report
		a_company_bill = (1000*50)
		a_company_revenue = (1000*75)
		a_company_profit = a_company_revenue - a_company_bill

		total_profit_per_organization = SampleProject::Report.get_total_profit_earned_by_partners(@order_summary)

		assert_equal total_profit_per_organization.count, 5
		assert_equal total_profit_per_organization.find{ |i| i[:organization] == "A Company" }[:total_profit], a_company_profit

	end

end