Given("A registered customer as {string}, {string}, {string}, {string}") do |name,surname,email, password|
    @labeler = User.create(name: name, surname: surname, email: email, password: password, password_confirmation: password)
    @labeler.roles_mask=4
    @labeler.save!
    visit new_user_session_path
    fill_in 'user_email', :with => email
    fill_in 'user_password', :with => password
    click_button 'Log in'
end

Given("I upload a photo") do
    path_img="../../cut.jpg"
    attach_file('photo_image', path_img)
end

Given("I create new question") do 
    fill_in "question_question_text", :with => "Testo della domanda"
    fill_in "question_question_answer1", :with => "Risposta 1"
    fill_in "question_question_answer2", :with => "Risposta 2"
    click_button "Create Question"
end