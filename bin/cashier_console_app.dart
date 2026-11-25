// CASHIER CONSOLE APP. Made by @Astro_142

/* 
  What does it include?
    - Almost all requirements for the task (even the bonus ones).
    - A help command to print out the available options again.
    - The ability to confirm or abort before completing a process
    - The nonexistance of functions and maps (This was a nightmare...)
    - idk what else.

  Starter lists for testing (copy and replace down):

    List<String> names = ["apple","orange","banana","carrot","potato","milk","chocolate","caviar"];
    List<double> prices = [2,3,5,8,10,12,18,400];
    List<int> quantities = [20,15,18,25,8,5,3,10];
    List<List<dynamic>> salesLog = [["apple",5,10],["milk",3,36],["carrot",10,60]];
*/


import 'dart:io';

void main(List<String> arguments) {
  // Variables declaration: Here, we declare the necessary variables needed for the program to function
  List<String> names = [];
  List<double> prices = [];
  List<int> quantities = [];
  List<List<dynamic>> salesLog = [];

  final String storeName = "Astro's store";
  final String password = "1234"; // CORRECT PASSWORD HERE
  
  bool isLoggedIn = false;
  String typedPassword;

  // Welcoming message: A lovely message on running the progam
  print("Welcome to:\n${storeName.toUpperCase()}");
  print("-------------------------------------------------------------------------");

  // Password inserting: User must enter the password before using the program.
  for(int i = 0; i < 3; i++){
    stdout.write("Please enter the password: ");
    typedPassword = stdin.readLineSync().toString();
    if(typedPassword == password){
      print("Successfully logged in!");
      isLoggedIn = true;
      break;
    }
    print("Incorrect password! Please try again.");
    print("-------------------------------------------------------------------------");
  }
  print("-------------------------------------------------------------------------");

  // Login Validation: Terminates the program if the login was unsecessful.
  if(!isLoggedIn){
    print("Access denied!");
    print("You've failed 3 times to enter the right password! Please try again later.");
    print("Closing the program...");
    return;
  }

  // Main program: Where the main stuff happens

  // Viewing the available options
  print("-------------------------------------------------------------------------");
  print("1. Add product");
  print("2. Show all products");
  print("3. Search product");
  print("4. Sell product");
  print("5. Update price / Remove product");
  print("6. Reports");
  print("7. Help");
  print("0. Exit");
  print("-------------------------------------------------------------------------");
  while(true){
    assert(names.length == prices.length, "Error occured with the lists. The lengths of the lists don't match.");

    for (int i = 0; i < prices.length - 1; i++) { // Sorting products based on the price
      for (int j = i + 1; j < prices.length; j++) {
        if (prices[i].compareTo(prices[j]) > 0) {
          String tempName = names[i];
          names[i] = names[j];
          names[j] = tempName;

          double tempPrice = prices[i];
          prices[i] = prices[j];
          prices[j] = tempPrice;

          int tempQuantity = quantities[i];
          quantities[i] = quantities[j];
          quantities[j] = tempQuantity;
        }
      }
    }
    // Recieving the number for a specific process
    stdout.write("Please select a number: ");
    int? option = int.tryParse(stdin.readLineSync().toString());

    // running the chosen process
    switch(option){
      case 1: // Add product
        String proName;
        double? proPrice;
        int? proQuantity;
        while(true){
          stdout.write("Please enter the product's name: ");
          proName = stdin.readLineSync().toString().trim().toLowerCase();
          if(proName != "") break;
        }
        if(names.contains(proName)){
          print("Product Already exists!");
          break;
        }
        while(true){
          stdout.write("Please enter the product's price: ");
          proPrice = double.tryParse(stdin.readLineSync().toString());
          if(proPrice == null){
            print("Invalid number!");
            continue;
          }else if(proPrice <= 0){
            print("Price cannot be a negative number or zero!");
            continue;
          }
          break;
        }
        while(true){
          stdout.write("Please enter the quantity of the product: ");
          proQuantity = int.tryParse(stdin.readLineSync().toString());
          if(proQuantity == null){
            print("Invalid number!");
            continue;
          }else if(proQuantity <= 0){
            print("Quantity cannot be a negative number or zero!");
            continue;
          }
          break;
        }
        print("Product: $proName, Price: $proPrice\$, Quantity: $proQuantity");
        String decision;
        while(true){
          stdout.write("Confirm adding the product?[y/n]: ");
          decision = stdin.readLineSync().toString().trim().toLowerCase();
          if(decision == "y" || decision == "n"){break;}
        }
        if(decision == "y"){
          names.add(proName);
          prices.add(proPrice);
          quantities.add(proQuantity);
          print("Successfully added!");
        }else{
          print("Adding cancelled!");
        }
        break;
      case 2: // Show all products
        if(names.isEmpty){
          print("No products available.");
          break;
        }
        print("Showing all products:");
        print("");
        double totalVal = 0;
        for(int i = 0; i < names.length; i++){
          print("   ${i+1}- ${names[i]}, price: ${prices[i]}\$, quantity: ${quantities[i]}.");
          totalVal += prices[i] * quantities[i];
        }
        
        print("");
        print("Total number of products: ${names.length}");
        print("Total value of storage: $totalVal");
        break;
      case 3: // Search
        String search;
        while(true){
          stdout.write("Enter the product's name to search for: ");
          search = stdin.readLineSync().toString().trim().toLowerCase();
          if(search != "") break;
        }
        List<String> results = names.where((element) => element.startsWith(search)).toList();
        results.sort();
        if(results.isEmpty){
          print("Not found.");
        }else{
          print("Showing all results:");
          print("");
          for(int i = 0; i < results.length; i++){
            print("   ${i+1}- ${results[i]}.");
          }
          print("");
        }
        break;
      case 4: // Sell
        String product;
        while(true){
          stdout.write("Enter the product's name to sell: ");
          product = stdin.readLineSync().toString().trim().toLowerCase();
          if(product != "") break;
        }
        List<String> results = names.where((element) => element == product).toList();
        if(results.isEmpty){
          print("Product not found!");
          break;
        }
        int productIndex = names.indexOf(product);
        double proPrice = prices[productIndex];
        int proQuantity = quantities[productIndex];
        if(proQuantity == 0){
          print("OUT OF STOCK!");
          break;
        }
        print("The product $product costs $proPrice\$. $proQuantity available in stock!");
        int? quan;
        while(true){
          stdout.write("Enter the amount to sell: ");
          quan = int.tryParse(stdin.readLineSync().toString());
          if(quan == null || quan <= 0){
            print("Invalid Number! Please enter a real number.");
            continue;
          }else if(quan > proQuantity){
            print("Not enough in stock!");
            continue;
          }
          break;
        }
        double totalPrice = quan * proPrice;
        double previousPrice  = 0;
        if(totalPrice > 1000){ // 10% off if the total price is above 1000
          previousPrice = totalPrice;
          totalPrice *= 0.9;
        }
        int quanAfter = proQuantity-quan;
        print("The total price is $totalPrice.${previousPrice > 1000 ? "(10% OFF, previous price: $previousPrice\$)" : ""}");
        if(quanAfter < 5 && quanAfter > 0){print("[WARNING]: There will be only $quanAfter left in stock after this purchase!");}
        else if(quanAfter == 0){print("[WARNING]: The product will be OUT OF STOCK after this purchase!");}
        String decision;
        while(true){
          stdout.write("Confirm?[y/n]: ");
          decision = stdin.readLineSync().toString().trim().toLowerCase();
          if(decision == "y" || decision == "n"){break;}
        }
        if(decision == "y"){
          quantities[productIndex] -= quan;
          salesLog.add([product,quan,totalPrice]);
          print("Successfully purchased! ${quanAfter == 0 ? "OUT OF STOCK!" : ""}");
        }else{
          print("Purchase cancelled!");
        }
        break;
      case 5: // Update/Remove
        String product;
        while(true){
          stdout.write("Enter the product's name to update/remove: ");
          product = stdin.readLineSync().toString().trim().toLowerCase();
          if(product != "") break;
        }
        List<String> results = names.where((element) => element == product).toList();
        if(results.isEmpty){
          print("Product not found!");
          break;
        }
        int productIndex = names.indexOf(product);
        double? newPrice;
        while(true){
          stdout.write("Enter the new price(type nothing to remove the product): ");
          String input = stdin.readLineSync().toString().trim();
          if(input == ""){
            newPrice = null;
            break;
          }else{
            newPrice = double.tryParse(input);
            if(newPrice == null){
              print("Invalid number!");
              continue;
            }else if(newPrice <= 0){
              print("Price cannot be a negative number or zero!");
              continue;
            }
            break;
          }
        }
        if(newPrice == null){
          String decision;
          while(true){
            stdout.write("Confirm removing the product?[y/n]: ");
            decision = stdin.readLineSync().toString().trim().toLowerCase();
            if(decision == "y" || decision == "n"){break;}
          }
          if(decision == "y"){
            names.removeAt(productIndex);
            prices.removeAt(productIndex);
            quantities.removeAt(productIndex);
            print("Successfully removed $product!");
          }else{
            print("Removing cancelled!");
          }
        }else{
          String decision;
          while(true){
            stdout.write("Confirm updating the price?[y/n]: ");
            decision = stdin.readLineSync().toString().trim().toLowerCase();
            if(decision == "y" || decision == "n"){break;}
          }
          if(decision == "y"){
            prices[productIndex] = newPrice;
            print("Successfully updated $product's price to $newPrice!");
          }else{
            print("Updating cancelled!");
          }
        }
        break;
      case 6: // Reports
        List<String> lowStockProducts = names.where((element) => quantities[names.indexOf(element)] < 5).toList();
        print("Products with less than 5 in stock: ${lowStockProducts.isEmpty ? "No products available" : lowStockProducts}");
        if (names.isEmpty) {
          print("Most expensive product: No products available");
        } else {
          int maxIndex = 0;
          for (int i = 1; i < prices.length; i++) {
            if (prices[i] > prices[maxIndex]) {
              maxIndex = i;
            }
          }
          print("Most expensive product: ${names[maxIndex]} (${prices[maxIndex]}\$)");
        }
        double totalRevenue = 0;
        for (dynamic element in salesLog) {
          totalRevenue +=element[2];
        }
        print("Total sales revenue: $totalRevenue\$");
        print("Total number of purchases: ${salesLog.length}");
        break;
      case 7: // Help
        print("");
        print("1. Add product");
        print("2. Show all products");
        print("3. Search product");
        print("4. Sell product");
        print("5. Update price / Remove product");
        print("6. Reports");
        print("7. Help");
        print("0. Exit");
        print("");
        break;
      case 0:
        print("Closing the program...");
        exit(0);
      default:
        print("Please select a number from above!");
        break;
    }
    print("-------------------------------------------------------------------------");
  }
}
