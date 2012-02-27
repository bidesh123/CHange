Given /^the following sortings:$/ do |sortings|
  Sorting.create!(sortings.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) sorting$/ do |pos|
  visit sortings_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end


Then /^It will the video according to the "([^"]*)"$/ do |value|
  if value == "category"
  videos=[]
  CategoryVideo.all(:order => "category_id").each do |cat|
    videos << cat.video
  end
  elsif value == "price"
    @store=Store.first
    @asset_videos = Asset.all(:assetable_type => "video", :store_id => @store.id,  :order => "price")
  elsif value == "length"
    @videos=Video.all(:order => "source_file_size")
  elsif value == "date"
    @videos=Video.all(:order => "source_updated_at")
  end

end

Then /^I should see the following sortings:$/ do |expected_sortings_table|
  expected_sortings_table.diff!(tableish('table tr', 'td,th'))
end
