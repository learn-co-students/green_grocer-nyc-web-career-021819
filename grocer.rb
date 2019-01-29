require "pry"

def consolidate_cart(cart)
  # code here
  hash = {}
  cart.each do |list|
    list.each do |item, attributes|
      if hash.has_key?(item) == false
        hash[item] = attributes
        hash[item][:count] = 1
      else
        hash[item][:count] += 1
      end
    end
  end
hash
end

def apply_coupons(cart, coupons)
  # code here
hash = {}
  cart.to_a.each do |item, attributes|
    coupons.to_a.each do |coupon|
      if item == coupon[:item] && attributes[:count] >= coupon[:num]
        attributes[:count] = attributes[:count] - coupon[:num]
        if hash.has_key?("#{item} W/COUPON")
          hash["#{item} W/COUPON"][:count] += 1
        else
          hash["#{item} W/COUPON"] = {:price => coupon[:cost],
            :clearance => attributes[:clearance],
            :count => 1}
      end
    end
  end
  hash[item] = attributes
  end
  hash
end

def apply_clearance(cart)
  # code here
  cart.each do |item, attributes|
      if attributes[:clearance] == true
        attributes[:price] = (attributes[:price]*0.80).round(2)
      end
    end
    cart
  end

def checkout(cart, coupons)
  # code here
  cart1 = consolidate_cart(cart)
  cart2 = apply_coupons(cart1, coupons)
  cart3 = apply_clearance(cart2)
  cost = 0
  cart3.each do |item, attributes|
    cost += (attributes[:price]* attributes[:count])
  end
    if cost > 100
      cost = (cost*0.90).round(2)
    end
  cost
end
