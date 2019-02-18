def consolidate_cart(cart)
  # code here
  
  new_hash={}
  cart.each do |hash|
    hash.each do |key,value|
      if !new_hash.has_key?(key)
        new_hash[key]=value
        value[:count]=1
      elsif new_hash.has_key?(key)
        value[:count]+=1
      end
    end
end
return new_hash
end

def apply_coupons(cart, coupons)
  # code here
  
  new_hash={}
  cart.each do|key,value|
     new_hash[key]=value
    coupons.each do|each|
# nested if statements here
    if key == each[:item] && new_hash[key][:count] >= each[:num]
    new_hash[key][:count] -= each[:num] 
      if new_hash["#{key} W/COUPON"]
       new_hash["#{key} W/COUPON"][:count]+=1
      else
        new_hash["#{key} W/COUPON"]={}
        new_hash["#{key} W/COUPON"][:price]=each[:cost]
        new_hash["#{key} W/COUPON"][:clearance]=value[:clearance]
        new_hash["#{key} W/COUPON"][:count] = 1
    end
  end
end
end
 return new_hash
end

def apply_clearance(cart)
  # code here
  
  cart.each do |name, properties|
    if properties[:clearance]
      updated_price = properties[:price] * 0.80
      properties[:price] = updated_price.round(2)
    end
  end
  return cart
end

def checkout(cart, coupons)
  # code here
  
  consolidated_cart = consolidate_cart(cart)
  discounted_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(discounted_cart)
  total = 0
  final_cart.each do |item, data|
    total += data[:price] * data[:count]
  end
  total = total * 0.9 if total > 100
  return total
end
