Given("A registered admin as {string}, {string}, {string}, {string}") do |name,surname,email, password|
    @admin = User.create(name: name, surname: surname, email: email, password: password, password_confirmation: password)
    @admin.roles_mask=1
    @admin.save!
    visit new_user_session_path
    fill_in 'user_email', :with => email
    fill_in 'user_password', :with => password
    click_button 'Log in'
end

Given("exist a costumer") do
    @customer = User.create(name: "nome", surname: "cognome", email: "customer@live.it", password: "12345678", password_confirmation: "12345678")
    @customer.roles_mask=4
    @customer.save!

    visit "/users/customers"
end

Given("exist a labeler") do
    labeler = User.create(name: "nome", surname: "cognome", email: "admin@live.it", password: "12345678", password_confirmation: "12345678")
    labeler.roles_mask=2
    labeler.save!
    visit "/users/labelers"
end


Given("I follow his customer email") do
    #click_link User.where(roles_mask: 4).first.email
    click_link "View Customer"
end

Given("I follow his labeler email") do
    #click_link User.where(roles_mask: 4).first.email
    click_link "View Labeler"
end