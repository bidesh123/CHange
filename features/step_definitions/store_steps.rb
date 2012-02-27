Given /^the following stores:$/ do |stores|
  Store.create!(stores.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) store$/ do |pos|
  visit stores_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I fill up the store form with title "([^"]*)" and description "([^"]*)" and an user$/ do |title, description|
  Then %{I am on the new store page}
  store=Factory(:store, :title => title, :description => description, :user_id => 1) 
  
end

Then /^I add one image and one video to the store and one snapshot image for video$/ do
  store=Factory(:store, :id => 2, :title => "Use multiple image and video", :description => "Use multiple image and video", :user_id => 1)
  image=Image.create!(:source_file_name => "pic.jpg", :source_file_size => File.new("pic2.jpg").size, :source_content_type => File.extname("pic2.jpg"), :source_updated_at => Time.now)
  Asset.create!(:assetable_id => image.id, :store_id => store.id, :assetable_type => "image", :price => 200)
  video=Video.create!(:source_file_name => "movies2.swf", :source_file_size => File.new("movies2.swf").size, :source_content_type => File.extname("movies2.swf"), :source_updated_at => Time.now, :title => "video new", :description => "this is new video")
  Asset.create!(:assetable_id => video.id, :store_id => store.id, :assetable_type => "video", :price => 2000)
 
  VideoImage.create!(:source_file_name => "pic2.jpg", :video_id =>video.id , :source_file_size => File.new("pic2.jpg").size, :source_updated_at => Time.now)
  video.category_videos.create(:category_id => Category.get(2).id)
end


Then /^Again I add one image$/ do
  store=Store.last
  image=Image.create!(:source_file_name => "pic.jpg", :source_file_size => File.new("pic.jpg").size, :source_content_type => File.extname("pic.jpg"), :source_updated_at => Time.now)
  Asset.create!(:assetable_id => image.id, :store_id => store.id, :assetable_type => "image", :price => 250)
end

Then /^Again I add another video$/ do
  store=Store.last
  video=Video.create!(:source_file_name => "movies2.swf", :source_file_size => File.new("movies2.swf").size, :source_content_type => File.extname("movies2.swf"), :source_updated_at => Time.now, :title => "this is second video", :description => "video second test video")
  Asset.create!(:assetable_id => video.id, :store_id => store.id, :assetable_type => "video", :price => 2555)
  VideoImage.create!(:source_file_name => "pic2.jpg", :video_id =>video.id , :source_file_size => File.new("pic2.jpg").size, :source_updated_at => Time.now)
  video.category_videos.create(:category_id => Category.last.id)
end

Then /^I save the store$/ do
  
end

Then /^I am redirected to the store list wise path$/ do
  visit store_desc_stores_path
end



Then /^I edit the store of id "([^"]*)" with title "([^"]*)" and description "([^"]*)" and the user$/ do |id,title,description|
  store=Store.get(id.to_i)
  store.update(:title => title, :description => description, :user_id => 1)
end

Then /^the first store from the list will be destoryed$/ do
  unless Store.first.nil?
    store=Store.first
    store.destroy
  end
end

Then /^I should see the following stores:$/ do |expected_stores_table|
  expected_stores_table.diff!(tableish('table tr', 'td,th'))
end


Given /^I redirect to the store path$/ do
  visit search_stores_path
end



