#!/bin/bash

##########################################################
# Script: disk_memory_cpu_stats.sh
# Descripción: Este script muestra información sobre el uso de disco, memoria y CPU.
# Autor: Jose Garagorry <jj@softraincorp.com>
##########################################################

# Obtener file systems con uso mayor al 50%
disk_stats=$(df -h | awk 'NR>1 {print $5,$1}' | sed 's/%//g' | awk '$1 > 50 {print}')

# Verificar si hay file systems con uso mayor al 50%
if [ -n "$disk_stats" ]; then
    echo -e "\e[1;34mFile systems con uso mayor al 50%:\e[0m"
    echo "Uso (%) - File System"
    echo "$disk_stats"
else
    echo -e "\e[1;33mNo hay file systems con uso mayor al 50%.\e[0m"
fi

# Obtener información de memoria en GB
memory_stats=$(free -g | grep Mem | awk '{print "Memoria Usada: " $3 " GB\nMemoria Disponible: " $7 " GB"}')

# Mostrar información de memoria
echo -e "\n\e[1;34mInformación de Memoria:\e[0m"
echo -e "$memory_stats"

# Obtener información de CPU
cpu_stats=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "Uso de CPU: " 100 - $1 "%"}')

# Mostrar información de CPU
echo -e "\n\e[1;34mInformación de CPU:\e[0m"
echo "$cpu_stats"

