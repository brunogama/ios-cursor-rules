# Swift Testing Guide

This guide outlines Swift testing principles and practices, focusing on creating effective unit tests for Swift code.

<rule>
name: swift_testing
filters:
  - type: file_change
    pattern: "*Tests.swift"
  - type: command
    pattern: "@swift-tests"

actions:
  - type: suggest
    message: |
      ## Swift Testing Guidelines
      
      In this project, every public function must have unit tests. We follow these guidelines:

      ### Test Structure
      
      #### Naming Convention
      
      - Test class name: `[ClassUnderTest]Tests`
      - Test method name: `test_[FunctionUnderTest]_[Scenario]_[ExpectedResult]`
      
      **Example:**
      ```swift
      class UserAuthenticationTests: XCTestCase {
          func test_authenticate_withValidCredentials_shouldReturnToken() { ... }
          func test_authenticate_withInvalidPassword_shouldThrowAuthError() { ... }
      }
      ```
      
      #### Arrangement
      
      Every test should follow the Arrange-Act-Assert (AAA) pattern:
      
      ```swift
      func test_addItem_withValidProduct_shouldAddToCart() {
          // Arrange
          let cart = ShoppingCart(id: CartID())
          let product = Product(id: ProductID(), name: "Test Product", price: Money(amount: 10, currency: .usd))
          
          // Act
          try! cart.addItem(product: product, quantity: 1)
          
          // Assert
          XCTAssertEqual(cart.items.count, 1)
          XCTAssertEqual(cart.total()?.amount, 10)
      }
      ```
      
      ### Types of Tests
      
      #### 1. Unit Tests
      
      - Tests a single unit of code in isolation
      - Uses mocks/stubs for dependencies
      - Fast and reliable
      - Located in target's matching test target (e.g., DomainTests for Domain code)
      
      ```swift
      func test_placeOrder_withValidItems_shouldCreateOrderSuccessfully() {
          // Arrange
          let mockOrderRepository = MockOrderRepository()
          let mockProductRepository = MockProductRepository()
          let orderService = OrderService(
              orderRepository: mockOrderRepository,
              productRepository: mockProductRepository
          )
          
          let items = [OrderItem(productID: ProductID(), quantity: 1, price: Money(amount: 10, currency: .usd))]
          
          // Act
          let result = orderService.placeOrder(items: items, customerID: CustomerID())
          
          // Assert
          XCTAssertTrue(result.isSuccess)
          XCTAssertEqual(mockOrderRepository.savedOrders.count, 1)
      }
      ```
      
      #### 2. Integration Tests
      
      - Tests interaction between multiple components
      - Typically involves real implementations rather than mocks
      - Located in separate test targets
      
      ```swift
      func test_orderFlow_endToEnd_shouldProcessOrderSuccessfully() {
          // Tests the full order flow from cart to confirmation
          // Uses real implementations for most components
      }
      ```
      
      ### Mocking Guidelines
      
      - Create mocks for protocols, not for concrete classes
      - Use protocol-based dependencies to make testing easier
      - Name mocks clearly with the `Mock` prefix
      
      ```swift
      protocol OrderRepository {
          func save(_ order: Order) throws
          func findByID(_ id: OrderID) -> Order?
      }
      
      class MockOrderRepository: OrderRepository {
          var savedOrders: [Order] = []
          var ordersToReturn: [OrderID: Order] = [:]
          
          func save(_ order: Order) throws {
              savedOrders.append(order)
          }
          
          func findByID(_ id: OrderID) -> Order? {
              return ordersToReturn[id]
          }
      }
      ```
      
      ### Testing Value Objects
      
      Test both valid and invalid initialization:
      
      ```swift
      func test_emailInitialization_withValidEmail_shouldSucceed() {
          // Arrange & Act
          let email = Email(value: "user@example.com")
          
          // Assert
          XCTAssertNotNil(email)
          XCTAssertEqual(email?.value, "user@example.com")
      }
      
      func test_emailInitialization_withInvalidEmail_shouldReturnNil() {
          // Arrange & Act
          let email = Email(value: "invalid-email")
          
          // Assert
          XCTAssertNil(email)
      }
      ```
      
      ### Testing Entities & Aggregates
      
      Test business rules and invariants:
      
      ```swift
      func test_order_cannotBeFinalized_whenEmpty() {
          // Arrange
          let order = Order(id: OrderID(), customerID: CustomerID())
          
          // Act
          let result = order.finalize()
          
          // Assert
          XCTAssertEqual(result, .failure(.emptyOrder))
      }
      ```
      
      ### Testing Use Cases
      
      Test input/output behavior and interactions:
      
      ```swift
      func test_placeOrderUseCase_shouldCoordinateRepositories() {
          // Arrange
          let mockOrderRepository = MockOrderRepository()
          let mockNotificationService = MockNotificationService()
          
          let useCase = PlaceOrderUseCase(
              orderRepository: mockOrderRepository,
              notificationService: mockNotificationService
          )
          
          let input = PlaceOrderInput(items: [...], customerID: CustomerID())
          
          // Act
          let output = useCase.execute(input: input)
          
          // Assert
          XCTAssertTrue(output.isSuccess)
          XCTAssertEqual(mockOrderRepository.savedOrders.count, 1)
          XCTAssertEqual(mockNotificationService.sentNotifications.count, 1)
      }
      ```
      
      ### Test Coverage Requirements
      
      - Domain Layer: 100% coverage
      - Application Layer: 100% coverage
      - Interface Adapters Layer: 90%+ coverage
      - Infrastructure Layer: Focus on critical paths
      
      ### Testing Asynchronous Code
      
      Use expectations for asynchronous testing:
      
      ```swift
      func test_fetchUserProfile_shouldReturnUserData() {
          // Arrange
          let expectation = self.expectation(description: "Fetch user profile")
          let userService = UserService(apiClient: realApiClient)
          var fetchedUser: User?
          
          // Act
          userService.fetchProfile(userID: UserID()) { result in
              if case .success(let user) = result {
                  fetchedUser = user
              }
              expectation.fulfill()
          }
          
          // Assert
          waitForExpectations(timeout: 1.0)
          XCTAssertNotNil(fetchedUser)
      }
      ```
      
      ### Testing Error Conditions
      
      Always test error paths:
      
      ```swift
      func test_transferMoney_withInsufficientFunds_shouldThrowError() {
          // Arrange
          let account = BankAccount(balance: Money(amount: 50, currency: .usd))
          
          // Act & Assert
          XCTAssertThrowsError(try account.withdraw(Money(amount: 100, currency: .usd))) { error in
              XCTAssertEqual(error as? BankAccountError, .insufficientFunds)
          }
      }
      ```
      
      ### Continuous Testing
      
      - Tests run on every pull request
      - All tests must pass before merging
      - Code coverage is measured and tracked
      - New code requires new tests

examples:
  - input: |
      How should I test this domain entity?
      ```swift
      struct Money: Equatable {
          let amount: Decimal
          let currency: Currency
          
          init?(amount: Decimal, currency: Currency) {
              guard amount >= 0 else { return nil }
              self.amount = amount
              self.currency = currency
          }
          
          func add(_ other: Money) -> Money? {
              guard currency == other.currency else { return nil }
              return Money(amount: amount + other.amount, currency: currency)
          }
          
          func subtract(_ other: Money) -> Money? {
              guard currency == other.currency else { return nil }
              return Money(amount: amount - other.amount, currency: currency)
          }
      }
      ```
    output: |
      Here's how you should test this Money value object:
      
      ```swift
      class MoneyTests: XCTestCase {
          
          // MARK: - Initialization Tests
          
          func test_init_withPositiveAmount_shouldCreateInstance() {
              // Arrange & Act
              let money = Money(amount: 100, currency: .usd)
              
              // Assert
              XCTAssertNotNil(money)
              XCTAssertEqual(money?.amount, 100)
              XCTAssertEqual(money?.currency, .usd)
          }
          
          func test_init_withZeroAmount_shouldCreateInstance() {
              // Arrange & Act
              let money = Money(amount: 0, currency: .eur)
              
              // Assert
              XCTAssertNotNil(money)
              XCTAssertEqual(money?.amount, 0)
              XCTAssertEqual(money?.currency, .eur)
          }
          
          func test_init_withNegativeAmount_shouldReturnNil() {
              // Arrange & Act
              let money = Money(amount: -10, currency: .usd)
              
              // Assert
              XCTAssertNil(money)
          }
          
          // MARK: - Addition Tests
          
          func test_add_withSameCurrency_shouldReturnCorrectSum() {
              // Arrange
              let money1 = Money(amount: 100, currency: .usd)!
              let money2 = Money(amount: 50, currency: .usd)!
              
              // Act
              let result = money1.add(money2)
              
              // Assert
              XCTAssertNotNil(result)
              XCTAssertEqual(result?.amount, 150)
              XCTAssertEqual(result?.currency, .usd)
          }
          
          func test_add_withDifferentCurrency_shouldReturnNil() {
              // Arrange
              let money1 = Money(amount: 100, currency: .usd)!
              let money2 = Money(amount: 50, currency: .eur)!
              
              // Act
              let result = money1.add(money2)
              
              // Assert
              XCTAssertNil(result)
          }
          
          func test_add_withZeroAmount_shouldReturnSameAmount() {
              // Arrange
              let money1 = Money(amount: 100, currency: .usd)!
              let money2 = Money(amount: 0, currency: .usd)!
              
              // Act
              let result = money1.add(money2)
              
              // Assert
              XCTAssertEqual(result?.amount, 100)
          }
          
          // MARK: - Subtraction Tests
          
          func test_subtract_withSameCurrency_shouldReturnCorrectDifference() {
              // Arrange
              let money1 = Money(amount: 100, currency: .usd)!
              let money2 = Money(amount: 30, currency: .usd)!
              
              // Act
              let result = money1.subtract(money2)
              
              // Assert
              XCTAssertNotNil(result)
              XCTAssertEqual(result?.amount, 70)
              XCTAssertEqual(result?.currency, .usd)
          }
          
          func test_subtract_withDifferentCurrency_shouldReturnNil() {
              // Arrange
              let money1 = Money(amount: 100, currency: .usd)!
              let money2 = Money(amount: 30, currency: .eur)!
              
              // Act
              let result = money1.subtract(money2)
              
              // Assert
              XCTAssertNil(result)
          }
          
          func test_subtract_resultingInNegativeAmount_shouldStillSubtract() {
              // Arrange
              let money1 = Money(amount: 30, currency: .usd)!
              let money2 = Money(amount: 50, currency: .usd)!
              
              // Act
              let result = money1.subtract(money2)
              
              // Assert
              XCTAssertNotNil(result)
              XCTAssertEqual(result?.amount, -20)
          }
      }
      ```
      
      Key aspects of this test approach:
      
      1. I've organized tests into logical sections (initialization, addition, subtraction)
      2. I've tested all valid and invalid scenarios for each method
      3. All tests follow the Arrange-Act-Assert pattern
      4. Test names clearly describe the scenario and expected outcome
      5. Edge cases are covered (zero values, negative results, currency mismatches)
      6. We're testing that the Money type properly enforces its invariants
      
      This comprehensive test suite verifies all the behavior of the Money value object.

metadata:
  priority: high
  version: 1.0
</rule>