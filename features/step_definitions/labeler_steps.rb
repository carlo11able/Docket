Given("A registered labeler as {string}, {string}, {string}, {string}") do |name,surname,email, password|
    @labeler = User.create(name: name, surname: surname, email: email, password: password, password_confirmation: password)
    @labeler.roles_mask=2
    @labeler.save!
    visit new_user_session_path
    fill_in 'user_email', :with => email
    fill_in 'user_password', :with => password
    click_button 'Log in'
end

Then("I can change email into {string} with {string}") do | new_value, password|
    fill_in 'user_email', :with => new_value
    fill_in 'user_current_password', :with => password
    click_button "Update"
    if User.first.email != new_value
        raise 'Upload failed'
    end
end


Then("I can change name into {string} with {string}") do | new_value, password|
    fill_in 'user_name', :with => new_value
    fill_in 'user_current_password', :with => password
    click_button "Update"
    if User.first.name != new_value
        raise 'Upload failed'
    end

end

Then("I can change surname into {string} with {string}") do | new_value, password|
    fill_in 'user_surname', :with => new_value
    fill_in 'user_current_password', :with => password
    click_button "Update"
    if User.first.surname != new_value
        raise 'Upload failed'
    end

end

Then("I can change password into {string} with {string}") do | new_value, password|
    fill_in 'user_password', :with => new_value
    fill_in 'user_password_confirmation', :with => new_value
    fill_in 'user_current_password', :with => password
    click_button "Update"
    
    click_link "Logout"

    fill_in 'user_email', :with => User.first.email
    fill_in 'user_password', :with => new_value
    
    click_button 'Log in'
    
    expect(page).to have_content("Signed in successfully.")
    # raise 'Login failed'
end


Given("exists a question") do
    @photo=Photo.new(user_id: User.first.id, url: "https://www.prova?file.jpg")
    @photo.save!
    @question=Question.new(photo_id: @photo.id, question_text: "Testo della domanda", question_answer1: "Risposta 1", question_answer2: "Risposta 2")
    @question.save!
    visit "/home"
end
    
    

