Feature: LABELER features

Scenario:As a LABELER I want to have labeler profile to change my email
    Given A registered labeler as "nome", "cognome", "labeler@live", "12345678"
    And I should be on the answers page
    Then I should see "Edit profile" 
    And I follow "Edit profile" 
    Then I can change email into "another@live.it" with "12345678"





Scenario: As a Labeler I want to have labeler profile to change my name
    Given A registered labeler as "nome", "cognome", "labeler@live", "12345678"
    And I should be on the answers page
    Then I should see "Edit profile" 
    And I follow "Edit profile" 
    Then I can change name into "nuovo_nome" with "12345678"



Scenario: As a Labeler I want to have labeler profile to change my surname
    Given A registered labeler as "nome", "cognome", "labeler@live", "12345678"
    And I should be on the answers page
    Then I should see "Edit profile" 
    And I follow "Edit profile" 
    Then I can change surname into "nuovo_cognome" with "12345678"

Scenario: As a Labeler I want to have labeler profile to change my password
    Given A registered labeler as "nome", "cognome", "labeler@live", "12345678"
    And I should be on the answers page
    Then I should see "Edit profile" 
    And I follow "Edit profile" 
    Then I can change password into "87654321" with "12345678"

Scenario: As a Labeler I want to have labeler home page so that I can see all answers given by me so that I can modify them
    Given A registered labeler as "nome", "cognome", "labeler@live", "12345678"
    And I should be on the answers page
    Then I should see "answers"

Scenario: As a Labeler I want to have labeler home page so that I can see random question page
    Given A registered labeler as "nome", "cognome", "labeler@live", "12345678"
    And I should be on the answers page
    Then I should see "answers"
    And exists a question
    And I follow "New answer"
    Then I should be on the new answer page


Scenario: As a Labeler I want to have random question page so that I can answer it
    Given A registered labeler as "nome", "cognome", "labeler@live", "12345678"
    And I should be on the answers page
    Then I should see "answers"
    And exists a question
    And I follow "New answer"
    Then I should be on the new answer page
    And I press "Create Answer"
    Then I should be on the answers page
    And I should see "Testo"