CREATE TABLE IF NOT EXISTS users (
	id integer PRIMARY KEY,
	username text UNIQUE NOT NULL,
	password text NOT NULL,
	last_seen real NOT NULL,
	avatar_url text
)
