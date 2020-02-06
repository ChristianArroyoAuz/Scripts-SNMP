#! /bin/bash
#========================================================================
#	ESCUELA POLITECNICA NACIONAL
#       FIEE - INGENIERIA ELECTRONICA Y REDES DE INFORMACION
#	ADMINISTRACION DE REDES
#	
#	Arroyo Auz Christian Xavier
#		(2017 - B)
#========================================================================

#========================================================================
# Limpiamos el espacio del shell:
clear 
# Reiniciamos el servicio snmpd para asegurarnos de que esté corriendo:
service snmpd restart
#Limpiamos nuevamente el espacio del shell:
clear
#========================================================================

	IP=$1
	mascara=$2

#==========================================================================

function menu_opciones(){
	echo "==========================================================="
	echo "                    MENU"
	echo -e " ¿Qué desea hacer con \e[32m$IP\e[0m?"
	echo -e "\e[34m  a   Características del objeto MIB.\e[0m"
	echo -e "\e[34m  b   Petición SNMP.\e[0m"
	echo -e "\e[34m  c   Exit.\e[0m"
	echo
	read -p "      ==> Ingrese el número de la opción deseada: " numero
	echo "==========================================================="

	case $numero in
		a)	
			echo "Ha escogido ver las características del objeto MIB."
			echo
			read -p "Ingrese el objeto MIB (sin el '.0' -Ejemplo. sysName):  " objMIB
			echo -e "\e[34m El OID numérico es: \e[0m" $(snmptranslate -On SNMPv2-MIB::$objMIB)
			echo -e "\e[34m El nombre es: \e[0m" $objMIB
			syntax=$(snmpwalk -v2c -c public $IP $objMIB | grep "$objMIB" | cut -d "=" -f 2)
			echo -e "\e[34m Su SYNTAX es: \e[0m" $syntax
			echo
			read -p " Presione la tecla 'ENTER' para continuar "
			clear
			menu_opciones
			;;
		b)
			echo "  Usted ha escogido realizar una petición SNMP."
			echo "  Por defecto se realiza una petición SET"
			read -p "  Escriba la versión del protocolo (ej. v1, v2c):   " version
			read -p "  Escriba el nombre de la comunidad (ej. public):   " comunidad
			read -p "  Escriba el nombre del grupo MIB (ej. userGroup):  " grupo
			read -p "  Escriba el objeto MIB string(ej. sysName.0):      " oid
			read -p "  Escriba un valor de acuerdo al tipo string:       " valor
			snmpset -$version -c $comunidad $IP $oid s $valor			
			echo
			read -p "Presione la tecla 'ENTER' para continuar "
			clear
			menu_opciones
			;;
		c)
			clear
			exit
			;;
		*)
			clear
			echo -e "\e[31m ============================================================\e[0m"
			echo -e "\e[31m ||   ===>  ¡No existe la opcion $numero!           \e[0m"
			echo -e "\e[31m ||   ===>  Escoja una de las opciones del menú:    \e[0m"
			echo -e "\e[31m ============================================================\e[0m"
			menu_opciones
			;;
	esac			
}
#==========================================================================

if [ $# -lt 2 ] 
	then
		echo -e "\e[31m ERROR: No se han ingresado los dos parámetros.\e[0m"
		exit
	else
		echo "Los hosts activos dada la red a la que pertenece $IP son:"
		echo -e "\e[31m (Esto puede tardar un momento...)\e[0m"
		nmap -sn $IP $mascara | grep "Nmap scan" | cut -d " " -f 5		
		echo
		read -p "Ingrese a continuación cualquiera de las IP mostradas arriba: " ip2
		IP=$ip2		
		clear
		menu_opciones
		
fi
