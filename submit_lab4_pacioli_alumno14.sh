#!/bin/bash
#SBATCH -p hpc-bio-pacioli
#SBATCH --chdir=/home/alumno14/lab4FLR
#SBATCH --job-name=lab4_cut
#SBATCH --output=lab4_cut_%j.out
#SBATCH --error=lab4_cut_%j.err
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4

# Define el nombre del archivo de trabajo
job_name="submit_lab4_$(hostname -s)-$USER.sh"

# Crea un archivo de trabajo temporal
echo "#!/bin/bash" > "$job_name"
echo "" >> "$job_name"

# Agrega las líneas para ejecutar el script file-cut.sh en paralelo con 4 procesos
for file in fastq/*.fastq; do
    echo "bash file-cut.sh $file &" >> "$job_name"
done

# Espera a que todos los procesos terminen antes de salir del trabajo
echo "wait" >> "$job_name"

# Renombra los archivos generados
for file in *.fastq_cut.fastq; do
    new_name=$(echo "$file" | sed 's/_cut.fastq/.fastq/')
    echo "mv $file $new_name" >> "$job_name"
done

# Sube el trabajo a SLURM
sbatch "$job_name"

echo "Trabajo enviado a SLURM. Nombre del trabajo: $job_name"

