ALTER TABLE oauth2_clients ADD COLUMN allowed_scope VARCHAR DEFAULT '*';
ALTER TABLE oauth2_clients DROP COLUMN is_admin;

ALTER TABLE oauth2_refresh_tokens RENAME COLUMN id TO refresh_token_id;
ALTER TABLE oauth2_refresh_tokens DROP COLUMN user_id;
ALTER TABLE oauth2_refresh_tokens DROP COLUMN expires_at;
ALTER TABLE oauth2_refresh_tokens DROP COLUMN scope;

ALTER TABLE oauth2_refresh_tokens RENAME TO refresh_tokens;
