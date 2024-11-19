---
  title: "W10 Task - Strings and Regular Expressions"
author: "Scott Townsend"
date: "`r format(Sys.time(), '%B %d, %Y')`"

execute:
  keep-md: true

format:
  html:
  code-fold: true
code-line-numbers: true
---
  
### Libraries & Data Sets
  
```{r, message=FALSE, warning=FALSE, fig.height=4, fig.width=12}
library(readr)
```

# Task - Visualization

```{r, message=FALSE, warning=FALSE, fig.height=4, fig.width=12}
random_letters <- read_lines("randomletters.txt")
random_letters_numbers <- read_lines("randomletters_wnumbers.txt")

hidden_quote <- function(text) {
  selected_letters <- substring(text, seq(1, nchar(text), by = 1700), seq(1, nchar(text), by = 1700))
  quote <- paste(selected_letters, collapse = "")
  hidden_message <- sub("^(.*?\\.).*$", "\\1", quote)
  return(hidden_message)
}

quote_message <- hidden_quote(random_letters)
cat("Hidden Quote:\n", quote_message, "\n")

decode_numbers_to_letters <- function(text) {
  numbers <- as.numeric(unlist(regmatches(text, gregexpr("\\d+", text))))
  decoded_message <- paste(letters[numbers], collapse = "")
  return(decoded_message)
}

decoded_message <- decode_numbers_to_letters(random_letters_numbers)
cat("Decoded Message:\n", decoded_message, "\n")

longest_vowel_sequence <- function(text) {
  cleaned_text <- gsub("[ .]", "", text)
  vowels <- unlist(regmatches(cleaned_text, gregexpr("[aeiou]+", cleaned_text)))
  longest <- vowels[which.max(nchar(vowels))]
  return(longest)
}

longest_vowels <- longest_vowel_sequence(random_letters)
cat("Longest Sequence of Vowels:\n", longest_vowels, "\n")
```