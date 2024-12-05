CREATE TABLE files (
    id VARCHAR PRIMARY KEY,
    bucket VARCHAR,
    type VARCHAR,
    size INT,
    created_at TIMESTAMP
);

CREATE TABLE file_ownerships (
    id BIGINT PRIMARY KEY,
    file_id VARCHAR REFERENCES files(id),
    user_id BIGINT REFERENCES users(id),
    refcount INT,
    UNIQUE(file_id, user_id)
);

ALTER TABLE users DROP COLUMN avatar_url;
ALTER TABLE users ADD COLUMN avatar BIGINT REFERENCES file_ownerships(id);
