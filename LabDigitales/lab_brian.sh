#!/bin/bash

## ARGS

COMMAND=$1

## VARS

DIR='nfs_client' # Directorio local
SERVERDIR='/home/brjmm-arch/nfs_server' # Directorio en el servidor

## MAIN THREAD

case "$COMMAND" in
    mount)
	echo 'Mount NFS directory'
	if [ -e nfs_client ] # Si existe el directorio
	then
	    sudo mount -t nfs -o intr,soft,timeo=5,retrans=5,actimeo=10,retry=3  "192.168.16.172:""$SERVERDIR" "$DIR"
	else # Si no existe el directorio
	    mkdir nfs_client	    
	    sudo mount -t nfs -o intr,soft,timeo=5,retrans=5,actimeo=10,retry=3 "192.168.16.172:""$SERVERDIR" "$DIR"		
	fi
	;;    
    umount)
	echo 'Umount NFS directory'
	sudo umount "$DIR"
	;;
    *)
	echo " Usage: $( echo $0 | grep -o [A-Za-z0-9\._-]*$) <INNERCOMMAND>
	Inner commands interpretation:
		    mount		Mount NFS server directory
		    umount		Umount NFS server directory
		    help		Show this help message
	"	
    ;;
esac
    
exit 0 # Fin de la ejecución
