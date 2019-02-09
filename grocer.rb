require "pry"

def consolidate_cart(cart)
  new_cart = {}
 cart.uniq.each do |unique_item|
   count = 0 
   cart.each do |item|
     if unique_item == item
       count +=1
     end
   end
   unique_item.each do |name, info|
     new_cart[name] = info
     new_cart[name][:count] = count
   end
  end
 new_cart
end

def apply_coupons(cart, coupons)
  new_cart = {}
  cart.each do |name, info|
    if cart[name] == coupons[:item]
      binding.pry
    end
    end
  end
  new_cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
