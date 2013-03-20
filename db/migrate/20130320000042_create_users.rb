class CreateUsers < ActiveRecord::Migration
  def change
    execute <<EOF

create table users(
  id                serial not null,
  email             text not null,
  password_digest   text not null,
  token             text not null,
  created_at        timestamp with time zone not null,
  updated_at        timestamp with time zone not null,
  primary key(id)
);

create unique index users_lower_email_idx on users (lower(email));
create unique index users_token on users (token);

EOF
    
  end
end
