Given("A unregistered user as {string}, {string}, {string}, {string}") do |name,surname,email, password|
    #visit new_user_registration
    visit "/users/sign_up"
    fill_in 'user_name', :with => name
    fill_in 'user_surname', :with => surname
    fill_in 'user_email', :with => email
    fill_in 'user_password', :with => password
    fill_in 'user_password_confirmation', :with => password
end
