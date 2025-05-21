create role packages;
create schema packages_use;
grant select,insert,update,delete on all tables in schema packages_use to role packages;

create table packages_use.users (
    user_id string(max),
    name string(max),
    created timestamp,
    creater string(max),
    updated timestamp,
    updater string(max),
    blocked bool,
) primary key (user_id);

create table packages_use.emails (
    user_id string(max),
    email string(max),
    created timestamp,
    verified timestamp,
) primary key (user_id,email),
interleave in parent packages_use.users on delete cascade;

create table packages_use.sessions (
    user_id string(max),
    session_id string(max),
    secret string(max),
    created timestamp,
) primary key (user_id,session_id),
interleave in parent packages_use.users on delete cascade;

create table packages_use.user_files (
    user_id string(max),
    file_id string(max),
    ext string(max),
    size int64,
    created timestamp,
    updated timestamp,
) primary key (user_id,file_id),
interleave in parent packages_use.users on delete cascade;

create table packages_use.devices (
    user_id string(max),
    device_id string(max),
    refresh_token string(max),
    refreshed timestamp,
    created timestamp
) primary key (user_id, device_id),
interleave in parent packages_use.users on delete cascade;

create table packages_use.accounts (
    account_id string(max),
    name string(max),
    created timestamp,
    creater string(max),
    updated timestamp,
    updater string(max),
) primary key (account_id);

create table packages_use.roles (
    account_id string(max),
    role_id string(max),
    name string(max),
    inherited_role_id string(max),
    created timestamp,
    creater string(max),
    updated timestamp,
    updater string(max),
    constraint packages_use_fk_inherited_role_id foreign key (account_id,inherited_role_id)
  REFERENCES packages_use.roles (account_id,role_id) enforced
) primary key (account_id, role_id),
interleave in parent packages_use.accounts on delete cascade;

create table packages_use.permissions (
    account_id string(max),
    role_id string(max),
    permission_id string(max),
    description string(max),
) primary key (account_id, role_id, permission_id),
interleave in parent packages_use.roles on delete cascade;

create table packages_use.machines (
    account_id string(max),
    machine_id string(max),
    name string(max),
    refresh_token string(max),
    created timestamp,
    creater string(max),
    updated timestamp,
    updater string(max),
    refreshed timestamp,
    blocked bool,
) primary key (account_id, machine_id),
interleave in parent packages_use.accounts on delete cascade;

create table packages_use.account_users (
    account_id string(max),
    user_id string(max),
    role_id string(max),
    constraint package_use_fk_user_id foreign key (user_id)
    references packages_use.users (user_id) enforced,
    constraint package_use_fk_role_id foreign key (account_id,role_id)
    references packages_use.roles (account_id,role_id) enforced,
) primary key (account_id, user_id, role_id),
interleave in parent packages_use.accounts on delete cascade;
