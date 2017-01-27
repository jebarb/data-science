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
  
}
