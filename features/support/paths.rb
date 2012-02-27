module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /the new pagination page/
      new_pagination_path

   
    when /the new set_other_videos page/
      new_set_other_videos_path

    when /the new manage_search page/
      new_manage_search_path

    
    when /the new set_role page/
      new_set_role_path

    when /the new cart page/
      new_cart_path

    when /the other videos page/
      other_videos_path
    when/the new other videos page/
      new_other_video_path

    when /the edit other videoes path/
      edit_other_video_path(1)

    when /the new images path/
      new_picture_path

    when /the new text page/
      new_text_path

    when /the new video page/
      new_movie_path
    when /the store show path/
      store_path(1)
    when /the edit image path/
      edit_picture_path(1)
    when /the list images path/
      pictures_path
      
    when /the list of the text page/
      contents_path
      
    when /the new text path/
      new_content_path
      
    when/the edit text path/
      edit_content_path(1)
      
    when /the my account page/
      edit_user_registration_path
     
    when /the new role page/
      new_role_path

    when /the new shipments page/
      new_shipments_path

    when /the new payment page/
      new_payment_path

    when /the new address page/
      new_address_path
    when /the password edit page/
      edit_user_password_path
    when /the new store page/
      new_store_path
    when /the edit account page/
      edit_user_registration_path

    when /the sign up page/
      new_user_registration_path
    when /the rest password page/
      edit_user_password_path
       
    when /the sign up page with a type invalid type/
      new_user_registration_path(:type => "invalid")

    when /the sign in page/
      new_user_session_path

    when /the forgot password page/
      new_user_password_path
    
    when /the list store page/
      stores_path
    when /the new store path/
      new_store_path
    when /the edit store path/
      edit_store_path(1)

    when /the store wise list path/
      store_desc_stores_path
    when /the store desc page 1/
      store_desc_stores_path(:page => 1)

    when/the carts section page/
      carts_path
    when/the carts checkout page/
      checkout_carts_path
    when /to the confirmation page/
      order_details_carts_path

    when /the set role path/
      admin_set_roles_path
    when /the edit role for first user/
      edit_admin_set_role_path(1)
    when/the admin new role page/
      new_admin_set_role_path
    when /the admin set user path/
      admin_set_users_path
    when /the edit set user for first user/
      edit_admin_set_user_path(1)
    when /the admin set user show path/
      admin_set_user_path(1)
    when /the search path/
      search_stores_path
      # Add more mappings here.
      # Here is an example that pulls values out of the Regexp:
      #
      #   when /^(.*)'s profile page$/i
      #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
