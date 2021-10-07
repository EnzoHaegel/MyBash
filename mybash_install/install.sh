

error() {
    if [ -z "$1" ]; then
        echo "Veuillez mettre votre nom d'utilisateur en paramètre."
        return 1
    fi
    if [ ! -d "/c/Users/$1" ]; then
        echo "Ce nom d'utilisateur n'existe pas :/"
        return 1
    fi
    return 0
}

replace() {
    for entry in `ls $1`; do
        if [ -f "$1/$entry" ]; then
            save=`cat $1/$entry`
            echo "${save//ehaegel/$2}" > "$1/$entry"
        fi
        if [ -d "$1/$entry" ]; then
            echo "$1/$entry"
            replace "$1/$entry" "$2"
        fi
    done
}

error $1

if [ "$?" == "0" ]; then
    replace "." "$1"
    if [ -f "/c/Users/$1/.bashrc" ]; then
        cp "/c/Users/$1/.bashrc" "/c/Users/$1/.bashrcsave"
    fi
    cp "bashrc" "/c/Users/$1/.bashrc"
    if [ -d "/c/Users/$1/scripts" ]; then
        cp -r "/c/Users/$1/scripts" "/c/Users/$1/scripts_save"
    fi
    cp "scripts" "/c/Users/$1/scripts"
fi
