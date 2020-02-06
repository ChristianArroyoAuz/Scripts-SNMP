#Presentar un menu que se ejecute indefinidamente; el menu tiene las siguientes opciones.
#1. puertos tcp activos del host
#2. puertos udp activos del host
#3. peticion snmp.
#4. salir


#1. Permite el ingreso de una IP e indica si esta activa o no. Imprime en pantalla.
# en caso de estar activo el host, muestra los puertos activos tcp.
# en el caso ocntrario imprime HOST INACTIVO.

#2. LO MISMO CON UDP 

#3. PERMITE EL INGRESO DE UNA IP y de un oid para realizar una peticion set que debera ser manejada transparentemente de tal forma que el usuario solo ingrese la dir IP, el oid y el valor de la variable a modificar.El resultado se muestra en pantalla.

#ademas se muestra el tipo de dato y acceso del oid especificado.

#4. Es la unica forma de salir del script.
if [ $# = 0 ]
	then
		echo Debió haber ingresado una clave
	else 
		if [ $1 = "Christian" ]
then 

while [ "$salir" != "Si" ]
do
echo 
echo ------------------ REPASO PRUEBA 1 -----------------------
echo Realizado por: Christian Xavier Arroyo Auz
echo EPN 2017
echo ----------------------------------------------------------
echo
echo Porfavor seleccione la opción que desea realizar
echo 
echo 1. PUERTOS TCP ACTIVOS DEL HOST
echo 2. PUERTOS UDO ACTIVOS DEL HOST
echo 3. PETICIÓN SNMP
echo 4. SALIR
echo

read opcion 
case $opcion in 
1) 
	echo Ingrese porfavor una dirección IPv4:
	read IP
	resultado=$( nmap $IP | grep 'Host is up' | cut -d " " -f 3 )
	if [ "$resultado" = "up" ]
	then
		echo El host con IPv4: $IP se encuentra $resultado
		echo Los puertos TCP activos del host $IP son:
		echo		
		nmap -sT $IP | grep 'open' | cut -d " " -f 1,2,3,4,5,6
	
	else
		echo El host ingresado no es valido o está inactivo
	fi
;;

2)
	echo Ingrese porfavor una dirección IPv4:
	read IP
	resultado=$( nmap $IP| grep 'Host is up' | cut -d " " -f 3 )
	if [ "$resultado" = "up" ]
	then
		echo El host con IPv4: $IP se encuentra $resultado
		echo Los puertos UDP activos del host $IP son:
		nmap -sU $IP | grep 'open' | cut -d " " -f 1,2,3,4,5,6
	
	else
		echo El host ingresado no es valido o está inactivo
	fi
;;

3)
	echo Ingrese porfavor una dirección IPv4:
	read IP
	echo Ingrese porfavor un OID 
	echo Ejemplo: sysName.0
	read OID
	echo Ingrese el valor con el que desea modifar el OID
	read valor
	echo El tipo de acceso del OID es:	
	snmpset -v 2c -c public $IP +$OID s $valor | cut -d " " -f 1,2,3
	echo Como se puede verificar el valor cambiado ha sido:
	snmpget -v 2c -c public $IP $OID 
	echo El tipo de acceso es:
	snmptranslate -On -Td -Ib $OID | grep 'MAX-ACCESS' | cut -d " " -f 2
;;

4)
	echo Desea salir de la aplicación [Si/No]
	read salir
;;

*) 
	echo Esta no es ninguna opción válida, favor presionar una opción del menú.
;;

esac
done
else 
	echo NO es la clave correcta
fi 
fi 	
	
	


