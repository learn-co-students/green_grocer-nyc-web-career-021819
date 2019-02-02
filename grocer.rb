#[
#  {"AVOCADO" => {:price => 3.00, :clearance => true}},
#  {"KALE" => {:price => 3.00, :clearance => false}},
#  {"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
#  {"ALMONDS" => {:price => 9.00, :clearance => false}},
#  {"TEMPEH" => {:price => 3.00, :clearance => true}},
#  {"CHEESE" => {:price => 6.50, :clearance => false}},
#  {"BEER" => {:price => 13.00, :clearance => false}},
#  {"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
#  {"BEETS" => {:price => 2.50, :clearance => false}},
#  {"SOY MILK" => {:price => 4.50, :clearance => true}}
#]


def consolidate_cart(cart)
  cons_cart = {}
  cart.each do |element|
    element.each do |item, data|
      if cons_cart.include?(item) != true
        cons_cart[item] = data
        cons_cart[item][:count] = 1
      else
        cons_cart[item][:count] += 1
      end
    end
  end
  return cons_cart
end

def apply_coupons(cons_cart, coupons)
  #create new hash to stpore new values, may not need the if statement there, may need to place it elsewhere
  if coupons != []
    new_hash = {}
    cons_cart.each do |key, value|
      new_hash[key] = value
    end
  end

#Imagine multiple coupons as: [{:item => "AVOCADO", :num => 2, :cost => 5.0}, {}]

  #guard against no coupons
  if coupons == []
    return cons_cart
  else
  coupons.each do |element|
    #search for item to see if in both coupons and cart
    #if to keep from breaking if coupon doesn't apply
    if cons_cart.include?(element[:item]) == false
      return cons_cart
    else
      #make sure cart count is > coupon count
      cons_cart.each do |c_item, c_data|
        #if coupon not in cart, do not modify
        if element[:item] == c_item
          #make sure cart count is > coupon count
          if element[:num] <= c_data[:count]
            #Not first time coupon, just incremenet and decremeent appropr values
            if new_hash.include?("#{element[:item]} W/COUPON") == true
              #incremenet coupon row
              new_hash["#{element[:item]} W/COUPON"][:count] = new_hash["#{element[:item]} W/COUPON"][:count] + 1
              #decremement non coupon row
              new_hash["#{element[:item]}"][:count] = new_hash["#{element[:item]}"][:count] - element[:num]
            else
              #  "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
              #For first time coupon, add new section to hash, decremement non coupon row
              new_hash["#{element[:item]} W/COUPON"] = {:price =>element[:cost], :clearance => c_data[:clearance], :count => 1}
              new_hash["#{element[:item]}"][:count] = new_hash["#{element[:item]}"][:count] - element[:num]
            end
          else
          end
        end
      end
    end
  end
  return new_hash
end
end

def apply_clearance(cons_cart)

  #create new cart to store new prices
  clearance = 0.80
  new_hash = {}
  cons_cart.each do |key, value|
    new_hash[key] = value

  end
  #search cart for clearance items
  cons_cart.each do |c_item, c_data|
      if c_data[:clearance] == false
      else
        new_hash[c_item][:price] = c_data[:price].to_f.round(2) * clearance.to_f.round(2)
        new_hash[c_item][:price] = new_hash[c_item][:price].round(2)
      end
  end 
  return new_hash
end

def checkout(cart, coupons)
  cart_total = 0
  cons_cart = consolidate_cart(cart)

  #Apply coupons
  post_coupon_cart = apply_coupons(cons_cart, coupons)

  #Apply clearance
  post_clearance_cart = apply_clearance(post_coupon_cart)

  #Calculate cart total price
  post_clearance_cart.each do |c_item, c_data|
    cart_total += c_data[:count] * c_data[:price]
  end

  #If total price <= $100, return cart, else return discount
  if cart_total <= 100
    return cart_total
  else
    cart_total = cart_total * 0.9
    return cart_total
  end



end
