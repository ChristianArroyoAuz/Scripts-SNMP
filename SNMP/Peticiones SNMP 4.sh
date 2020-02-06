#presente un menu que se ejecute indefinidamente el menu tiene las siquientes opciones : (/1.5 ptos.)
#a) puertos activos 
#b) host activos 
#c) peticion snmp
#d) salir
#e)Muestra un  mensaje de los protocolos que se estan usando en la maquina de 1 a 1024
#f) Obtiene el trafico de entrada de las interfaces de la maquina 
#g)Muestra los valores red la MIB de cualquier maquina (De la red local son sysdescr)

#2)El literal a del menu permite el ingreso de un # de puerto y muestra si el puerto esta activo o no. (/2 ptos.)
#3)el literal b permite el ingreso de 1 direccion de host y muestra en pantalla si esta activo o no el host. (/2 ptos.)
#4)realizar una peticion walk ingresando como maximo el nombre de de grupo y el objeto MIb. (/4 ptos.)
#5)el literal d) es la unica forma de salir del script. (/0.5 ptos.)

while [ "$salir" != "Si" ]
do
echo 
echo ------------------ REPASO PRUEBA 2----------------------
echo Realizado por: Christian Xavier Arroyo Auz
echo EPN 2017
echo ----------------------------------------------------------
echo
echo Porfavor seleccione la opción que desea realizar:
echo a. Puertos activos del host
echo b. Host activos
echo c. peticion snmp
echo d. salir
echo e. protocolos de 1 a1024 
echo f.trafico interfaces de entrada
echo g.MIB cualquier maquina
echo

read opcion

case $opcion in

a) 
	echo Ingrese el numero de puerto
	read puerto
	echo Ingrese la IP
	read IP
	nmap -p $puerto $IP | grep 'open\|close' | cut -d " " -f 2
;;

b)

	echo Ingrese la IP del host.
	read IP
	resultado=$( nmap $IP | grep 'Host is up' | cut -d " " -f 3 )
	if [ "$resultado" != "up" ]
		then

		echo Host no activo
	else
		echo Host esta activo
	fi
;;

c)
	echo Ingrese el nombre de comunidad
	echo Ejemplo: public, private, etc.
	read Comunidad
        echo Ingrese el OID 
	echo Ej. system
	read oid 
	echo Ingrese la direccion iP
	read ip
	snmpwalk -v 1 -c $Comunidad $ip $oid 
	
;;
d)
	echo Desea Salir S o N
	read salir
        
	;;
e)
	echo Ingrese la direccion iP
	read ip
	nmap -p 1-1024 $ip | grep 'open'
;;

f)
	echo ingrese la direccion iP
	read ip
	tcpdump dst host $ip -x -vv -c 6
;;

g)
	echo Ingrese iP
	read iP
	snmpget -c public -v 1 $iP sysDescr.0	
;;
*)
	echo No es una opcion valida 
	echo 
	;;
esac
done 

