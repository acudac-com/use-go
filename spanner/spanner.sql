create role {product};
create schema {product}_use;
grant select,insert,update,delete on all tables in schema {product}_use to role {product};

create table {product}_use.users (
    user_id string(max),
    name string(max),
    created timestamp,
    creater string(max),
    updated timestamp,
    updater string(max),
) primary key (user_id);

create table {product}_use.emails (
    user_id string(max),
    email string(max),
    verified bool,
    created timestamp,
) primary key (user_id,email),
interleave in parent {product}_use.users on delete cascade;

create table {product}_use.sessions (
    user_id string(max),
    session_id string(max),
    secret string(max),
    created timestamp,
) primary key (user_id,session_id),
interleave in parent {product}_use.users on delete cascade;

create table {product}_use.user_files (
    user_id string(max),
    file_id string(max),
    ext string(max),
    size int64,
    created timestamp,
    updated timestamp,
) primary key (user_id,file_id),
interleave in parent {product}_use.users on delete cascade;

create table {product}_use.devices (
    user_id string(max),
    device_id string(max),
    refresh_token string(max),
    refreshed timestamp,
    created timestamp
) primary key (user_id, device_id),
interleave in parent {product}_use.users on delete cascade;

create table {product}_use.accounts (
    account_id string(max),
    name string(max),
    created timestamp,
    creater string(max),
    updated timestamp,
    updater string(max),
) primary key (account_id);

create table {product}_use.roles (
    account_id string(max),
    role_id string(max),
    name string(max),
    inherited_role_id string(max),
    created timestamp,
    creater string(max),
    updated timestamp,
    updater string(max),
    constraint fk_inherited_role_id foreign key (account_id,inherited_role_id)
  REFERENCES {product}_use.roles (account_id,role_id) enforced
) primary key (account_id, role_id);

create table {product}_use.role_permissions (
    account_id string(max),
    role_id string(max),
    permission_id string(max),
    description string(max),
) primary key (account_id, role_id, permission_id);

create table {product}_use.machines (
    account_id string(max),
    machine_id string(max),
    name string(max),
    created timestamp,
    creater string(max),
    updated timestamp,
    updater string(max),
) primary key (account_id, machine_id);

create table {product}_use.account_users (
    account_id string(max),
    user_id string(max),
    role_id string(max),
) primary key (account_id, user_id, role_id);
