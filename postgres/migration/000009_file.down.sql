ALTER TABLE users DROP COLUMN avatar;
ALTER TABLE users ADD COLUMN avatar_url VARCHAR;
DROP TABLE file_ownerships;
DROP TABLE files;
