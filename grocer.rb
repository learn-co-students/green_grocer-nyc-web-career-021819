require 'pry'
def items
	[
		{"AVOCADO" => {:price => 3.00, :clearance => true}},
		{"KALE" => {:price => 3.00, :clearance => false}},
		{"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
		{"ALMONDS" => {:price => 9.00, :clearance => false}},
		{"TEMPEH" => {:price => 3.00, :clearance => true}},
		{"CHEESE" => {:price => 6.50, :clearance => false}},
		{"BEER" => {:price => 13.00, :clearance => false}},
		{"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
		{"BEETS" => {:price => 2.50, :clearance => false}}
	]
end

def coupons
	[
		{:item => "AVOCADO", :num => 2, :cost => 5.00},
		{:item => "BEER", :num => 2, :cost => 20.00},
		{:item => "CHEESE", :num => 3, :cost => 15.00}
	]
end

def consolidate_cart(cart)
  # code here
  newcart ={}
  cart.each do |items|
    items.each do |item, vals|
      if newcart.has_key?(item)
        newcart[item][:count] += 1
      else
        newcart[item] = vals
        newcart[item][:count] = 1
      end
    end
  end
  newcart
end

def apply_coupons(cart, coupons)
  # code here
  #have to check if count equals zero when removing from it
  newcart = cart
  coupons.each do |coupon|
    if newcart.has_key?(coupon[:item])
      if newcart[(coupon[:item])][:count] >= coupon[:num]
        if newcart.has_key?("#{coupon[:item]} W/COUPON")
          newcart["#{coupon[:item]} W/COUPON"][:count] +=1
          newcart[(coupon[:item])][:count] = newcart[(coupon[:item])][:count] - coupon[:num]
        else
        newcart["#{coupon[:item]} W/COUPON"] =
          {:price => coupon[:cost],
          :clearance => newcart[(coupon[:item])][:clearance],
          :count => 1}
        newcart[(coupon[:item])][:count] = newcart[(coupon[:item])][:count] - coupon[:num]
        #if newcart[(coupon[:item])][:count] < 1
        #  newcart.delete((coupon[:item]))
        #end
      end
      end
    end
  end
  newcart
end

def apply_clearance(cart)
  # code here
	cart.each do |key, keyvals|
		if keyvals[:clearance]
			keyvals[:price] = keyvals[:price] - ((0.2)*keyvals[:price])
		end
	end
end

def checkout(cart, coupons)
  # code here
	clearcart = apply_clearance(apply_coupons(consolidate_cart(cart),coupons))
	total = 0
	clearcart.each do |item,keyvals|
		total += (keyvals[:price]*keyvals[:count])
	end
	if total > 100
		total = total - (total*0.1)
	end
	total
end

checkout(items,coupons)
