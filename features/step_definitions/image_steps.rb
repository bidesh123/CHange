Given /^the following images:$/ do |images|
  Image.create!(images.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) image$/ do |pos|
  visit images_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I upload one image file "([^"]*)"$/ do |arg1|
  
end

Then /^It will upload it and also save it$/ do
 
  image=Image.create!(:source_file_name => "pic.jpg", :source_file_size => File.new("pic.jpg").size, :source_content_type => File.extname("pic.jpg"), :source_updated_at => Time.now)
  

end

Then /^Asset table also updated$/ do
  if Store.first.nil?
    store=Factory(:store)
  end
  if Image.first.nil?
     image=Image.create!(:source_file_name => "pic.jpg", :source_file_size => File.new("pic.jpg").size, :source_content_type => File.extname("pic.jpg"), :source_updated_at => Time.now)
  end
  Asset.create!(:assetable_id => Image.first.id, :store_id => Store.first.id, :assetable_type => "image", :price => 212)
end

Given /^I visit to the edit image path of "([^"]*)"$/ do |image|
   Image.find(:source_file_name => image)
  visit path_to("the edit image path")
end


Then /^I upload a new image "([^"]*)"$/ do |arg1|
  
  Image.first.update(:source_file_name => "pic2.jpg", :source_file_size => File.new("pic2.jpg").size, :source_content_type => File.extname("pic2.jpg"), :source_updated_at => Time.now)
end



Then /^Asset table is also update$/ do
  asset=Asset.first(:assetable_id => Image.first.id, :assetable_type => "image")
  asset.update(:assetable_id => Image.first.id, :store_id => Store.first.id, :assetable_type => "image")
  
end



And /^I go to the edit image path of "([^"]*)"$/ do |image|
  
end

Then /^I should see the following images:$/ do |expected_images_table|
  expected_images_table.diff!(tableish('table tr', 'td,th'))
end
