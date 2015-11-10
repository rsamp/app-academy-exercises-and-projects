# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#
#  movie_id    :integer      not null, primary key
#  actor_id    :integer      not null, primary key
#  ord         :integer

require_relative './sqlzoo.rb'

def example_join
  execute(<<-SQL)
    SELECT
      *
    FROM
      movies
    JOIN
      castings ON movies.id = castings.movie_id
    JOIN
      actors ON castings.actor_id = actors.id
    WHERE
      actors.name = 'Sean Connery'
  SQL
end

def ford_films
  # List the films in which 'Harrison Ford' has appeared.
  execute(<<-SQL)
  SELECT
    title
  FROM
    movies
  JOIN
    castings ON movies.id = castings.movie_id
  JOIN
    actors ON castings.actor_id = actors.id
  WHERE
    actors.name = 'Harrison Ford'
  SQL
end

def ford_supporting_films
  # List the films where 'Harrison Ford' has appeared - but not in the star
  # role. [Note: the ord field of casting gives the position of the actor. If
  # ord=1 then this actor is in the starring role]
  execute(<<-SQL)
  SELECT
    title
  FROM
    movies
  JOIN
    castings ON movies.id = castings.movie_id
  JOIN
    actors ON castings.actor_id = actors.id
  WHERE
    actors.name = 'Harrison Ford' and castings.ord <> 1
  SQL
end

def films_and_stars_from_sixty_two
  # List the title and leading star of every 1962 film.
  execute(<<-SQL)
  SELECT
    title, actors.name
  FROM
    movies
  JOIN
    castings ON movies.id = castings.movie_id
  JOIN
    actors ON castings.actor_id = actors.id
  WHERE
    movies.yr = 1962 and castings.ord = 1
  SQL
end

def travoltas_busiest_years
  # Which were the busiest years for 'John Travolta'? Show the year and the
  # number of movies he made for any year in which he made at least 2 movies.
  execute(<<-SQL)
  SELECT
    t.yr, t.count_title
  FROM
    (SELECT
      yr, COUNT(title) count_title
    FROM
      movies
    JOIN
      castings ON movies.id = castings.movie_id
    JOIN
      actors ON castings.actor_id = actors.id
    WHERE
      actors.name = 'John Travolta'
    GROUP BY
      yr
    ) t
  WHERE t.count_title > 1
  SQL
end

def andrews_films_and_leads
  # List the film title and the leading actor for all of the films 'Julie
  # Andrews' played in.
  execute(<<-SQL)
  SELECT
    title, act_norm.name
  FROM
    movies
  JOIN
    castings cast_norm ON movies.id = cast_norm.movie_id
  JOIN
    actors act_norm ON cast_norm.actor_id = act_norm.id
  JOIN
    castings cast_j ON movies.id = cast_j.movie_id
  JOIN
    actors act_j ON cast_j.actor_id = act_j.id
  WHERE
    act_j.name = 'Julie Andrews' AND cast_norm.ord = 1
  -- WHERE title IN (
  --   SELECT
  --     title
  --   FROM
  --     movies
  --   JOIN
  --     castings ON movies.id = castings.movie_id
  --   JOIN
  --     actors ON castings.actor_id = actors.id
  --   WHERE
  --     actors.name = 'Julie Andrews'
  --   ) AND castings.ord = 1
  SQL
end

def prolific_actors
  # Obtain a list in alphabetical order of actors who've had at least 15
  # starring roles.
  execute(<<-SQL)
  SELECT
    name
  FROM
    actors
  JOIN
    castings ON castings.actor_id = actors.id
  JOIN
    movies ON castings.movie_id = movies.id
  WHERE
    castings.ord = 1
  GROUP BY
    actors.name
  HAVING
    COUNT(actors.name) >= 15
  ORDER BY
    actors.name
  SQL
end

def films_by_cast_size
  # List the films released in the year 1978 ordered by the number of actors
  # in the cast (descending), then by title (ascending).
  execute(<<-SQL)
  SELECT
    title, COUNT(actors.name)
  FROM
    movies
  JOIN
    castings ON movies.id = castings.movie_id
  JOIN
    actors ON castings.actor_id = actors.id
  WHERE
    yr = 1978
  GROUP BY
    title
  ORDER BY
    COUNT(actors.name) DESC,
    title ASC
  SQL
end

def colleagues_of_garfunkel
  # List all the people who have played alongside 'Art Garfunkel'.
  execute(<<-SQL)
  SELECT
    name
  FROM
    actors
  JOIN
    castings ON castings.actor_id = actors.id
  JOIN
    movies ON movies.id = castings.movie_id
  WHERE movies.title IN (
    SELECT
      title
    FROM
      movies
    JOIN
      castings ON movies.id = castings.movie_id
    JOIN
      actors ON castings.actor_id = actors.id
    WHERE
      actors.name = 'Art Garfunkel'
    ) AND name != 'Art Garfunkel'
  SQL
end
