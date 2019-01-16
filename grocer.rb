def consolidate_cart(cart)
	new_hash = {}
	cart.each do |items|
		items.each do |item, price_hash|
			if new_hash[item].nil?
				new_hash[item] = price_hash.merge({:count => 1})
			else
				new_hash[item][:count] += 1
			end
		end
	end
	new_hash
end

def apply_coupons(cart, coupons)
	new_hash = cart
	coupons.each do |coupon|
		item = coupon[:item]
		if !new_hash[item].nil? && new_hash[item][:count] >= coupon[:num]
			i = {"#{item} W/COUPON" => {:price => coupon[:cost], :clearance => new_hash[item][:clearance],:count => 1}}
			if new_hash["#{item} W/COUPON"].nil?
				new_hash.merge!(i)
			else
				new_hash["#{item} W/COUPON"][:count] += 1
			end
			new_hash[item][:count] -= coupon[:num]
		end
	end
	new_hash
end

def apply_clearance(cart)
	cart.each do |item, price_hash|
		if price_hash[:clearance] == true
			price_hash[:price] = (price_hash[:price] * 0.8).round(2)
		end
	end
	cart
end

def checkout(cart, coupons)
	cart_main = consolidate_cart(cart)
	cart_1 = apply_coupons(cart_main, coupons)
	cart_2 = apply_clearance(cart_1)

	total = 0

	cart_2.each do |item, price_hash|
		total += price_hash[:price] * price_hash[:count]
	end
	total > 100 ? total * 0.9 : total
end
