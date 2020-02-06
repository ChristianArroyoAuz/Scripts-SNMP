#Presentar un menu que se ejecute indefinidamente; el menu tiene las siguientes opciones.
#a. puertos tcp activos del host
#b. puertos udp activos del host
#c. peticion snmp.
#d. salir


#a. Permite el ingreso de una IP e indica si esta activa o no. Imprime en pantalla.
# en caso de estar activo el host, muestra los puertos activos tcp.
# en el caso ocntrario imprime HOST INACTIVO. En el caso de estar activo el host muestra en pantalla
# los puertos TCP activos del mismo

#b. LO MISMO que a CON UDP 

#c. PERMITE EL INGRESO DE UNA IP y de un oid para realizar una peticion set que debera ser manejada transparentemente de tal forma que el usuario solo ingrese la dir IP, el oid y el valor de la variable a modificar.El resultado se muestra en pantalla.

#ademas se muestra el tipo de dato y acceso del oid especificado.

#d. Es la unica forma de salir del script.

while [ "$salir" != "Si" ]
do
echo 
echo --------------------- PRUEBA 1 -------------------------
echo Realizado por: Christian Xavier Arroyo Auz
echo              ADMININISTRACIÓN DE REDES
echo		            EPN 2017
echo ----------------------------------------------------------
echo
echo Porfavor seleccione la opción que desea realizar
echo 
echo a. PUERTOS TCP ACTIVOS DEL HOST
echo b. PUERTOS UDO ACTIVOS DEL HOST
echo c. PETICIÓN SNMP
echo d. SALIR
echo

read eleccion 
case $eleccion in 
a) 
	echo Ingrese porfavor una dirección IPv4:
	read IP
	respuesta=$( nmap $IP | grep 'Host is up' | cut -d " " -f 3 )
	if [ "$respuesta" = "up" ]
	then
		echo
		echo El host con IPv4: $IP se encuentra $respuesta
		echo Los puertos TCP activos del host $IP son:
		echo		
		nmap -sT $IP | grep 'open' | cut -d " " -f 1,2,3,4,5,6
	
	else
		echo El host ingresado no es valido o está inactivo
	fi
;;

b)
	echo Ingrese porfavor una dirección IPv4:
	read IP
	respuesta=$( nmap $IP| grep 'Host is up' | cut -d " " -f 3 )
	if [ "$respuesta" = "up" ]
	then
		echo El host con IPv4: $IP se encuentra $resultado
		echo Los puertos UDP activos del host $IP son:
		echo
		nmap -sU $IP | grep 'open' | cut -d " " -f 1,2,3,4,5,6
	
	else
		echo El host ingresado no es valido o está inactivo
	fi
;;

c)
	echo Ingrese porfavor una dirección IPv4:
	read IP
	echo Ingrese porfavor un OID 
	echo Ejemplo: sysName, sysLocation, etc.
	read OID
	echo Ingrese el valor con el que desea modifar el OID
	read valor
	echo
	echo El tipo de dato del OID es:	
	snmpset -v 2c -c public $IP $OID'.0' s $valor | cut -d " " -f 1,2,3
	echo	
	echo Como se puede verificar el valor cambiado ha sido:
	snmpget -v 2c -c public $IP $OID'.0' 
	echo
	echo El tipo de acceso es:
	snmptranslate -On -Td -Ib $OID | grep 'MAX-ACCESS' | cut -d " " -f 3
;;

d)
	echo Desea salir de la aplicación [Si/No]
	read salir
;;

*) 
	echo Esta no es ninguna opción válida, favor presionar una opción del menú.
;;

esac
done
 	
	
	


