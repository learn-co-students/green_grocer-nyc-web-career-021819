require "pry"

def consolidate_cart(cart)
  hash = {}
  count = 0
  cart.each do |grocery|
    grocery.each do |item, value|
        if hash[item]
          hash[item][:count] +=1
        else
          hash[item]= value
          hash[item][:count] = 1
        end
      end
    end
    hash
end

def apply_coupons(cart, coupons)
  hash = {}
  cart.each do |item, detail|
    coupons.each do |coupon|
      if item == coupon[:item] && detail[:count]>=coupon[:num]
        detail[:count]= detail[:count] - coupon[:num]
          if hash["#{item} W/COUPON"]
            hash["#{item} W/COUPON"][:count]+=1
          else
            hash["#{item} W/COUPON"]={price: coupon[:cost], clearance: detail[:clearance], count: 1}
          end
        end
      end
      hash[item] = detail
    end
    hash
end

def apply_clearance(cart)
  cart.each do |item, detail|
    if detail[:clearance] == true
      new_price = detail[:price]* 0.8
      detail[:price] = new_price.round(2)
    end
  end
  cart
end


def checkout(cart, coupons)
  total = 0

  cart1 = consolidate_cart(cart)
  coupon = apply_coupons(cart1,coupons)
  discount = apply_clearance(coupon)

  discount.each do |item, value|
  total += value[:price] * value[:count]
  if total > 100
    total= total* 0.9
  end
end
total
end
