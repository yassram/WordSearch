# WordSearch : Shopify Mobile Developer Intern Challenge

# Preview
<p align="center">
<img src="Preview/P0.png" width="400">
<img src="Preview/P1.png" width="400">
<img src="Preview/L1.png" height="400">
</p>


## Requirements
* [x] A word search mobile app.
* [x] The word search should have at least a 10x10 grid. (**has 12x12 grid**)
* [x] Include at least the following 6 words: Swift, Kotlin, ObjectiveC, Variable, Java, Mobile. (**in addition to words from data.json**)
* [x] Keep track of how many words a user has found. (**with a score and a word list**) 
* [x] Make sure it compiles successfully.

## Suggested Bonus
* [x] Randomize where the words are placed.
* [x] Make a slick UI with smooth animations. (**animation on success with confetti, animated custom alert view ...**)
* [x] Make it look good in portrait and landscape. (**changing the position of the words list for better look**)
* [x] Allow the user to find the words by swiping over the words.

## Extra Bonus
* [x] Displaying score (**nb found / nb words**).
* [x] Timer score (**duration of the game**).
* [x] Words' list with **dashed found words**.
* [x] **Found words are highlighted** with a different background color.
* [x] Words' data are loaded randomly **from a json** file ([`data.json`](/WordSearch/Data/data.json)) which can be easily updated with new words.
* [x] The **size of the grid is dynamic and fully customizable**, by changing the values of `collumnNumber` and `lineNumber` in [`GameVC.swift`](WordSearch/Controllers/GameVC.swift).
* [x] Timer is **paused** / **resumed** when **info menu** is displayed.
* [x] You can start a new game anytime by tapping the **restart** button (**resets timer and score and reloads the grid with new words and new positions**).
* [x] **Haptic feedback** when new word is found.
* [x] **Confetti animation** on success (when all words are found) with an **animated custom alert view** (which is **reusable** with a default mode `showSucess(action: Selector? = nil)` or with a custom message `show(title: String, message: String, actionName: String, action: Selector?)`)
* [x] and more...
