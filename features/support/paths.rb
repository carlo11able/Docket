# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    when /^the answers\s?page$/
      answers_path

    when /^the photos\s?page$/
      photos_path

    when /^the new photo\s?page$/
      new_photo_path

    when /^the first photo\s?page$/
      photo_path(Photo.first)

    when /^the edit photo\s?page$/
      edit_photo_path(Photo.first)


    when /^the new question\s?page$/
      new_photo_question_path(Photo.first)
    
    when /^the edit photo\s?page$/
      edit_photo_path(Photo.first)

    when /^the customers\s?page$/
      "/users/customers"
    
    
    when /^the user customer\s?page$/
      user_path(User.where(roles_mask: 4).first)

    when /^the labelers\s?page$/
      "/users/labelers"
    
    when /^the user labeler\s?page$/
      user_path(User.where(roles_mask: 2).first)
    
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
