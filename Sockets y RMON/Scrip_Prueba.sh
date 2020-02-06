clear
echo ""
echo ""
echo "******************************************************"
echo "*	           Prueba Practica N_1               *"
echo "*	      Arroyo Auz Christian Xavier.           *"
echo "******************************************************"
echo ""
echo ""
read -p "Ingrese la Contraseña: " password
if test "$password" = "1234"
	then
	while [ "$Opcion" != "p" ]
	do
	clear
	echo ""
	echo ""
	echo "******************************************************"
	echo "*	           Prueba Practica N_1               *"
	echo "*	      Arroyo Auz Christian Xavier.           *"
	echo "******************************************************"
	echo ""
	echo ""	
	echo "-------------------------Menú-------------------------"
	echo "a. Puertos TCP activos del HOST"
	echo "b. Puertos UDP activos del HOST"
	echo "c. Petición SNMP"
	echo "d. Puerto Activo ó Desactivo en el HOST"
	echo "e. HOST Activo ó Desactivo"
	echo "f. Protocolos Activos del HOST en el Rango 1 a 1024"
	echo "g. Trafico en las Interfaces de Entrada del HOST"
	echo "h. Consulta SNMPWALK en Cualquier HOST"
	echo "i. Observar los Logs SNMP"
	echo "j. Guardar los Puerto Activo TCP en Un Archivo"
	echo "k. Active Internet Connections (only servers) TCP"
	echo "l. Listar los Sockets Abiertos por un Proceso"
	echo "m. Obtener las caracteristicas de un Objeto MIB"
	echo "n. Listar la lista de HOST de una red"
	echo "o. Peticion SNMP ingresando la version, comunidad, grupo, etc"	
	echo "p. Salir"
	echo "------------------------------------------------------"
	read -p "Escoja una Opcion: " Opcion 	
	case $Opcion in
	a)
		clear
		read -p "Ingrese una dirección IP: " direccion_IP
		resultado=$(nmap $direccion_IP | grep 'Host is up' | cut -d " " -f 3)
		if [ "$resultado" == "up" ]
			then
			clear
			echo "Host $direccion_IP Esta Activo...! Los Puertos Activos TCP son:"
			echo ""
			nmap -sT $direccion_IP | grep 'open' | grep tcp
		else
			clear
			echo "Host $direccion_IP Esta Inactivo...!"
		fi
			echo ""  
			read -p "Presione Enter Para Volver Al Menú." blanco
			clear;;
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
		read -p "Ingrese una dirección IP: " direccion_IP
		read -p "Ingrese un OID. Ejemplo --> sysDescr ó .1.3.6.1.2.1.1.1 : " OID
		read -p "Ingrese el valor de la variable a modificar. Ejemplo --> Nombre : " variable
		tipodato=$(snmpget -v 1 -c public $direccion_IP $OID.0 | cut -d "=" -f 2 | cut -d ":" -f 1 | tr [:upper:] [:lower:])		
		acceso=$(snmptranslate -Td -Ib $OID | grep 'MAX-ACCESS' | cut -c 14-30)		
		set=$(snmpset -v 1 -c public $direccion_IP $OID.0 $tipodato $variable)
		echo "El resultado de la modificación es: $set"	
		if [ "$acceso" ==  "read-write" ]
			then
			echo "El tipo de dato de la OID es: $tipodato, El tipo de Acceso es: Lectura y Escritura. ($acceso)"   
			read -p "Presione Enter Para Volver Al Menú." blanco
			clear
		else
			echo "El tipo de dato de la OID es: $tipodato, El tipo de Acceso es: Lectura. ($acceso)"
			read -p "Presione Enter Para Volver Al Menú." blanco
			clear		
		fi 	;;
	d)
		clear
		read -p "Ingrese el numero de puerto: " puerto
		read -p "Ingrese una dirección IP: " direccion_IP
		resultado=$(nmap -p $puerto $direccion_IP | grep 'open\|close' | cut -d " " -f 2)
		clear
		echo ""
		echo "El puerto $puerto se encuentra $resultado."
		echo ""
		read -p "Presione Enter Para Volver Al Menú." blanco
		clear
		;;
	e)	
		clear
		read -p "Ingrese la dirección IP del HOST: " direccion_IP
		resultado=$(nmap $direccion_IP | grep 'Host is up' | cut -d " " -f 3)
		if [ "$resultado" == "up" ]
			then	
			clear			
			echo "Host $direccion_IP Esta Activo...!"		
			echo ""
		else	
			clear			
			echo "Host $direccion_IP Esta Inactivo...!"
		fi
			echo ""   
			read -p "Presione Enter Para Volver Al Menú." blanco
			clear;;
	f)	
		clear
		read -p "Ingrese una dirección IP: " direccion_IP
		resultado=$(nmap -p 1-1024 $direccion_IP | grep 'open')
		if [ "$resultado" != "" ]
			then
			clear
			echo ""
			echo "Los Protocolos Activos del HOST son:"
			echo ""
			nmap -p 1-1024 $direccion_IP | grep 'open'
		else
			clear
			echo "Host $direccion_IP Esta Inactivo/Inalcansble o No Exisen Protocolos Activos...!"
		fi
			echo ""
			read -p "Presione Enter Para Volver Al Menú." blanco
			clear
			;;
	g)
		clear
		read -p "Ingrese una dirección IP: " direccion_IP
		read -p "Ingrese el numero de puerto: " puerto
		clear
		echo ""
		echo "El Trafico Por La Interfaz del HOST $direccion_IP es:"
		tcpdump -lnXvvv port $puerto and src $direccion_IP -c 6
		echo ""
		read -p "Presione Enter Para Volver Al Menú." blanco
		clear
		;;
	h)
		clear
		read -p "Ingrese una dirección IP: " direccion_IP
		read -p "Ingrese el nombre de la comunidad: " comunidad
		read -p "Ingrese un OID. Ejemplo --> sysDescr ó .1.3.6.1.2.1.1.1 : " OID
		snmpwalk -v 1 -c $comunidad $direccion_IP $OID
		echo ""
		read -p "Presione Enter Para Volver Al Menú." blanco
		clear
		;;
	i)	
		clear
		echo "Se tienen los siguientes Logs de SNMP:"
		echo ""
		tail -5 /var/log/snmpd.log
		echo ""
		read -p "Presione Enter Para Volver Al Menú." blanco
		clear
		;;
	j)	
		clear
		read -p "Ingrese una dirección IP: " direccion_IP
		read -p "Ingrese el Nombre del Archivo: " archivo
		nmap $direccion_IP > $archivo
		clear
		echo ""
		echo "El Archivo $archivo se a creado exitosamente."
		echo ""
		ls
		echo ""
		read -p "Presione Enter Para Volver Al Menú." blanco
		clear
		;;
	k)
		clear
		echo ""
		echo "La Conexiones Activas de Internet con TCP son:"
		echo ""
		netstat -ln --tcp
		echo ""
		read -p "Presione Enter Para Volver Al Menú." blanco
		clear
		;;
	l)	
		clear
		echo ""
		read -p "Ingresar el nombre del proceso. Ejemplo: snmpd : " proceso
		echo ""
		echo "Los sockets abiertos por el proceso $proceso son:"
		lsof -i -n -P | grep $proceso
		echo ""
		read -p "Presione Enter Para Volver Al Menú." blanco
		clear
		;;
	m)
		clear
		echo ""
		read -p "Ingrese una dirección IP: " direccion_IP
		read -p "Ingrese un OID. Ejemplo --> sysDescr ó .1.3.6.1.2.1.1.1 : " OID
		clear
		echo ""		
		echo "El OID numérico es: " $(snmptranslate -On SNMPv2-MIB::$OID)
		echo "El nombre es: " $OID
		resultado=$(snmpwalk -v2c -c public $direccion_IP $OID | grep "$OID" | cut -d "=" -f 2)
		echo "Su SYNTAX es: " $resultado
		echo ""
		read -p "Presione Enter Para Volver Al Menú." blanco
		clear
		;;
	n)
		clear
		echo ""
		read -p "Ingrese una dirección IP y su mascara. Ejemplo--> 127.0.0.1/24: " direccion_IP
		echo ""
		echo "Los hosts activos dada la red a la que pertenece $direccion_IP son:"
		nmap -sn $direccion_IP | grep "Nmap scan" | cut -d " " -f 5		
		echo ""
		read -p "Presione Enter Para Volver Al Menú." blanco
		clear
		;;
	o)	
		clear
		echo ""
		read -p "Ingrese una dirección IP: " direccion_IP
		read -p "Escriba la versión del protocolo (ej. v1, v2c): " version
		read -p "Escriba el nombre de la comunidad (ej. public): " comunidad
		read -p "Escriba el nombre del grupo MIB (ej. userGroup): " grupo
		read -p "Escriba el objeto MIB string(ej. sysName.0): " oid
		read -p "Escriba un valor de acuerdo al tipo string: " valor
		echo ""
		set=$(snmpset -$version -c $comunidad $direccion_IP $oid string $valor)
		echo "El resultado de la modificación es: $set"			
		echo ""
		read -p "Presione Enter Para Volver Al Menú." blanco
		clear
		;;
	p)
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

else
	echo ""
	echo "Contraseña Incorrecta. Intentelo Otra vez."
	echo ""
	sleep 3
	./Scrip_Prueba.sh
fi
