# Question 1 Write a program that asks for a number and prints whether it's even, odd, or zero.
def question_1():
    print("please give a number. I will tell you if it is positive negative or zero\n")
    mynum = int(input( "Enter a number: "))
    if mynum == 0: 
        print("Your number is 0")
    elif mynum % 2 == 1:
        print("Your number is odd")
    elif mynum % 2 == 0:
        print("Your number is even")
    else:
        print("Oops something went wrong")

# Question 2: Create a program that takes a grade (0-100) and prints the letter grade: A: 90-100 B: 80-89 C: 70-79 D: 60-69 F: Below 60
def question_2(grade):
    if grade < 60:
        print("F")
    elif grade >= 60 and grade < 70:
        print("D")
    elif grade >= 70 and grade < 80:
        print("C")
    elif grade >= 80 and grade < 90:
        print("B")
    else:
        print("A")

# Question 3 Write a program that checks if a person can vote. They can vote if they are 18 or older AND are a citizen. Use variables age and is_citizen (True/False).
def question_3(AGE, CITIZEN):
    if AGE >= 18 and CITIZEN == True:
        print("You may vote.")
    else: print("You may NOT vote.")

# Question 4 Loop through the numbers 1 to 10 and print each number, but skip the number 7 using continue.
def question_4():
    numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    for i in numbers:
        if i == 7:
            continue
        else:
            print(i)

# Question 5 Print all even numbers from 2 through 20 using a for loop with range().
def question_5():
    for i in range(2, 21):
        if i % 2 == 0:
            print(i)

# Question 6 Given the list [10, 25, 5, 30, 15], loop through it and print only the numbers greater than 15.
def question_6():
    mylist = [10, 25, 5, 30, 15]
    for i in mylist:
        if i > 15:
            print(i)

# Question 7 Write a while loop that counts down from 10 to 1, then prints "Blast off!".
def question_7():
    countdown = 10
    while countdown != 0:
        print(countdown)
        countdown -= 1
    print("Blast off!")

# Question 8 Loop through the string "programming" and count how many times the letter 'r' appears.
def question_8():
    mystr = "programming"
    r_count = 0
    for i in mystr:
        if i == "r":
            r_count += 1
    print(f"There are {r_count} r's in programming")

# Question 9 Create a program that finds the largest number in the list [45, 22, 88, 56, 92, 33] using a for loop (don't use the max() function).
def question_9():
    mylist = [45, 22, 88, 56, 92, 33]
    largest_num = 0
    for i in mylist:
        if i > largest_num:
            largest_num = i 
    print(largest_num)

# Question 10 Write a program that prints numbers from 1 to 50, but stops immediately when it reaches a number divisible by both 3 and 7 (use break).
def question_10():
    for i in range(1, 51):
        if i % 3 == 0 and i % 7 == 0:
            break
    print(f"{i} is divisable by both 3 and 7")

# Question 11 Given two lists names = ["Alice", "Bob", "Charlie"] and ages = [25, 30, 35], print each person's name and age together using a for loop.
def question_11():
    names = ["Alice", "Bob", "Charlie"]
    ages = [25, 30, 35]
    print("")

    for i, e in zip(names, ages):
        print(f"{i} is {e} years old. (Solution using zip function)")
    print("")

    for i in range(len(names)):
        print(f"{names[i]} is {ages[i]} years old (Solution using len + range function)")
    print("")

# **** Question 12 Create a password strength checker. A password is strong if it has 8 or more characters AND contains both letters and numbers. Test with the password "abc123xyz". NEED TO COME BACK TO THIS ONE 
def question_12():
    lowercase = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 
                   'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']

    uppercase = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
                    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']

    numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
    while True:
        has_letter = False
        has_number = False
        password = str(input("Enter password\n"))
        if len(password) < 8: 
            print("Your password must be greater than 8 characters. Please try again: \n")
            continue
        for i in password:
            if i in numbers:
                has_number = True
        for i in password:
            if i in lowercase or i in uppercase:
                has_letter = True
        if has_letter == True and has_number == True:
            print("Your password is secure")
            break
        else: 
            print("Password not secure")
question_12()      

# Question 13 Write a program that simulates rolling a dice. Keep rolling (use a while loop) until you get a 6, then print how many rolls it took. Use import random and random.randint(1, 6).
def questions_13():
    import random 
    dice = 0
    dice_counter = 0
    while dice != 6:
        dice = random.randint(1, 6)
        print(f"dice roll: {dice}")
        dice_counter += 1
    print(f"It took {dice_counter} rolls to to 6.")

# Question 14 Loop through the list ["apple", "banana", "cherry", "date"] and print only the fruits that have 5 or fewer letters.
def question_14():
    fruits = ["apple", "banana", "cherry", "date"]
    for i in fruits:
        if len(i) <= 5:
            print(i)

# Question 15 Create a multiplication table for the number 7 (7 x 1 = 7, 7 x 2 = 14, etc.) up to 7 x 10.
def question_15(num):
    for i in range(11):
        print(f"{num} x {i} = {num * i}")

# Question 16 Given the list [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], create a new list that contains only the odd numbers using a for loop.
def question_16():
    mylist = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    new_list = []
    for i in mylist:
        if i % 2 == 1:
            new_list.append(i)
    print(new_list)

# Question 17 Write a program that asks the user to guess a number between 1 and 10. Keep asking until they guess correctly (the correct number is 7). Count how many guesses it took.
def question_17():
    import random
    victory = random.randint(1, 10)
    guesses = 1
    while True: 
        your_guess = int(input("Guess a number between 1 and 10, \n"))
        if your_guess != victory:
            print("That is not the correct number. Try again")
            guesses += 1
        else:
            print(f"You guessed the correct number in {guesses} guesses")
            break

# Question 18 Loop through the numbers 1 to 100 and print: "Fizz" if the number is divisible by 3 "Buzz" if the number is divisible by 5 "FizzBuzz" if divisible by both 3 and 5 The number itself otherwise
def question_18(num):
    for i in range (1, num):
        if i % 3 == 0 and i % 5 == 0:
            print(f"{i} Fizzbuzz")
        elif i % 3 == 0:
            print(f"{i} Fizz")
        elif i % 5 == 0:
            print(f"{i} Buzz")
        else: 
            print(i)

# Question 19 Given the nested list [[1, 2, 3], [4, 5, 6], [7, 8, 9]], use nested loops to print all numbers in a single line separated by spaces.
def question_19():
    nested_list = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    empty_list = []
    for i in nested_list:
        for z in i:
            empty_list.append(z)
    print(*empty_list)

# Question 20 Create a simple calculator that keeps asking for two numbers and an operation (+, -, *, /) until the user enters "quit". Use a while loop and conditional statements to perform the correct operation.
def question_20():
    while True:
        print("Type 'quit' to quit\n")
        operator = str(input( " Please input an opperator (+, -, *, /) or type 'quit' to quit." ))
        if operator == "quit":
            break
        num1 = int(input( "Number 1" ))
        num2 = int(input( "Number 2" ))
        if operator == "*":
            print(num1 * num2)
        elif operator == "-":
            print(num1 - num2)
        elif operator == "+":
            print(num1 + num2)
        elif operator == "/":  
            print(num1 / num2)
        else: 
            print("No operater selected. Resetting")

# Question 21: Create a function that validates an email address. It must contain exactly one @ symbol, have text before and after the @, and the part after @ must contain at least one dot. Use string methods and return True/False.


# Question 22: Write a program that safely converts user input to integers. Keep asking for a number until they provide a valid integer between 1 and 100. Use try-except blocks and while loops.
# Question 23: Create a username validator. Username must be 3-15 characters, contain only letters and numbers (use isalnum()), and start with a letter. Test with usernames: "user123", "123user", "u", "validuser".
# Question 24: Write a function that counts different character types in a password. Return a dictionary with counts of letters, numbers, and special characters. Use char.isalpha(), char.isdigit() and test with "MyPass123!".
# Question 25: Create a function that checks if a string is a palindrome (reads the same forwards and backwards). Ignore spaces, punctuation, and case. Use string methods lower(), replace(), and test with "A man a plan a canal Panama".
# File Operations (Questions 26-30)
# Question 26: Create a program that writes a list of server names to a file called "servers.txt", one server per line. Then read the file back and print each server name with its line number. Use with open() for both operations.
# Question 27: Write a function that reads a config file where each line is "key=value" format. Return a dictionary of all key-value pairs. Handle the case where the file doesn't exist using try-except and os.path.exists().
# Question 28: Create a log file analyzer. Read a file where each line contains "timestamp,level,message". Count how many ERROR vs INFO messages there are. Use string.split(',') and handle FileNotFoundError.
# Question 29: Write a program that backs up files by copying them with a timestamp. Read "original.txt", create "original_backup_YYYYMMDD.txt" with the same content. Use datetime.now().strftime('%Y%m%d') for timestamp.
# Question 30: Create a function that merges multiple configuration files. Read "config1.txt" and "config2.txt" (key=value format), combine them into one dictionary, and write the merged config to "merged_config.txt".
# JSON and Data Structures (Questions 31-35)
# Question 31: Create a function that converts a list of server dictionaries to JSON and saves it to a file. Each server should have name, ip, status, and cpu_usage fields. Use json.dump() with indent=2 for pretty formatting.
# Question 32: Write a program that reads a JSON file containing student grades and calculates the average grade for each student. The JSON structure is: {"students": [{"name": "Alice", "grades": [85, 92, 78]}, {"name": "Bob", "grades": [76, 88, 91]}]}.
# Question 33: Create a function that validates JSON configuration. Check that required fields (server_name, port, ssl_enabled) exist and port is between 1-65535. Use json.loads() and handle json.JSONDecodeError.
# Question 34: Write a program that processes nested dictionary data representing a company org chart. Count total employees in each department and find the highest paid employee overall. Use nested loops and max() with key parameter.
# Question 35: Create a function that filters and transforms data. Given a list of dictionaries representing server metrics, return only servers with CPU > 80% and format the output as "Server: NAME (CPU: XX%)". Use list comprehensions.
# API Interactions and Advanced Patterns (Questions 36-40)
# Question 36: Create a function that simulates checking server health via API. Use requests.get() with timeout=5, handle connection errors, and return a status dictionary with server name, response_time, and status_code.
# Question 37: Write a program that processes API pagination. Start with page 1, keep fetching until you get an empty results array. Simulate with httpbin.org/get?page=X and collect all data into a single list.
# Question 38: Create a function that monitors multiple APIs concurr
# 
# ently. Check status of 3 different URLs, collect response times, and return a summary report. Use requests.get() and handle different error types (timeout, connection error).
# Question 39: Write a program that validates and processes webhook data. Parse incoming JSON, validate required fields exist, transform the data format, and save valid entries to a file while logging errors for invalid ones.
# Question 40: Create a comprehensive system monitor that combines everything: read server list from JSON file, check each server's API health endpoint, update server status in memory, write results to both JSON and CSV formats, and send summary to Slack. Handle all error cases gracefully.