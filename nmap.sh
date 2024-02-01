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
        "1"|"2")
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Función para validar la agresividad del escaneo
validate_aggression() {
    case $1 in
        "1"|"2"|"3")
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

# Elegir el tipo de escaneo
echo "Seleccione el tipo de escaneo:"
echo "1. Escaneo de servicios"
echo "2. Escaneo de puertos"
read -p "Ingrese su elección (1 o 2): " scan_type
if ! validate_scan_type $scan_type; then
    echo "Opción no válida. Saliendo."
    exit 1
fi

# Opciones de escaneo
echo "Seleccione la agresividad del escaneo:"
echo "1. Silencioso"
echo "2. Neutral"
echo "3. Agresivo"
read -p "Ingrese su elección (1, 2 o 3): " aggression
if ! validate_aggression $aggression; then
    echo "Opción no válida. Saliendo."
    exit 1
fi

# Ejecutar Nmap con las opciones seleccionadas
if [ $scan_type -eq 1 ]; then
    case $aggression in
        1)
            nmap -sV -Pn $ip
            ;;
        2)
            nmap -sV $ip
            ;;
        3)
            nmap -A $ip
            ;;
    esac
elif [ $scan_type -eq 2 ]; then
    case $aggression in
        1)
            nmap -p 1-65535 -T0 $ip
            ;;
        2)
            nmap -p 1-65535 $ip
            ;;
        3)
            nmap -p 1-65535 -T4 $ip
            ;;
    esac
fi
