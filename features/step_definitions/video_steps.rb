And /^I pass the file "([^"]*)" and select one store "([^"]*)":$/ do |name,store|
   
end

Given /^I pass the file "([^"]*)" and select one store "([^"]*)"$/ do |name, store_name|
  if User.first.nil?
    Factory(:user)
  end
  if Store.first.nil?
    store = Factory(:store)
  end
  video=Video.create!(:source_file_name => name, :source_file_size => File.new(name).size, :source_content_type => File.extname(name), :source_updated_at => Time.now, :title => "this is my video", :description => "test video")
  Asset.create!(:assetable_id => video.id, :store_id => Store.first.id, :assetable_type => "video")
  VideoImage.create!(:source_file_name => "pic2.jpg", :video_id =>video.id, :source_file_size => File.new("pic2.jpg").size, :source_updated_at => Time.now)
  video.category_videos.create(:category_id => Category.first.id)
end

When /^I delete the (\d+)(?:st|nd|rd|th) video$/ do |pos|
  visit videos_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Given /^the following movies:$/ do |videos|
  Video.create!(videos.hashes)
end

Then /^I should see the following videos:$/ do |expected_videos_table|
  expected_videos_table.diff!(tableish('table tr', 'td,th'))
end
