library(tidyverse)
library(stringr) # this should come with tidyverse, but code wont run without import

# load data
artists <- read_csv('https://raw.githubusercontent.com/idc9/stor390/master/data/moma_artists_jan2017.csv')
art <- read_csv('https://raw.githubusercontent.com/idc9/stor390/master/data/moma_art_jan2017.csv')

# Annoying weird issue with first column name
colnames(art) <- c('title', tolower(colnames(art))[-1])
colnames(artists) <- c('id', tolower(colnames(artists))[-1])

# To give us something to do, removing artist information leaving only the artist uniqueid (constituentid) for joining
art <- select(art, -artist, -artistbio, -nationality, -begindate, -enddate, -gender)

# Removing artwork with NA constituent ID. Lots of NA values in their entries, and not worth finding out what's up for this demonstration.
# There are
art <- filter(art, !is.na(constituentid))

art <- mutate(art, 
              classification = str_replace_all(classification, "[[:punct:]]", ""),
              classification = str_replace_all(classification, "\\s", "_"),
              constituentid = str_trim(constituentid, side = "both"),
              objectid = str_trim(objectid, side = "both"))

artists <- mutate(artists, 
                  id = str_trim(id, side = "both"))

# For some reason, certain artworks list the same constituentid twice. Not worth explaining in the lecture. 

# We correct this in the lecture, but you could correct it here with the code below

# art$constituentid <- str_split(art$constituentid, ",") %>% lapply(., function(x){unique(x) %>% paste(., collapse = ",")}) %>% unlist


# In class code-------------------------------------------------------------------------------------------------------
test = filter(art, grepl(',', constituentid)) %>%
       slice(10:50)

# doesnt work, too many artists in some entries:
separate(test, col=constitientid, into=c('artist1', 'artist2'), sep=',')

# Need to find largest number of occurences of artists first:
str_replace_all(art$constituentid, "[^,]", "") %>% nchar %>% max

# how mant columns to add
n <- str_replace_all(art$constituentid, "[^,]", "") %>% nchar %>% max + 1

# maybe this will work
test <- separate(test, col=constituentid, into=paste0("artistid", c(1:n)), sep=",", fill="right")

# Running same thing on art
n <- str_replace_all(art$constituentid, "[^,]", "") %>% nchar %>% max + 1
art <- separate(art, col=constituentid, into=paste0("artistid", c(1:n)), sep=",", fill="right")

# Gathering artistid
art <- gather(art, key=artistnum, value=constituentid, contains("artistid"), na.rm=TRUE)
selet(art, artistnum, constituentid)

# unite artists and art ids
tidy_art <- unite(art, col=id, constituentid, objectid)
tidy_art %>% select(id)
