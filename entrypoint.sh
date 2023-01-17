#!/bin/bash
set -eu

SSHPATH="$HOME/.ssh"
mkdir "$SSHPATH"
echo "$SSH_PRIVATE_KEY" > "$SSHPATH/key"
chmod 600 "$SSHPATH/key"
SERVER_DEPLOY_STRING="$REMOTE_USER@$REMOTE_HOST:$TARGET_DIRECTORY"

# Run Rsync synchronization
sh -c "sudo rsync $ARGS -e 'ssh -i $SSHPATH/key -o StrictHostKeyChecking=no -p $REMOTE_HOST_PORT' . $SERVER_DEPLOY_STRING"
sh -c "sudo php artisan config:cache"
sh -c "sudo php artisan config:cache"
sh -c "sudo php artisan view:cache"
sh -c "sudo chown www-data:www-data -R /var/www/carloseduardo.tech"


