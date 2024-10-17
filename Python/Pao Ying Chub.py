"""
TEXT : 
# Pao Ying Chub!

"หวนคืนสู่วัยเด็กกับเกมเป่ายิงฉุบ! เกมที่ทุกคนคุ้นเคยและไม่มีวันล้าสมัย มาเล่นด้วยกัน แล้วคุณจะรู้ว่าความสนุกนั้นอยู่ใกล้แค่เอื้อม"

Step 1. เลือกจำนวนครั้งที่ต้องการจะเล่น

Step 2. เลือก Hand ของเรา จากตัวเลือก (ค้อน, กรรไกร, กระดาษ)

Step 3. Program จะทำการคำนวนผลแพ้ชนะในแต่ละรอบพร้อมกับสรุปคะแนนให้หลังจากจบเกม

กติกา: ค้อน ชนะ กรรไกร, กรรไกร ชนะ กระดาษ, กระดาษ ชนะ ค้อน
หากออกเหมือนกันตานั้นจะถือว่าเสมอ

Note: ผู้เล่นสามารถหยุดเล่นได้ด้วยการพิม x ขณะเลือก hand
"""

from random import choice
def Paoyingchub() :
    greeting = "Let's play rock-paper-scissors."
    print(greeting)
    target = int(input("How many times do you want to play? :")) ## transform str to int
hands = ["rock", "paper", "scissors"]
count = 0
play_score = 0
ai_score = 0
tie_score = 0
while count < target : ## Start game by checking target round
    player_hand = input("Pick your hand: rock, paper, or scissors. (or type 'x' to exit the game) :")
    ai_hand = choice(hands)
    if player_hand.lower() == "x":
        print("Thank you for playing.")
        print(f"Summary Score is\nPlayer's score is {play_score}, AI's score is {ai_score}")
        break
    print(f"Your choices is {player_hand}")
    print(f"AI's choices is {ai_hand}")  
    ## Checking if the choice is among the options
    if player_hand.lower() not in hands :
        print("Invalid Input.")
    elif player_hand == ai_hand : 
        print("Tie")
        count +=1
        tie_score +=1
        # First Scenario Tie
    elif (player_hand == "rock" and ai_hand == "scissors") or (player_hand == "paper" and ai_hand == "rock") or (player_hand == "scissors" and ai_hand == "paper"):
        print("Player Win.")
        play_score +=1
        count +=1
        # Increment player's score
    elif (ai_hand == "rock" and player_hand == "scissors") or (ai_hand == "paper" and player_hand == "rock") or (ai_hand == "scissors" and player_hand == "paper"):
        print("Ai Win.")
        ai_score +=1
        count +=1
        # Increment AI's score
    print(f"Player's score is {play_score}, AI's score is {ai_score}\n")
print("Game over!")
print(f"Summary Score is\nPlayer's score is {play_score}, AI's score is {ai_score}\nTie is {tie_score} ")

