movies = {
    "Iron Man": 2008,
    "Avengers: Endgame": 2019,
    "Thor": 2011,
    "Guardians of the Galaxy": 2014
}

sorted_movies = sorted(movies.items())  

for movie in sorted_movies:
    print(movie, end=' ')
