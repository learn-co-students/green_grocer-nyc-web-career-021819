def consolidate_cart(cart)
  cart.each_with_object({}) do |item, value|
    item.each do |vegetable, info|
      if value[vegetable]
        info[:count] += 1                      #adding 1 to counter of count hash
      else
        info[:count] = 1                        #if count still 1
        value[vegetable] = info                        
      end
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|                            #iterate coupons
    item = coupon[:item]                              #setting item equal to hash with value :item
    if cart.include?(item)                            #is item included in cart
      if cart[item][:count] >= coupon[:num]           
        cart["#{item} W/COUPON"] = {                  #new array with item applied with coupon
          :price => coupon[:cost],                    
          :clearance => cart[item][:clearance],
          :count => cart[item][:count] / coupon[:num]
        }
        cart[item][:count] = cart[item][:count] % coupon[:num]
        end
      end
   end
   return cart
end	


def apply_clearance(cart)
  cart.each do |key, value|
    if value[:clearance] == true                  #check to see if value for clearance is true
      clearance_applied = value[:price] * 0.8    #deduct 20% for clearnace
      value[:price] = clearance_applied.round(2)          #round back up the number
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated = consolidate_cart(cart)             #shortening the method
  couponed = apply_coupons(consolidated, coupons)   #applying arguement of prev method to coupons
  clearanced = apply_clearance(couponed)            #applying couponed method to clearance
  
    total = 0
    
    clearanced.each do |key, value|               #after all methods are applied, iterate
      total += value[:price] * value[:count]      # price * count = total price
    end
    total = total * 0.9 if total > 100            #apply 10% discount if total is more than 100
    return total
end










