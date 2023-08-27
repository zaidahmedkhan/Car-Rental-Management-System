import 'dart:io';

class Car {
  String name;
  String carNumber;
  String carModel;
  bool isAvailable;

  Car(this.name, this.carNumber, this.carModel, this.isAvailable);
}

class Customer {
  String name;

  Customer(this.name);
}

List<Car> cars = [];
List<Customer> customers = [];

void main() {
  while (true) {
    print("====== Car Rental Management System ======");
    print("1. Add a Car");
    print("2. Register a Customer");
    print("3. Rent a Car");
    print("4. View Available Cars");
    print("5. Generate Bill");
    print("6. Exit");
    print("Enter your choice:");

    var choice = int.tryParse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        addCar();
        break;
      case 2:
        registerCustomer();
        break;
      case 3:
        rentCar();
        break;
      case 4:
        viewAvailableCars();
        break;

      case 5:
        generateBill();
        break;
      case 6:
        print("Thank you for using the Car Rental Management System!");
        return;
      default:
        print("Invalid choice. Please try again.");
    }
  }
}

void addCar() {
  print("Enter Car Name:");
  var name = stdin.readLineSync();

  print("Enter Car Number:");
  var carNumber = stdin.readLineSync();

  print("Enter Car Model:");
  var carModel = stdin.readLineSync();

  cars.add(Car(name!, carNumber!, carModel!, true));
  print("Car added successfully!");
}

void registerCustomer() {
  print("Enter Customer Name:");
  var name = stdin.readLineSync();

  customers.add(Customer(name!));
  print("Customer registered successfully!");
}

void rentCar() {
  if (cars.isEmpty) {
    print("No cars available for rent.");
    return;
  }

  if (customers.isEmpty) {
    print("No customers registered. Please register a customer first.");
    return;
  }

  print("Available Cars:");
  for (var car in cars) {
    if (car.isAvailable) {
      print(
          "Name:${car.name}, Number: ${car.carNumber}, Car Model: ${car.carModel}");
    }
  }

  print("Enter Car Number to Rent:");
  var carNumber = stdin.readLineSync();

  Car? carToRent;
  for (var car in cars) {
    if (car.carNumber == carNumber && car.isAvailable) {
      carToRent = car;
      break;
    }
  }

  if (carToRent == null) {
    print("Car not found or already rented.");
    return;
  }

  print("Enter Customer Name:");
  var customerName = stdin.readLineSync();

  Customer? customerToRent;
  for (var customer in customers) {
    if (customer.name == customerName) {
      customerToRent = customer;
      break;
    }
  }

  if (customerToRent == null) {
    print("Customer not found. Please register the customer first.");
    return;
  }

  carToRent.isAvailable = false;
  print("Car rented successfully to ${customerToRent.name}.");
}

void generateBill() {
  if (cars.isEmpty) {
    print("No cars rented yet.");
    return;
  }

  print("Enter Car Number to Generate Bill:");
  var carNumber = stdin.readLineSync();

  Car? carToGenerateBill;
  for (var car in cars) {
    if (car.carNumber == carNumber) {
      carToGenerateBill = car;
      break;
    }
  }

  if (carToGenerateBill == null || carToGenerateBill.isAvailable) {
    print("Car not found or not rented.");
    return;
  }

  print("Enter number of days rented:");
  var daysRented = int.tryParse(stdin.readLineSync()!);

  if (daysRented == null || daysRented <= 0) {
    print("Invalid number of days.");
    return;
  }

  var ratePerDay = 50;
  var totalAmount = ratePerDay * daysRented;

  print("Bill for ${carToGenerateBill.name}:");
  print("Car Number: ${carToGenerateBill.carNumber}");
  print("Car Model: ${carToGenerateBill.carModel}");
  print("Number of Days Rented: $daysRented");
  print("Rate Per Day: $ratePerDay");
  print("Total Amount: $totalAmount");
}

void viewAvailableCars() {
  if (cars.isEmpty) {
    print("No cars available for rent.");
    return;
  }

  print("Available Cars:");
  for (var car in cars) {
    if (car.isAvailable) {
      print(car);
    }
  }
}
