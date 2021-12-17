CREATE TABLE IF NOT EXISTS keys (
	key_id integer PRIMARY KEY,
	user_id integer NOT NULL,
	pub_key text,
	FOREIGN KEY (user_id) REFERENCES users (user_id)
)
