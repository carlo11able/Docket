Feature: CUSTOMER features


Scenario: As a Customer I want to have customer home page so that I can see new batch page
    Given A registered customer as "nome", "cognome", "labeler@live", "12345678"
    Then I should be on the photos page
    

Scenario: As a Customer I want to have new batch page so that I can upload a local photo
    Given A registered customer as "nome", "cognome", "labeler@live", "12345678"
    Then I should be on the photos page
    And I should see "New photo"
    And I follow "New photo"
    Then I should be on the new photo page
    And I upload a photo
    Then I should be on the new photo page


Scenario: As a Customer I want to have new batch page so that I can add new question
    Given A registered customer as "nome", "cognome", "labeler@live", "12345678"
    Then I should be on the photos page
    And I should see "New photo"
    And I follow "New photo"
    Then I should be on the new photo page
    And I upload a photo
    And I press "Create Photo"
    Then I should be on the first photo page
    And I follow "New Question"
    Then I should be on the new question page
    And I create new question
    Then I should be on the first photo page
    And I should see "Testo della domanda"


Scenario: As a Customer I want to have new batch page so that I can create new batch
    Given A registered customer as "nome", "cognome", "labeler@live", "12345678"
    Then I should be on the photos page
    And I should see "New photo"
    And I follow "New photo"
    Then I should be on the new photo page
    And I upload a photo
    And I press "Create Photo"
    Then I should be on the first photo page

Scenario: As a Customer I want to have customer home page so that I can see edit batch page
    Given A registered customer as "nome", "cognome", "labeler@live", "12345678"
    Then I should be on the photos page
    And exists a question
    And I follow "Edit"
    Then I should be on the edit photo page



Scenario: As a Customer I want to have edit batch page so that I can delete question
    Given A registered customer as "nome", "cognome", "labeler@live", "12345678"
    And exists a question
    Then I should be on the photos page
    And I follow "Show"
    Then I should be on the first photo page
    And I follow "Destroy"
    Then I should be on the first photo page
    And I should not see "Testo della domanda"


Scenario: As a Customer I want to have edit batch page so that I can add new question
    Given A registered customer as "nome", "cognome", "labeler@live", "12345678"
    Then I should be on the photos page
    And I should see "New photo"
    And I follow "New photo"
    Then I should be on the new photo page
    And I upload a photo
    And I press "Create Photo"
    Then I should be on the first photo page
    And I follow "New Question"
    Then I should be on the new question page
    And I create new question
    Then I should be on the first photo page
    And I should see "Testo della domanda"


Scenario: As a Customer I want to have edit batch page so that I can update batch
    Given A registered customer as "nome", "cognome", "labeler@live", "12345678"
    And exists a question
    Then I should be on the photos page
    And I follow "Show"
    Then I should be on the first photo page
    And I follow "Edit Photo"
    Then I should be on the edit photo page
    And I upload a photo
    And I press "Update Photo"
    Then I should be on the first photo page




Scenario: As a Customer I want to have customer home page so that I can see batch view answer
    Given A registered customer as "nome", "cognome", "labeler@live", "12345678"
    And exists a question
    Then I should be on the photos page
    And I follow "Show"
    Then I should be on the first photo page
    And I should see "Testo della domanda"
    And I should see "Num Answer:"
