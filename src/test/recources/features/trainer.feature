  Feature: Training for Lingo
  As a player,
  I want to guess 5,6,7 letter words
  In order to prepare for Lingo

  Feature: Creating a game
  As a User,
  I want to create a game
  In order to start guessing 5, 6 or 7 letter words

  Feature: Guessing a 5, 6 or 7 letter word
  As a User,
  I want to guess a 5, 6 or 7 letter word
  In order to make an attempt to guess the correct word

  Feature: Feedback
  As a player
  I want to get feedback from my attempted guess
  In order to see what letters are correct/ present/ absent

  Feature: Keep score
  As a player
  I want the score of the game
  In order to see if I get better

  Scenario: Start a new game
    When i start a new game
    Then i should get a first letter
    And the word should consist of "5" letters
    And i should start with "0" points

  Scenario: Start a new round
    Given i started a game
    And i won the last one
    Then i should get a first letter
    And i can guess the word

  Scenario Outline: Start a new round
    Given I am playing a game
    And the round was won
    And the last word had "<previous length>" letters
    When I start a new round
    Then the word to guess has "<next length>" letters

    Examples:
      | previous length | next length |
      | 5               | 6           |
      | 6               | 7           |
      | 7               | 5           |


  # Failure path
    Given I am playing a game
    And the round was lost
    Then I cannot start a new round

  Scenario Outline: Guessing a word
    Given I am playing a game
    And A new round has started
    And The word to guess is "<word>"
    When I attempt to guess the word with the following guess: <guess>
    Then I will get the following feedback: <feedback>

    Examples:
      | word  | guess  | feedback                                             |
      | BAARD | BERGEN | INVALID, INVALID, INVALID, INVALID, INVALID, INVALID |
      | BAARD | BONJE  | CORRECT, ABSENT, ABSENT, ABSENT, ABSENT              |
      | BAARD | BARST  | CORRECT, CORRECT, PRESENT, ABSENT, ABSENT            |
      | BAARD | DRAAD  | ABSENT, PRESENT, CORRECT, PRESENT, CORRECT           |
      | BAARD | BAARD  | CORRECT, CORRECT, CORRECT, CORRECT, CORRECT          |

  Scenario: The guess was correct
    Given the game has been started
    And i guessed the word
    Then the round has been ended
    And my score increses by 5*(5-number of "rounds")+5

  Scenario: Lost a game
    Given a round has started
    And i used 4 chances
    When i try to guess a word
    And the guess was wrong
    Then the round is over
    And the player lost a game

  Scenario: player can not guess a word when he lost
    Given the player hav lost a game
    Then the player cannot guess a word

  Scenario: player can not start a new round when the player is still playing
    Given a round is active
    When the player is trying to start a new one
    Then the new game wil not start