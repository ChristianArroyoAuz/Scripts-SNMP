	while [ "$Opcion" != "c" ]
	do
	clear
	echo ""
	echo ""
	echo "******************************************************"
	echo "*	           Prueba Practica N_2               *"
	echo "*	      Arroyo Auz Christian Xavier.           *"
	echo "******************************************************"
	echo ""
	echo ""	
	echo "-------------------------Menú-------------------------"
	echo "a. CISCO"
	echo "b. RMON"
	echo "c. Salir"
	echo "------------------------------------------------------"
	read -p "Escoja una Opcion: " Opcion 	
	case $Opcion in
	a)
	clear
	read -p "Ingrese el nombre de Usuario: " NOMBRE_USUARIO
	read -p "Ingrese el tipo de auntenticacion (NoAuthNoPriv, AuthNoPriv, AuthPriv): " AUTENTICACION	
	read -p "Ingrese Tipo de Autenticacion (MD5, SHA): " TIPO_AUTENTICACION
	read -p "Ingrese la Clave de Autenticacion: " CLAVE_1
	read -p "Ingrese el tipo de cifrado (AES, DES): " CIFRADO
	read -p "Infrese clave de cifrado: " CLAVE_2
	read -p "Ingrese una dirección IP: " DIRECCION_IP
	read -p "Ingrese el OID (.1.3.6.1 ó sysName.0): " OID
	snmpget -v3 -u $NOMBRE_USUARIO -l $AUTENTICACION -a $TIPO_AUTENTICACION -A $CLAVE_1 -x $CIFRADO -X $CLAVE_2 $DIRECCION_IP $OID
	read -p "Presione Enter Para Volver Al Menú." blanco
	;;
	b)
		clear
		read -p "Ingrese una dirección IP: " direccion_IP
		resultado=$(nmap $direccion_IP | grep 'Host is up' | cut -d " " -f 3)
		if [ "$resultado" == "up" ]
			then	
			clear			
			echo "Host $direccion_IP Esta Activo...! Los Puertos Activos UDP son:"		
			echo ""			
			nmap -sU $direccion_IP | grep 'open' | grep udp			
		else	
			clear			
			echo "Host $direccion_IP Esta Inactivo...!"
		fi
			echo ""   
			read -p "Presione Enter Para Volver Al Menú." blanco
			clear;;
	c)
		clear
		echo ""
		echo ""
		echo "Gracias Por Utilizar Este Servicio...!"
		echo ""
		echo ""
		exit 0
		;;
	*)
		echo  "No Se Escogió Ningúna Opcion Válida...!"
		sleep 3
		;;
	esac
	done
	exit
