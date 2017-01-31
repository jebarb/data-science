# James Barbour

# even_odd ----------------------------------------------------------------
even_odd <- function(x) 
  !(trunc(x) %% 2)

# round_good --------------------------------------------------------------
round_good <- function(x, digits)
  if (x >= 0) floor(x*10^digits + .5)/10^digits else ceiling(x*10^digits - .5)/10^digits

# symdiff -----------------------------------------------------------------
symdiff <- function(a, b) 
  c(a[!(a %in% b)], b[!(b %in% a)])

# even_sum ----------------------------------------------------------------
even_sum <- function(vec) 
  sum(vec[even_odd(vec)])

# odd_sum -----------------------------------------------------------------
odd_sum <- function(vec, even = TRUE) 
  sum(vec[even == even_odd(vec)])

# monkey ------------------------------------------------------------------
monkey <- function(chars) {
  letter <- c(letters, c(' ', ',', '!'))
  characters = c(rep('', chars))
  # generate vector of random chars from set
  for (i in 1:(chars))
    characters[i] <- letter[as.integer(runif(1, min = 1, max = 30))]
  # check conditions
  for (i in 1:(chars)) {
    # check i after e except after c
    if (characters[i] == 'e') {
      if (characters[i+1] == 'i') {
        if (characters[i-1] != 'c') {
          characters[i] <- 'i'
          characters[i+1] <- 'e'
        }
      }
    }
    # ensure space after punctuation
    if (characters[i] %in% c(',', '!'))
      characters[i+1] = ' '
  }
  return(paste(characters, collapse = ''))
}
