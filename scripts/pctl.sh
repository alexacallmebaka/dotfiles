#!/bin/sh

top_player=spotifyd

case $1 in

    "top")
    PLAYER="playerctl --player=$top_player,%any"
    ;;

    "middle")
    PLAYER="playerctl --ignore-player=$top_player"
    ;;

    "bottom")
    PLAYER="playerctl  --player=mpv,%any"
    ;;

esac

case $2 in

    "next")
    $PLAYER next
    ;;

    "prev")
    $PLAYER previous
    ;;

    "toggle")
    case $( $PLAYER status ) in
    
    "Playing")
        $PLAYER pause
        ;;

    "Paused")
        $PLAYER play
        ;;
    
    esac
    ;;

esac
