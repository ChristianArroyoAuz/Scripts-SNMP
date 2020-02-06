# Condicion para la ejecucion del programa
# # es un meta caracter que se le carga un argumento de entrada en el programa
# $# verifica si el programa tiene argumentos de entrada o no
# Si no tiene argumentos se debe ingresar argumentos y termina el if con el fi
if [ $# = 0 ]
	then 
	echo debes introducir al menos un argumento
	exit 1
	fi

# @ es un meta caracter que se le carga todos los argumentos que se hayan ingresado
# lazo que esta en funcion de todos las variables que hayamos cargado
for i in $@
	do 
     	if [ -f "$1" ]
	then
	#es un archivo regular
	echo -n "$1 en un archivo regular"
	
	if [ -x $1 ]
	then 
	echo "ejecutable"
	else 
	echo "no ejecutable"
	fi
	
	elif [ -d "$1" ]
	then
	# es un directorio 
	echo "$1 es un directorio"
	else 
	# es una cosa rara
	echo "$1 en una cosa rar o no existe"
	fi
	# Ahora desplazamos los argumentos
	shift
done
