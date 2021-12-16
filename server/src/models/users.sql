CREATE TABLE IF NOT EXISTS users (
	user_id integer PRIMARY KEY,
	username text UNIQUE NOT NULL,
	password text NOT NULL,
	time_created real NOT NULL,
	avatar_url text
)
