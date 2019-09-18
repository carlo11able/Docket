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
    



Scenario: As an Admin I want to see batch page so that I can delete question
Scenario: As an Admin I want to see batch page so that I can see batch answer page
Scenario: As an Admin I want to have batch answer page so that I can delete labeler's answer
Scenario: As an Admin I want to see batch page so that I can see the customer's profile who upload the batch
Scenario: As an Admin I want to see batch page so that I can delete batch
