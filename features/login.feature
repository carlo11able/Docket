Feature: LOGIN Feature

Scenario: As an unregistered user I want to signup with email so that I can become a Labeler or Customer
    Given A unregistered user as "nome", "cognome", "labeler@live", "12345678"
    And I press "Sign up"
    And I should be on the answers page

Scenario: As a Labeler I want to login with my email so that I can see labeler home page
    Given A registered labeler as "nome", "cognome", "labeler@live", "12345678"
    And I should be on the answers page



    
