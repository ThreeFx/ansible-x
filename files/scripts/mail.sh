#!/bin/bash

if [[ $1 == "new" ]]; then
    mails=`find ~/private/mail/maildir/*/new/ -type f | grep -v Trash | wc -l`
elif [[ $1 == "unread" ]]; then
    mails=`find ~/private/mail/maildir/*/cur/ -type f | grep '.*,$' | grep -v Trash | wc -l`
else
    echo "Parameter unknown: $1"
    echo "Usage: mail.sh [new | unread]"
    exit 1
fi

if [[ $mails == "0" ]]; then
    echo "no $1 mails"
elif [[ $mails == "1" ]]; then
    echo "1 $1 mail"
else
    echo "$mails $1 mails"
fi
