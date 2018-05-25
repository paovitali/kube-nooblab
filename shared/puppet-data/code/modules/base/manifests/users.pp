class base::users {

#create_resources('group', hiera_hash('groups'))
create_resources('user', hiera_hash('users'))
create_resources('file', hiera_hash('ssh_dirs'))
create_resources('file', hiera_hash('ssh_file_authorized_keys'))

}

