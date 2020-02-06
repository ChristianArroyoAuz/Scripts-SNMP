	echo "****************************************"

	while [ "$literal" != "d" ]

	do
	
	echo "------------------Menú------------------"
	echo "a. Puertos TCP activos del HOST"
	echo "b. Puertos UDP activos del HOST"
	echo "c. Petición SNMP"
	echo "d. Salir"
	echo "----------------------------------------"
	echo "Escoja un literal: "
	
	read literal 
	
	case $literal in

	a)

		clear

		echo " Ingrese una dirección Ip: "
		read dirIP
		estado=$(nmap $dirIP | grep Host | cut -d " " -f 3)

		if [[ "$estado" == up ]]
		
			then
				clear
				echo "Host Activo!"
				echo "Puertos activos TCP:"
				nmap $dirIP   | grep open | grep tcp
			else
				clear
				echo "Host Inactivo!"
			fi
				echo "Presione Enter para volver al menú"   
				read blanco
				clear    

	;;

	b)

		clear

		echo " Ingrese una dirección Ip: "
		read dirIP
		estado=$(nmap $dirIP | grep Host | cut -d " " -f 3)

		if [[ "$estado" == up ]]
		
			then				
				echo "Host Activo!"		
				echo "Puertos activos UDP:"
				nmap $dirIP   | grep open | grep udp				
			else				
				echo "Host Inactivo!"
			fi
				echo "Presione Enter para volver al menú"   
				read blanco
				clear    
		
	;;

	c)

			clear

			echo "Ingrese una dirección IP: "					
			read dirIP
			
			echo "Ingrese un OID: "
			echo "(Ej. sysDescr)"
			read OID
			
			echo "Ingrese el valor de la variable a modificar:"
			echo "(Ej: Nombre)"
			read valor
			
			tipodato=$(snmpget -v 1 -c public $dirIP $OID.0 | cut -d "=" -f 2 | cut -d ":" -f 1 | tr [:upper:] [:lower:])
			
			set=$(snmpset -v 1 -c public $dirIP $OID.0 $tipodato $valor)
			
			#echo $set   
			
			echo "El tipo de dato de la OID es:"  
			echo $tipodato 			
			

			echo "El tipo de Acceso es:"
			
			acceso=$(snmpset -v 1 -c public $dirIP $OID.0 $tipodato $valor| grep = | cut -d " " -f 2)

			if [[ "$acceso" ==  "" ]] 
			
			then
				echo "Lectura "
				echo "Presione Enter para volver al menú"  
				read blanco
				clear
			else
		
    		       	        echo "Lectura y escritura" 
				echo "Presione Enter para volver al menú"   
				read blanco
				clear    	
			
			fi 		
					
	;;

	d)

		echo "Gracias por utilizar nuestro servicio!"
	
		exit 0

	;;

	*)

		echo  "No se escogió ningún literal válido!"
	;;
esac

done

exit



