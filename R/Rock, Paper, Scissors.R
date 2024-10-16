## Before we start coding, let's break down the rules:

## There are three possible choices: rock, paper, scissors.
## Rock beats scissors.
## Scissors beats paper.
## Paper beats rock.
## If both players choose the same, it's a tie.

# Define possible choices
hand <- c("rock", "paper", "scissors")

game <- function(){
  
  player_wins <- 0
  computer_wins <- 0
  ties <- 0

  for(i in 1:2){
  print(paste("round ",i))
  
  # Generate random computer choice

  ai_hand <- sample(hand,1)
  # Get player's choice
  my_hand <- readline("please choose your hand sign :")
  

  # Check for invalid input
  if(!my_hand %in% hand){
    cat("Invalid choice. Please enter rock, paper, or scissors.\n")
    return(game)
  }
  # Determine the winner
  if(my_hand == ai_hand){
    result <- "It's tie"
    ties <- ties + 1
    
  }
  else if((my_hand == "rock" && ai_hand == "scissors") || 
          (my_hand == "paper" && ai_hand == "rock") ||
          (my_hand == "scissors" && ai_hand == "paper")) {
    result <- "you win"
    player_wins <- player_wins + 1
  }
  else {
    result <- "ai win"
    computer_wins <- computer_wins +1
  }
  cat("You chose:", my_hand, "\n")
  cat("Computer chose:", ai_hand, "\n")
  cat(result, "\n")
  cat("My point is",player_wins,"\n")
  cat("Ai point is",computer_wins,"\n")
  cat("Ties",ties,"times","\n","\n")
  }
  cat("\nGame over!\n")
  cat("Point Summary\n")
  cat("My point is",player_wins,"\n")
  cat("Ai point is",computer_wins,"\n")
  cat("Ties",ties,"times","\n","\n")
}


game()

# result
> game()
[1] "round  1"
please choose your hand sign :rock
You chose: rock 
Computer chose: rock 
It's tie 
My point is 0 
Ai point is 0 
Ties 1 times 
 
[1] "round  2"
please choose your hand sign :rock
You chose: rock 
Computer chose: scissors 
you win 
My point is 1 
Ai point is 0 
Ties 1 times 
 

Game over!
Point Summary
My point is 1 
Ai point is 0 
Ties 1 times 
