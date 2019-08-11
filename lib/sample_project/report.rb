module SampleProject
	# Report module summarizes the order and generates and
	# generates billing, profit and revenue reports.
	module Report
		# Generates an order summary from orders and deals
		def self.order_summary(orders:, deals:)
			summary = []

			orders.each do |order|
				if summary.any? { |s| s[:organization].name == order.organization.name }
					summary_line = summary.detect { |s| s[:organization].name == order.organization.name }
					summary_line[:quantity] += order.quantity
				else
					summary_line = {
						organization: order.organization,
						organization_type: order.organization.organization_type,
						quantity: order.quantity,
						sales_price: order.organization.sales_price,
						total_revenue: nil,
						total_cost: nil,
						unit_cost: nil,
						total_profit: nil
					}
					summary << summary_line
				end
			end

			summary.each do |s|
				calculate_unit_cost(line: s, deals: deals)
				calculate_total_cost(line: s)
				calculate_total_revenue(line: s)
				calculate_total_profit(line: s)
			end

			summary
		end

		# Calculates and returns the total bill to be paid to 
		# each `:affiliate` and `:reseller` organization in an array.
		def self.get_total_bill_amount_by_organization(order_summary)
			order_summary.select{ |o| o[:organization_type] != :direct }.map{|h| {organization: h[:organization].name, total_cost: h[:total_cost]}}
		end

		# Calculates and returns total profit earned by 
		# partner organizations (`affiliate` or `reseller`)
		# as an array consisting of organizations.
		def self.get_total_profit_earned_by_partners(order_summary)
			order_summary.select{ |o| o[:organization_type] != :direct }.map{|h| {organization: h[:organization].name, total_profit: h[:total_profit]}}
		end

		# Calculates and returns the total revenue from order summary array.
		def self.get_total_revenue(order_summary)
			order_summary.inject(0) { |sum, summary_line| sum + summary_line[:total_revenue] }
		end

		private

		# Calculates the cost of monthly orders.
		# Cost is fixed for resellers.
		# For affiliate organizations, the cost depends on the number of widgets sold per month.
		def self.calculate_unit_cost(line:, deals:)
			affiliate_deals = deals.select { |d| d.organization_type == :affiliate }
			reseller_deal = deals.find { |d| d.organization_type == :reseller }
			line[:unit_cost] = 
				case line[:organization_type]
				when :reseller
					reseller_deal.unit_cost
				when :affiliate
					deal = affiliate_deals.find{ |d| (d.min_quantity <= line[:quantity] && d.max_quantity == nil) || (d.min_quantity <= line[:quantity] && d.max_quantity >= line[:quantity]) }
					deal.unit_cost
				end
		end

		# Calculates the revenue per organization by multiplying 
		# `quantity` and `sales_price` in order summary line.
		def self.calculate_total_revenue(line:)
			line[:total_revenue] = line[:quantity] * line[:sales_price]
		end

		# Calculates the total cost per organization
		# by multiplying `unit_cost` and `quantity` in order summary line
		# if the organization_type is not `:direct`.
		def self.calculate_total_cost(line:)
			line[:total_cost] = (line[:organization_type] != :direct ? line[:unit_cost] * line[:quantity] : nil)
		end

		# Calculates the total profit per organization
		# by multiplying `total_revenue` and `total_cost` in order summary line
		# if the organization_type is not `:direct`.
		def self.calculate_total_profit(line:)
			line[:total_profit] = (line[:organization_type] != :direct ? line[:total_revenue] - line[:total_cost] : nil)
		end

	end
end