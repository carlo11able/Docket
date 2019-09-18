Feature: ADMIN features

Scenario: As an Admin I want to have admin home page so that I can see the customer's list
    Given A registered admin as "nome", "cognome", "admin@live", "12345678"
    Then I should be on the users page
    And I follow "Lista Customer"
    Then I should be on the customers page






Scenario: As an Admin I want to see the customers list so that I can see a customer profile
    Given A registered admin as "nome", "cognome", "admin@live", "12345678"
    Then I should be on the users page
    And I follow "Lista Customer"
    Then I should be on the customers page
    And exist a costumer
    And I follow his customer email
    Then I should be on the user customer page
    And I should see "Customer"


Scenario: As an Admin I want to have admin home page so that I can see the labeler's list
    Given A registered admin as "nome", "cognome", "admin@live", "12345678"
    Then I should be on the users page
    And I follow "Lista Labeler"
    Then I should be on the labelers page

Scenario: As an Admin I want to see the labelers list so that I can see a labeler profile
    Given A registered admin as "nome", "cognome", "admin@live", "12345678"
    Then I should be on the users page
    And I follow "Lista Labeler"
    Then I should be on the labelers page
    And exist a labeler
    And I follow his labeler email
    Then I should be on the user labeler page
    And I should see "Labeler"

Scenario: As an Admin I want to have admin customer profile page so that I can delete customer profile
    Given A registered admin as "nome", "cognome", "admin@live", "12345678"
    Then I should be on the users page
    And I follow "Lista Customer"
    Then I should be on the customers page
    And exist a costumer
    And I follow his customer email
    Then I should be on the user customer page
    And I should see "Customer"
    Then I follow "Destroy User"
    And I should be on the users page
    And I follow "Lista Customer"
    Then I should be on the customers page
    And I should not see "View Customer"

Scenario: As an Admin I want to have admin labeler profile page so that I can delete labeler's profile
    Given A registered admin as "nome", "cognome", "admin@live", "12345678"
    Then I should be on the users page
    And I follow "Lista Labeler"
    Then I should be on the labelers page
    And exist a labeler
    And I follow his labeler email
    Then I should be on the user labeler page
    And I should see "Labeler"
    Then I follow "Destroy User"
    And I should be on the users page
    And I follow "Lista Labeler"
    Then I should be on the labelers page
    And I should not see "View Labeler"


Scenario: As an Admin I want to have admin labeler profile page so that I can delete labeler's answer
    Given A registered admin as "nome", "cognome", "admin@live", "12345678"
    Then I should be on the users page
    And I follow "Lista Labeler"
    Then I should be on the labelers page
    And exist a labeler with his answer
    And I follow his labeler email
    Then I should be on the user labeler page
    And I should see "Labeler"
    And I should see "Show Answer"
    Then I follow "Show Answer"
    Then I follow "Destroy Answer"
    Then I should be on the answers page



Scenario: As an Admin I want to see batch page so that I can delete question
    Given A registered admin as "nome", "cognome", "admin@live", "12345678"
    Then I should be on the users page
    And exist a customer with his photo and his question
    And I follow "Show Photo" 
    Then I should be on the first photo page
    And I should see "Testo della domanda"
    And I follow "Destroy" 
    Then I should be on the first photo page
    And I should not see "Testo della domanda"


Scenario: As an Admin I want to see batch page so that I can see batch answer page
    Given A registered admin as "nome", "cognome", "admin@live", "12345678"
    Then I should be on the users page
    And exist a customer with his photo and question and labeler with his answer
    And I follow "Show Photo" 
    Then I should be on the first photo page
    And I should see "Testo della domanda"
    And I follow "Show"
    Then I should be on the first question page
    And I should see "labeler@live.it"




Scenario: As an Admin I want to have batch answer page so that I can delete labeler's answer
    Given A registered admin as "nome", "cognome", "admin@live", "12345678"
    Then I should be on the users page
    And exist a customer with his photo and question and labeler with his answer
    And I follow "Show Photo" 
    Then I should be on the first photo page
    And I should see "Testo della domanda"
    And I follow "Show"
    Then I should be on the first question page
    And I should see "labeler@live.it"
    And I follow "Risposta 1"
    Then I should be on the first answer page
    And I follow "Destroy Answer"
    Then I should be on the answers page




Scenario: As an Admin I want to see batch page so that I can see the customer's profile who upload the batch
    Given A registered admin as "nome", "cognome", "admin@live", "12345678"
    Then I should be on the users page
    And exist a customer with his photo and question and labeler with his answer
    And I follow "Show Photo" 
    Then I should be on the first photo page
    And I should see "Testo della domanda"
    And I follow "Show"
    Then I should be on the first question page
    And I follow "customer@live.it"
    Then I should be on the user customer page





Scenario: As an Admin I want to see batch page so that I can delete batch
    Given A registered admin as "nome", "cognome", "admin@live", "12345678"
    Then I should be on the users page
    And exist a customer with his photo and question and labeler with his answer
    And I follow "Show Photo" 
    Then I should be on the first photo page
    And I follow "Destroy Photo"
    Then I should be on the photos page
