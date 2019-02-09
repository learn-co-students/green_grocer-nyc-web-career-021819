def consolidate_cart(cart)
  cart.each_with_object({}) do |item, result|
    item.each do |type, attributes|
      if result[type]
        attributes[:count] += 1
      else
        attributes[:count] = 1
        result[type] = attributes
      end
    end
  end
end


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
      name = coupon[:item]
      if cart[name] && cart[name][:count] >= coupon[:num]
        if cart["#{name} W/COUPON"]
          cart["#{name} W/COUPON"][:count] += 1
        else
          cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
          cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
        end
        cart[name][:count] -= coupon[:num]
      end
    end

    cart
end

def apply_clearance(cart)
  cart.each do |name, values|
      if values[:clearance]
        updated_price = values[:price] * 0.80
        values[:price] = updated_price.round(2)
      end
    end
    cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupon_price = apply_coupons(consolidated_cart, coupons)
  final_price = apply_clearance(coupon_price)
  total = 0
  final_price.each do |name, values|
    total += values[:price] * values[:count]
  end
  total = total * 0.9 if total > 100
  total
end
