# The challenge

Once upon a time, four backend trainees were challenged by their mentor to work on [this kata](https://zerolivedev.gitlab.io/katayuno-jekill/kata/2022/09/15/CodeSyntax.html) using TDD principles. These were the main rules:

- The goal of the kata was to create a linter for a new programming language that uses opening and closing characters exclusively.
- In the easiest version, only shovels (<>) are used, while later versions incorporate brackets ([]) as well.
- Every string of code should start with an opening character and finish with a closing character.
- All openings should have their corresponding closings and expressions should be nested correctly.
- Some examples of valid expressions:
    - '<<><>><>'
    - '[<><>[]]'
    - '<[<>]>'
- Different character types should not intercept each other (for instance, '<[><]>' is not valid).

We would work on the kata individually and have sharing sessions with our mentor every week.

# First iteration

On the first week, I worked on producing code that followed the basic constraints of the kata:
- Every string should start with an opening character.
- Every string should finish with a closing character.
- The number of openings and closings should be the same for each character type.
Those were the main testing/coding steps I followed:
- Validate correct strings with shovels (return true).
- Do not validate strings starting with '>'.
- Do not validate strings ending with '<'
- Do not validate strings where the number of shovel openings and closings was not the same.
- Validate correct strings with both shovels and brackets.
- Do not validate strings where different types of symbols cut each other. I struggled a bit with this one since I could not find a simple pattern, and ended up doing a series of RegEx to match known incorrect expressions.

During the sharing session, it was revealed that there were incorrect strings that were validated in my code, such as '<>><<>'. We realized we needed to code some kind of function that matched each opening with a closing, and discussed possible solutions on a high level.

# Second iteration
This week, I starting by testing the known problematic expression, '<>><<>', which should return false. I soon realized that the need for a function that detected matching pairs of characters meant that most of my previous code was going to be scraped.
I liked the idea of iterating over a string of code that gets shorter and shorter as correct pairs of symbols are found, so I developed a recursive function, called matched_pairs?, that performed the following actions:
- Check that the first character is an opening.
- Find out what is the matching closing character, i. e., if we need a closing shovel or a closing bracket.
- Check that the remaining part of the string contains a matching closing character.
- When the matching closing is found, delete the found pair from the string and check the number of remaining characters. If no characters remain (meaning all have been correctly matched), return true. If one remains, return false. If two or more remain, return the function itself to keep matching pairs.

That left the problem of what to do when characters of different types intercept each other. I tried to make the detection of wrong character combinations part of the recursive function, but that overcomplicated the code. In the end, I detected that I only needed to look for two cases ('<]' and '[>'), so I took care of detecting wrong cases before entering the recursive function.

# Third iteration
During our second kata sharing session, we were told to left our solution as-is and take care of refactoring, so that was my main focus of the week (currently in progress).