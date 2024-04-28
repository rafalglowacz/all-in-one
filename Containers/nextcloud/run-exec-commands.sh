#!/bin/bash

# Wait 15s for domain to be reachable
sleep 15

if [ -n "$NEXTCLOUD_EXEC_COMMANDS" ]; then
    echo "#!/bin/bash" > /tmp/nextcloud-exec-commands
    echo "$NEXTCLOUD_EXEC_COMMANDS" >> /tmp/nextcloud-exec-commands
    if ! grep "one-click-instance" /tmp/nextcloud-exec-commands; then
        bash /tmp/nextcloud-exec-commands
        rm /tmp/nextcloud-exec-commands
    fi
else
    # Collabora must work also if using manual-install 
    if [ "$COLLABORA_ENABLED" = yes ]; then
        echo "Activating Collabora config..."
        php /var/www/html/occ richdocuments:activate-config
    fi
    # OnlyOffice must work also if using manual-install
    if [ "$ONLYOFFICE_ENABLED" = yes ]; then
        echo "Activating OnlyOffice config..."
        php /var/www/html/occ onlyoffice:documentserver --check
    fi
fi

sleep inf
