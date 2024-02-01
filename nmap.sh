#!/bin/bash

echo " ███▄    █ ███▄ ▄███▓▄▄▄      ██▓███     ▄▄▄█████▓▒█████  ▒█████  ██▓    "
echo " ██ ▀█   █▓██▒▀█▀ ██▒████▄   ▓██░  ██▒   ▓  ██▒ ▓▒██▒  ██▒██▒  ██▓██▒    "
echo " ▓██  ▀█ ██▓██    ▓██▒██  ▀█▄ ▓██░ ██▓▒   ▒ ▓██░ ▒▒██░  ██▒██░  ██▒██░    "
echo " ▓██▒  ▐▌██▒██    ▒██░██▄▄▄▄██▒██▄█▓▒ ▒   ░ ▓██▓ ░▒██   ██▒██   ██▒██░    "
echo " ▒██░   ▓██▒██▒   ░██▒▓█   ▓██▒██▒ ░  ░     ▒██▒ ░░ ████▓▒░ ████▓▒░██████▒"
echo " ░ ▒░   ▒ ▒░ ▒░   ░  ░▒▒   ▓▒█▒▓▒░ ░  ░     ▒ ░░  ░ ▒░▒░▒░░ ▒░▒░▒░░ ▒░▓  ░"
echo " ░ ░░   ░ ▒░  ░      ░ ▒   ▒▒ ░▒ ░            ░     ░ ▒ ▒░  ░ ▒ ▒░░ ░ ▒  ░"
echo "    ░   ░ ░░      ░    ░   ▒  ░░            ░     ░ ░ ░ ▒ ░ ░ ░ ▒   ░ ░   "
echo "          ░       ░        ░  ░                       ░ ░     ░ ░     ░  ░  "



# Verifica si nmap está instalado
if ! command -v nmap &> /dev/null; then
    echo "nmap no está instalado. Por favor, instálalo antes de usar este script."
    exit 1
fi

# Verifica si se proporcionan argumentos
if [ $# -eq 0 ]; then
    echo "Uso: $0 <comando_nmpa>"
    exit 1
fi
#!/bin/bash

# Función para validar si la dirección IP es válida
validate_ip() {
    if [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}

# Función para validar el tipo de escaneo
validate_scan_type() {
    case $1 in
        "TCP Connect"|"TCP SYN"|"TCP ACK"|"TCP Window"|"TCP Maimon"|"UDP"|"TCP Null"|"TCP Xmas"|"TCP FIN")
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Solicitar la dirección IP de destino
read -p "Introduce la dirección IP de destino: " ip
if ! validate_ip $ip; then
    echo "Dirección IP no válida. Saliendo."
    exit 1
fi

# Solicitar el tipo de escaneo
read -p "Selecciona el tipo de escaneo:
1. TCP Connect Scan
2. TCP SYN Scan
3. TCP ACK Scan
4. TCP Window Scan
5. TCP Maimon Scan
6. UDP Scan
7. TCP Null Scan
8. TCP Xmas Scan
9. TCP FIN Scan
Seleccione un número (1-9): " scan_choice

if ! validate_scan_type $scan_choice; then
    echo "Opción no válida. Saliendo."
    exit 1
fi

# Ejecutar Nmap con el tipo de escaneo seleccionado y la dirección IP de destino
case $scan_choice in
    1)
        nmap -sT $ip
        ;;
    2)
        nmap -sS $ip
        ;;
    3)
        nmap -sA $ip
        ;;
    4)
        nmap -sW $ip
        ;;
    5)
        nmap -sM $ip
        ;;
    6)
        nmap -sU $ip
        ;;
    7)
        nmap -sN $ip
        ;;
    8)
        nmap -sX $ip
        ;;
    9)
        nmap -sF $ip
        ;;
esac


