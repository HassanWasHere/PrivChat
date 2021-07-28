CREATE TABLE IF NOT EXISTS Users (
	id integer PRIMARY KEY,
	username text UNIQUE NOT NULL,
	password text NOT NULL,
	current_key text NOT NULL,
	last_seen real NOT NULL,
	avatar_url text
)
