Given /^the following carts:$/ do |carts|
  Cart.create!(carts.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) cart$/ do |pos|
  visit carts_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

And /^I select one image and add it to cart$/ do
  @cart =  Cart.new
  @cart.add_product(Asset.first(:assetable_type => "image"))
end

Then /^One item is add on the cart$/ do
 
end

Then /^I select  "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end


Then /^Cart item add to the cart$/ do
  
end

Then /^I follow "([^"]*)" with order id (\d+)$/ do |link, id|
   order = Order.get(1)
   order.paypal_url(store_desc_stores_path, 2010, order.name)
end

Then /^It will Follow paypal process$/ do
end


And /^It will save the order$/ do
  @cart =  Cart.new
  @cart.items << CartItem.new(Asset.first(:assetable_type => "image"))
#  @cart.add_product(Asset.first(:assetable_type => "image"))
  order= Order.new(:name => "Red R", :email => "producer@lostbets.com", :address => "Salt Lake City", :pay_type => "Check")
  order.add_line_items_from_cart(@cart)
  order.save
end


Then /^I redirect to the confirmation page$/ do
  visit  order_details_carts_path(:order => Order.first.id)
end

Then /^I should see the following carts:$/ do |expected_carts_table|
  expected_carts_table.diff!(tableish('table tr', 'td,th'))
end
