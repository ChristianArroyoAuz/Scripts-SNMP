if [ $# -lt 2 ]
	then
		clear
		echo ""
		echo "******************************************************"
		echo "*	           Prueba Practica N_1               *"
		echo "*	      Arroyo Auz Christian Xavier.           *"
		echo "*		 Administracion de Redes             *"
		echo "******************************************************"
		echo ""
		echo ""
		echo "No se han ingresado los dos parámetros."
		echo "Debe ingresar una direccion IP y su mascara."
		echo "Ejemplos:"
		echo "sh Arroyo_Christian.sh 127.0.0.1 /24"
		echo "./Arroyo_Christian.sh 10.0.215 /24"
		echo ""
		exit 
	else
		direccion=$1
		mascara=$2
		clear
		echo ""
		echo "Los hosts activos dada la red a la que pertenece $direccion son:"
		resultado=$(nmap -sn $direccion$mascara | grep "Nmap scan" | cut -d " " -f 5)
		if [ "$resultado" != "" ]
			then
			echo "$resultado"
			echo ""
			read -p "Ingrese una de la direcciones IP de la lista: " direccion_IP
			clear
			while [ "$Opcion" != "c" ]
			do
			clear
			echo ""
			echo ""
			echo "******************************************************"
			echo "*	           Prueba Practica N_1               *"
			echo "*	      Arroyo Auz Christian Xavier.           *"
			echo "*		 Administracion de Redes             *"
			echo "******************************************************"
			echo ""
			echo "-------------------------Menú-------------------------"
			echo "a. Caracteristicas de Objeto MIB"
			echo "b. Peticion SNMP"	
			echo "c. Salir"
			echo "------------------------------------------------------"
			read -p "Escoja una Opcion: " Opcion 	
			case $Opcion in
			a)
				clear
				echo ""
				read -p "Ingrese un OID. Ejemplo --> sysName: " OID
				clear
				echo ""
				if [[ $OID == *"if"* ]]
					then
					consulta=$(snmptranslate -On IF-MIB::$OID)
				else
					consulta=$(snmptranslate -On SNMPv2-MIB::$OID)
				fi
				echo "El OID numérico es: " $consulta
				echo "El Nombre del Objeto MIB es: " $(snmptranslate -Of $consulta)
				resultado=$(snmptranslate -On -Td -Ib $OID | grep 'SYNTAX' | cut -c 10-50)
				echo "Su SYNTAX es: " $resultado
				echo ""
				read -p "Presione Enter Para Volver Al Menú." blanco
				clear
				;;
			b)
				clear
				echo ""
				read -p "Escriba la versión del protocolo (ej. v1, v2c): " version
				read -p "Escriba el nombre de la comunidad (ej. public): " comunidad
				read -p "Escriba el objeto MIB string(ej. sysName.0): " oid
				echo ""
				get=$(snmpgetnext -$version -c $comunidad $direccion_IP $oid)
				echo "El resultado de la consulta es: $get"			
				echo ""
				read -p "Presione Enter Para Volver Al Menú." blanco
				clear
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
		else
			echo "No Existen HOST Actinos en la red $direccion$mascar"
		fi		
fi
