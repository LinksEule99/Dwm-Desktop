#!/bin/bash

init_system=none
mirror_country=none
timezone=none
keyboard=none
locale=none
kernel=none
hostname=none
#rootpass=none

root_menu() {
    select_menu=$(whiptail --title "Root Menu" --menu "Choose your Preferences:" 20 60 8 \
        "init" "" \
        "mirrors" "" \
        "locals" "" \
        "disk" "" \
        "kernel" "" \
        "hostname" "" \
        "root passwd" "" \
        3>&1 1>&2 2>&3)
    case $select_menu in
        "init") init_menu ;;
        "mirrors") mirrors_menu ;;
        "locals") locals_menu ;;
        "disk") disk_menu ;;
        "kernel") kernel_menu ;;
        "hostname") hostname_menu ;;
        "root passwd") root_passwd_menu ;;
    esac
}

init_menu() {
    select_menu=$(whiptail --title "Init Menu" --menu "Choose an init-system:" 20 60 8 \
        "return" "" \
        "dinit" "" \
        "openrc" "" \
        "s6-rc" "" \
        "runit" "" \
        "Systemd" "" \
        3>&1 1>&2 2>&3)
    if [[ $select_menu == return ]]; then
        root_menu
    else
        init_system=$select_menu
        root_menu
    fi
}

mirrors_menu() {
    countries=$(reflector --list-countries | sed 's/^[[:space:]]*[0-9]*[[:space:]]*//')
    select_menu=$(printf "return\n%s" "$countries" | \
        whiptail --title "Mirrors Menu" --menu "Select a Mirror:" 25 60 15 \
        $(awk '{print $0 " " ""}') \
        3>&1 1>&2 2>&3)
    if [[ "$select_menu" == "return" ]]; then
        root_menu
    else
        mirror_country="$select_menu"
        root_menu
    fi
}

locals_menu() {
    keyboard_menu() {
        mapfile -t keymaps < <(find /usr/share/kbd/keymaps/ -type f -name "*.map.gz" |
            sed 's|.*/||;s|\.map\.gz$||' | sort)
        select_menu=$(printf "return\n%s" "${keymaps[@]}" | \
            whiptail --title "Keyboard Menu" --menu "Select your layout:" 25 60 15 \
            $(awk '{print $0 " " ""}') \
            3>&1 1>&2 2>&3)
        if [ "$select_menu" != "return" ]; then
            loadkeys "$select_menu"
            keyboard="$select_menu"
        fi
        locals_menu
    }
    timezone_menu() {
        continent() {
            mapfile -t city < <(find /usr/share/zoneinfo/"$1" -type f | sed 's|/usr/share/zoneinfo/||' | sort)
            select_menu=$(printf "return\n%s" "${city[@]}" | \
                whiptail --title "Timezone Menu" --menu "Choose your timezone:" 25 60 15 \
                $(awk '{print $0 " " ""}') \
                3>&1 1>&2 2>&3)
            if [ "$select_menu" == "return" ]; then
                timezone_menu
            else
                timezone="$select_menu"
                unset -f continent
                locals_menu
            fi
        }
        mapfile -t continent < <(find /usr/share/zoneinfo/ -maxdepth 1 -type d | tail -n +2 | sed 's|.*/||')
        select_menu=$(printf "return\n%s" "${continent[@]}" | \
            whiptail --title "Continent Menu" --menu "Choose your Continent:" 25 60 15 \
            $(awk '{print $0 " " ""}') \
            3>&1 1>&2 2>&3)
        if [ "$select_menu" == "return" ]; then
            locals_menu
        else
            continent "$select_menu"
        fi
    }
    language_menu() { 
        mapfile -t locales < <(grep -E 'UTF-8' /etc/locale.gen | sed 's/#//; s/ UTF-8//')
        select_menu=$(printf "return\n%s" "${locales[@]}" | \
            whiptail --title "Language Menu" --menu "Choose your language:" 25 60 15 \
            $(awk '{print $0 " " ""}') \
            3>&1 1>&2 2>&3)
        if [ "$select_menu" == "return" ]; then
            locals_menu
        else
            locale="$select_menu"
            locals_menu    
        fi
    }
    select_menu=$(whiptail --title "Select Menu" --menu "Select an option:" 20 60 8 \
        "return" "" \
        "keyboard" "" \
        "timezone" "" \
        "language" "" \
        3>&1 1>&2 2>&3)
    case $select_menu in
        "return")
            root_menu
            unset -f keyboard_menu
            unset -f timezone_menu
            unset -f language_menu
            ;;
        "keyboard") keyboard_menu ;;
        "timezone") timezone_menu ;;
        "language") language_menu ;;
    esac
}

kernel_menu() { 
    select_menu=$(whiptail --title "Kernel Menu" --menu "Choose a Kernel:" 20 60 8 \
        "return" "" \
        "linux" "" \
        "linux-lts" "" \
        "linux-hardened" "" \
        "linux-zen" "" \
        3>&1 1>&2 2>&3)
    if [[ $select_menu == "return" ]]; then
        root_menu
    else
        kernel=$select_menu
        root_menu
    fi
}

disk_menu() { 
    select_menu=$(whiptail --title "Disk Menu" --menu "Select a layout for your disk:" 20 60 8 \
        "return" "" \
        "sys-partition" "" \
        "lvm-sys-partition" "" \
        3>&1 1>&2 2>&3)
    if [[ $select_menu == return ]]; then
        root_menu
    else 
        disk_part=$select_menu
        root_menu
    fi
}

hostname_menu() {
    select_menu=$(whiptail --title "hostname setup" \
                --inputbox "Please enter your hostname:" \
                10 60 \
                "" 3>&1 1>&2 2>&3)

if [[ $select_menu == return ]]; then
    root_menu
else
    hostname=$select_menu 8 16
fi
}

root_menu
