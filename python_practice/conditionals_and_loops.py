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

    # Custom special characters (you can modify this based on your needs)
    special = ['!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '_', '+', '=',
                    '{', '}', '[', ']', '|', '\\', ':', ';', '"', "'", '<', '>', ',', '.', 
                    '?', '/', '`', '~']
    weak_password = True

    while weak_password == True:
        password = str(input("Enter password\n"))
        if len(password) <= 8: 
            print("Your password must be greater than 8 characters. Please try again: \n")

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

# **** Question 19 Given the nested list [[1, 2, 3], [4, 5, 6], [7, 8, 9]], use nested loops to print all numbers in a single line separated by spaces.
def question_19():
    nested_list = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    empty_list = []
    for i in nested_list:
        for z in i:
            empty_list.append(z)
    print(*empty_list)

# Question 20 Create a simple calculator that keeps asking for two numbers and an operation (+, -, *, /) until the user enters "quit". Use a while loop and conditional statements to perform the correct operation.

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

# Question 21 Write a program that asks for a number and prints whether it's positive, negative, or zero.