

# Creating Functions

With only one data set to analyze, it would probably be faster to load the file into a spreadsheet and use that to plot some simple statistics. 
But we have twelve files to check, and may have more in future.
In this lesson, we'll learn how to write a function so that we can repeat several operations with a single command.

## Objectives

* Define a function that takes parameters.
* Return a value from a function.
* Test and debug a function.
* Explain what a call stack is, and trace changes to the call stack as functions are called.
* Set default values for function parameters.
* Explain why we should divide programs into small, single-purpose functions.

Let's start by defining a function `fahr_to_kelvin` that converts temperatures from Fahrenheit to Kelvin:


```r
fahr_to_kelvin <- function(temp) {
    # Converts Fahrenheit to Kelvin
    kelvin <- ((temp - 32) * (5/9)) + 273.15
}
```


The definition opens with the name of your new function, which is followed by the call to make it a `function` and a parenthesized list of parameter names. You can have as many input parameters as you would like (but too many might be bad style). The body, or implementation, is surrounded by curly braces `{ }`. In many languages, the body of the function - the statements that are executed when it runs - must be indented, typically using 4 spaces. While this is not a mandatory requirement in R coding, we strongly recommend you to adopt this as good practice.

When we call the function, the values we pass to it are assigned to those variables so that we can use them inside the function.
Calling our own function is no different from calling any other function:


```r
fahr_to_kelvin(32)
```


Unfortunately, this returns nothing. We created a variable (kelvin) that is deleted when the function ends.
We need to add a line to return a result.


```r
fahr_to_kelvin <- function(temp) {
    # Converts Fahrenheit to Kelvin
    kelvin <- ((temp - 32) * (5/9)) + 273.15
    kelvin
}
```


Now typing


```r
fahr_to_kelvin(32)
fahr_to_kelvin(212)
```


returns the answer we expect.

It is important to put comments within a function (docstring) to associate them directly with that function.


```r
fahr_to_kelvin
```


Composing Functions
-------------------

Now that we've seen how to turn Fahrenheit into Kelvin, it's easy to turn Kelvin into Celsius:


```r
kelvin_to_celsius <- function(temp) {
    # Converts Kelvin to Celsius
    Celsius <- temp - 273.15
    Celsius
}

kelvin_to_celsius(0)
```


What about converting Fahrenheit to Celsius? We could write out the formula, but we don't need to. 
Instead, we can compose the two functions we have already created:


```r
fahr_to_celsius <- function(temp) {
    # Converts Fahrenheit to Celsius using fahr_to_kelvin() and
    # kelvin_to_celsius()
    temp_k <- fahr_to_kelvin(temp)
    result <- kelvin_to_celsius(temp_k)
    result
}

fahr_to_celsius(32)
```


This is how larger programs are built: we define basic operations, then combine them in ever-large chunks to get the effect we want. 
Real-life functions will usually be larger than the ones shown here—typically half a dozen to a few dozen lines—but they shouldn't ever be much longer than that, or the next person who reads it won't be able to understand what's going on.

## R Environments and scoping rules

An **environment** is a place to store names (variables, functions). An environment's job is to bind a set of names to a set of values.
The environment is where R will look when it needs to find the value of a name.

Environments have parents. If R cannot find a variable in the current environment, it will look in the parent environment.

**emptyenv()** is the parent of **baseenv()** is the parent of **globalenv()**
  - emptyenv is the top level environment (no parent).
  - baseenv is the environment of the base package (the basic functions which let R work as a programming language).
  - globalenv is the current user working environment. The parent of globalenv will change as you load packages.
  
Let's take a look at the different environments with RStudio.
Choosing a different environment will show you the names in that environment.
Loading a package will change the parent of the global environment.

Understanding environments is important to understand how R defines variables (scoping rules).
The scope of an association between a variable and a value is the part of the code where the association is valid.
In R, scoping is lexical, which means associations are dependent on the location in the source code.

Let's take a closer look at what happens when we call `fahr_to_celsius(32)`.
To make things clearer, we'll start by putting the initial value 32 in a variable and store the final result in one as well:


```r
temp <- 32
freezing <- fahr_to_celsius(temp)
boiling <- fahr_to_celsius(212)
temp
```


Notice the value of `temp` did not change. A function creates a local environment that(usually) does not affect the global environment.

The big idea here is __encapsulation__, and it's the key to writing correct, comprehensible programs. A function's job is to turn several operations into one so that we can think about a single function call instead of a dozen or a hundred statements each time we want to do something. That only works if functions don't interfere with each other; if they do, we have to pay attention to the details once again, which quickly overloads our short-term memory.

__BREAK__

### Challenges

This next challenge has several steps. Think about how you break down a difficult problem into manageable pieces.

1. Write a function called `analyze` that takes a filename as a parameter and displays the 3 graphs you made earlier (average, min and max inflammation over time). i.e., `analyze('data/inflammation-01.csv')` should produce the graphs already shown, while `analyze('inflammation-02.csv')` should produce corresponding graphs for the second data set. Be sure to give your function a docstring.

## Default parameters in functions

Let's take


```r
help(read.csv)  #or ?read.csv
```


_walk through the help file, point out important items. How to read the defaults, how to know what you need to specify. Definitions and examples..._

There's a lot of information here, but the most important part is the first couple of lines:


```r
read.csv(file, header = TRUE, sep = ",", quote = "\"", dec = ".", fill = TRUE, 
    comment.char = "", ...)
```


This tells us that `read.csv` has one parameter called file that doesn't have a default value, and eight others that do. If we call the function like this:


```r
read.csv("data/inflammation-01.csv", ",")
```

```
## Error: invalid argument type
```


then the filename is assigned to name (which is what we want), but the delimiter string ',' is assigned to `header` rather than `sep`, because `header` is the second parameter in the list. That's why we don't have to provide `file=` for the filename, but do have to provide `sep=` for the second parameter.

Key Points
===============
* Define a function using `function` name(...params...).
* The body of a function should be indented.
* Call a function using name(...values...).
* Numbers are stored as integers or floating-point numbers.
* Each time a function is called, a new environment is created to hold its parameters and local variables.
* R looks for variables in the current environment before looking for them at the top level.
* Use help(thing) to view help for something.
* Put docstrings in functions to provide help for that function.
* Annotate your code!
* Specify default values for parameters when defining a function using name=value in the parameter list.
* Parameters can be passed by matching based on name, by position, or by omitting them (in which case the default value is used).

## Next Steps

We now have a function called analyze to visualize a single data set. We could use it to explore all 12 of our current data sets like this:


```r
analyze("data/inflammation-01.csv")
analyze("data/inflammation-02.csv")
# ...
analyze("data/inflammation-12.csv")
```


but the chances of us typing all 12 filenames correctly aren't great, and we'll be even worse off if we get another hundred files.
What we need is a way to tell R to do something once for each file, and that will be the subject of the next lesson.
