Given /^the following set_other_videos:$/ do |set_other_videos|
  SetOtherVideos.create!(set_other_videos.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) set_other_videos$/ do |pos|
  visit set_other_videos_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Given /^I am a new, authenticated admin user$/ do
  email = 'admin@lostbets.com'
  password = 'arminus'
  Given %{I have one user "#{email}" with password "#{password}"}
  user=User.first(:email => email)
  RoleUser.create(:user_id => user.id, :role_id => 2 ) if RoleUser.first(:user_id => user.id).nil?
  And %{I go to the sign in page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Sign in"}
  visit path_to("the my account page")

end

And /^I attach a file "([^\"]*)" in "([^\"]*)"$/ do |file,field|
  path = RAILS_ROOT + "/public/test/videos/"+file
  attach_file(field, path)
end

And /^I attach a file "([^\"]*)" in "([^\"]*)" for update$/ do |file,field|
  path = "#{RAILS_ROOT}/#{file}"
  attach_file(field, path)
end

And /^I attach a video image file "([^\"]*)"$/ do |file|
  path=RAILS_ROOT+"/public/test/images/"+ file
  attach_file("video_image", path)
end

Then /^I attach a video image file "([^\"]*)" for updation$"/ do |file|
  
end


Then /^I attach a video image file "([^"]*)" for updation$/ do |file|
  
end

And /^I update the details of the videos section$/ do
  other_video=OtherVideo.first
  other_video.update(:title => "This is the title of the video now it is updated", :description => "This is the description of the test video for other videos section now it is updated", :demo_video_path => "movie.swf")
end



And /^I save the details of other videos$/ do
  other_video=OtherVideo.new(:title => "This is the title of the video", :description => "This is the description of the test video for other videos section")
  other_video.demo_video_path = "demo.flv"
  other_video.main_video_mp4 = "main_mp4.mp4"
  other_video.main_video_wmv="main_wmv.wmv"
  other_video.main_video_mpeg="main_mpeg.mpeg"
  other_video.save!
  other_video.other_video_images.create(:image => "#{RAILS_ROOT}/public/test/images/art3.jpg")
  other_video.other_video_images.create(:image => "#{RAILS_ROOT}/public/test/images/art4.jpg")
  other_video.other_video_images.create(:image => "#{RAILS_ROOT}/public/test/images/art5.jpg")

end


Then /^I delete the demo video$/ do
  other_video=OtherVideo.first
  other_video.update(:demo_video_path => nil)
  File.delete("#{RAILS_ROOT}/public/test/videos/demo.flv") if File.exists?("#{RAILS_ROOT}/public/test/videos/demo.flv")
end

Then /^I also delete the first image$/ do
 other_video=OtherVideo.first
 other_video.other_video_images.first.destroy
end


Then /^I should see the following set_other_videos:$/ do |expected_set_other_videos_table|
  expected_set_other_videos_table.diff!(tableish('table tr', 'td,th'))
end
