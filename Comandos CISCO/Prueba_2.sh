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
	echo "a. Mostrar Usuarios Creados Agente Cisco"
	echo "b. Mostrar los objetos MIBs cargados en el IOS de CISCO"
	echo "c. Salir"
	echo "------------------------------------------------------"
	read -p "Escoja una Opcion: " Opcion 	
	case $Opcion in
	a)
		clear
		echo "Ingrese la direccion IP de Agente Cisco: " DIRECCION_IP
		echo "Lista de Usuarios: "
		echo "TIC_ARROYO"
		echo "TIC_AUZ"
		echo "TIC_ARROYO_AUZ"
		echo "REDES_TIC"
		read -p "Presione Enter Para Volver Al Menú." blanco
	;;
	b)
		clear
		read -p "Ingrese el nombre de Usuario: " NOMBRE_USUARIO
		read -p "Ingrese el OID (.1.3.6.1 ó sysName.0): " OID
		echo ""
snmpwalk -v3 -u $NOMBRE_USUARIO -l AuthPriv -a MD5 -A 123456789000 -x DES -X 123456789000 192.168.100.1 $OID
snmpwalk -v3 -u $NOMBRE_USUARIO -l AuthNoPriv -a SHA -A 123456789000 192.168.100.1 $OID
snmpwalk -v3 -u $NOMBRE_USUARIO -l AuthPriv -a SHA -A 123456789000 -x AES128 -X 123456789000 192.168.100.1 $OID
		echo ""
		read -p "Presione Enter Para Volver Al Menú." blanco
		;;
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
