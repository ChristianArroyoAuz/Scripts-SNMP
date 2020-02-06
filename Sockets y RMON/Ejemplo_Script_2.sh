#################################################################################
#                     ADMINISTRACIÓN Y GESTIÓN DE REDES			#										#
echo "-- BIENVENIDO --"

result=$(ping -c1 $1 | cut -s -f 2 -d ",")
cade= "1 received"
if [ "$result" == "$cade" ]
then
echo "Host $1 inactivo"
exit
else
echo "Host $1 activo"
echo "Ingrese el nodo MIB"
read nodo
snmpwalk -v 1 -c public $1 $nodo
exit
fi
echo "Direcciones IP activas"
sleep 5
nmap -v -sP 172.31.10.0/24 | grep up
echo "escuchando puertos ssh y http"
sleep 5
nmap -v -p 80,22 172.31.10.0/24