#!/bin/bash

# Obtén el número de líneas del archivo
num_lines=$(wc -l < "$1")

# Calcula el número de líneas a cortar según el usuario
login_length=14
lines_to_cut=$((num_lines / login_length))

# Corta y guarda la parte superior proporcional al login
head -n "$lines_to_cut" "$1" > "$1".temp
#mv "$1".temp "$1"

