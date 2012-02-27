Feature: Manage carts
  In order to [goal]
  [stakeholder]
  wants [behaviour]

  Scenario: Add item into  cart
    Given I am on the store wise list path
    And I select one image and add it to cart
    Then One item is add on the cart

  Scenario: Checkout The items
    Given I am on the store wise list path
    And I select one image and add it to cart
    When I go to the carts section page
    Then I follow "Checkout"
    Then I should be on the carts checkout page
    And I fill in "order_name" with "Red R"
    And I fill in "order_address" with "Salt Lake City"
    And I fill in "order_email" with "producer@lostbets.com"
    And I select  "Check" from "order_pay_type"
    And I press "Place Order"
    And It will save the order
    Then I redirect to the confirmation page

Scenario: Paypal link Testing
     Given I am on the store wise list path
    And I select one image and add it to cart
    When I go to the carts section page
    Then I follow "Checkout"
    Then I should be on the carts checkout page
    And I fill in "order_name" with "Red R"
    And I fill in "order_address" with "Salt Lake City"
    And I fill in "order_email" with "redr@lostbets.com"
    And I select  "Check" from "order_pay_type"
    And I press "Place Order"
    And It will save the order
    Then I redirect to the confirmation page
    Then I follow "Pay through Paypal" with order id 1
    Then It will Follow paypal process
    