# Create ATM Simulator Using OOP
## with 5 method
"""
- Check Balance
- Deposit
- Withdraw
- Transfer
- Cardless with OTP
"""

## Import Library
## Test on google colab

from random import choice
class ATM():

    # attribute อยากให้รับค่าอะไรบ้างในที่นี้ผมต้องการให้รับ 3 name, balance, password
    def __init__(self, name, balance, password):
        self.name = name
        self.balance = balance
        self.password = password
    
    # method อยากให้มี function เฉพาะของ class (method) อะไรบ้าง ในที่นี้ผมอยากให้ class มี 5 method
    # เช็คยอดเงิน, ฝาก-ถอน เงิน, โอนเงิน, กดเงินไม่ใช้บัตร
    def check_balance(self):
        print(f"Your current balance is: {self.balance}")

    def deposit(self, amount):
        if amount > 0:
            self.balance += amount
            print(f"Deposited {amount}. Your new balance is: {self.balance}")
        else :
            print("Invalid deposit amount.") 
    
    def withdraw(self, amount):
        if amount > 0 and amount <=  self.balance:
            self.balance -= amount
            print(f"Withdrew {amount}. Your new balance is: {self.balance}")
        elif amount > 0 and amount > self.balance:
            print("Insufficient funds.")
        else:
            print("Invalid deposit amount.")
    
    def transfer(self, acc_num, amount, issamebank = False):
        fee = 10
        if amount > 0 and amount <= self.balance and issamebank == False:
            self.balance -= amount
            print(f"Transferred {amount} to account {acc_num}.Fee : {fee}. Your new balance is: {self.balance}")
        elif amount > 0 and amount <= self.balance and issamebank == True:
            fee = 0
            self.balance -= amount
            print(f"Transferred {amount} to account {acc_num}.Fee : {fee}. Your new balance is: {self.balance}")
        elif amount > 0 and amount > self.balance:
             print("Insufficient funds.")
        else:
            print("Invalid deposit amount.")
    
    def cardless(self, amount, password):
        otp = range(0,100001)
        
        if self.password == password and amount > 0 and amount <= self.balance:
            otp1 = choice(otp)
            print(f"POV: ON YOUR PHONE SCREEN\n      Your OTP is {otp1}") ## this function should send otp into user message
            otp2 = int(input("Please enter your OTP. :"))
            
            if otp1 == otp2:
                self.balance -= amount
                print(f"Withdrew {amount}. Your new balance is: {self.balance}")
            else :
                print("The OTP you entered is incorrect.")
        
        elif amount > 0 and amount > self.balance:
             print("Insufficient funds.")
        else:
            print("Your password is invalid, Please try again")

    # create def str
    def __str__(self):
        text = f"Welcome, {self.name}!"
        return text
