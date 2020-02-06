#!/bin/bash


while [ "$opcion" != "4" ]
do

echo "Menu"
echo "1. Observar las MIBs system para el caso noauthnopriv"
echo "2. Observar las MIBs interface y cisco el caso authpriv"
echo "3. Observar los Logs "
echo "4. Salir"
echo ""
echo "Seleccione su opcion"
read opcion



	case $opcion in
	1)
			echo "Digite la IP de la interfaz del router"
			read ip
			echo "Ingrese su usuario"
			read user
   			
			snmpwalk -v 3 -u $user -l noauth $ip system
			echo 
			;;	

			
	2)
			echo "Digite la IP de la interfaz del router"
			read ip
			echo "Ingrese su usuario"
			read user
			echo "Ingrese su contrasena de autenticacion"
			read auth
			echo "Ingrese su contrasena de encripcion"
			read encrip
			echo "OBSERVE MIBs INTERFACES"
			snmpwalk -v 3 -u $user -l priv -a MD5 -A $auth -x AES -X $encrip $ip interfaces

			echo "OBSERVE MIBs CISCO"
			snmpwalk -v 3 -u $user -l priv -a MD5 -A $auth -x AES -X $encrip $ip enterprises.9.9.109.1.2.1.1.2.1
			echo 
			;;

	3)              
			
			echo "Digite la IP de la interfaz del router "
			read ip			
			echo "SE TIENE LOS SIGUIENTES LOGS y TRAP EN EL DISPOSITIVO $ip"
			tail /var/log/router.log
			echo
			;;
	
	4)		
		exit	
		echo 
		;;

    
	esac


done
echo ""
echo ***********************************************
echo "Hasta pronto, gracias por utilizar este script"
echo ***********************************************
