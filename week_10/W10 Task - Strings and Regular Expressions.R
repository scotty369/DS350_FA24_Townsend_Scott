# Libraries
library(readr)
library(stringr)

# Task 1: Read the data
random_letters <- read_lines("https://byuistats.github.io/M335/data/randomletters.txt")
letters_wnumbers <- read_lines("https://byuistats.github.io/M335/data/randomletters_wnumbers.txt")

# Combine lines into a single string for processing
letters_combined <- str_c(random_letters, collapse = "")

# Task 2: Extract the hidden quote
indices <- seq(1, str_length(letters_combined), by = 1700) # Every 1700th letter
extracted_letters <- str_sub(letters_combined, indices, indices)
hidden_message <- str_c(extracted_letters, collapse = "")
quote <- str_extract(hidden_message, ".*?\\.") # Extract the quote ending with a period
cat("Hidden Quote:\n", quote, "\n\n")

# Task 3: Decode numbers into letters
letters_wnumbers_combined <- str_c(letters_wnumbers, collapse = "")
numbers <- as.integer(str_extract_all(letters_wnumbers_combined, "\\d+")[[1]])
decoded_message <- str_c(letters[numbers], collapse = "")
cat("Decoded Message:\n", decoded_message, "\n\n")

# Task 4: Find the longest sequence of vowels
cleaned_letters <- str_remove_all(letters_combined, "[ .]") # Remove spaces and periods
vowel_sequences <- str_extract_all(cleaned_letters, "[aeiouAEIOU]+")[[1]]
longest_vowel_sequence <- vowel_sequences[which.max(str_length(vowel_sequences))]
cat("Longest Vowel Sequence:\n", longest_vowel_sequence, "\n")

