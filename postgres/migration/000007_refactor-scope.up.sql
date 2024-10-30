ALTER TABLE refresh_tokens RENAME COLUMN refresh_token_id TO id;
ALTER TABLE refresh_tokens ADD COLUMN user_id BIGINT REFERENCES users(id);
ALTER TABLE refresh_tokens ADD COLUMN expires_at timestamp;
ALTER TABLE refresh_tokens ADD COLUMN scope VARCHAR;

ALTER TABLE refresh_tokens RENAME TO oauth2_refresh_tokens;

ALTER TABLE oauth2_clients ADD COLUMN is_admin BOOLEAN;
ALTER TABLE oauth2_clients DROP COLUMN allowed_scope;
