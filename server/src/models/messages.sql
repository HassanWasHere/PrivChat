CREATE TABLE IF NOT EXISTS messages (
	id integer PRIMARY KEY,
	content text NOT NULL,
	time_sent real NOT NULL,
	sender_id integer NOT NULL,
	recipient_id integer NOT NULL,
	FOREIGN KEY (sender_id) REFERENCES users (id),
	FOREIGN KEY (recipient_id) REFERENCES users (id)
);
