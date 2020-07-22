#!/bin/bash

set -e
gmx_mpi pdb2gmx -f $1 -ignh -o conf_nb.gro -p topol_01.top -i posre_01.itp <<EOF
1
1
EOF
gmx_mpi editconf -f conf_nb.gro  -o conf_nb.pdb
gmx_mpi editconf -bt dodecahedron -d 10 -c -f conf_nb.gro  -o conf_01.gro
gmx_mpi grompp -f mini.mdp -c conf_01.gro -p topol_01.top -po mdp_02.mdp -o tpr_02.tpr -maxwarn 1
gmx_mpi mdrun -s tpr_02.tpr -o trj_03.trr -g log_03.log -c conf_03.gro
gmx_mpi editconf -f conf_03.gro  -o conf_03.pdb
mv conf_03.pdb mini_$1
