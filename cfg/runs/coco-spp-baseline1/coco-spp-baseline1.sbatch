#!/bin/bash
#SBATCH --partition=napoli-gpu --qos=normal
#SBATCH --time=10-00:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=64G

# only use the following on partition with GPU
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1080ti:4

# Memory per node specification is in MB. It is optional.
# The default limit is 3000MB per core.
#SBATCH --job-name="coco-spp-baseline1"
#SBATCH --output=batch/out/coco-spp-baseline1.out

# only use the following if you want email notification
#SBATCH --mail-user=tsoi@stanford.edu
#SBATCH --mail-type=ALL

# list out some useful information
echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory = "$SLURM_SUBMIT_DIR

# sample job
date;hostname;pwd
#NPROCS=`srun --nodes=${SLURM_NNODES} bash -c 'hostname' |wc -l`
#echo NPROCS=$NPROCS
# can try the following to list out which GPU you have access to
#/usr/local/cuda/samples/1_Utilities/deviceQuery/deviceQuery
nvidia-smi
# single gpu starting
#LD_LIBRARY_PATH=lib ./darknet detector train cfg/runs/coco-spp-baseline1/coco-spp-baseline1.data cfg/runs/coco-spp-baseline1/coco-spp-baseline1.cfg datasets/voc/darknet53.conv.74
# 4gpu
LD_LIBRARY_PATH=lib ./darknet detector train cfg/runs/coco-spp-baseline1/coco-spp-baseline1.data cfg/runs/coco-spp-baseline1/coco-spp-baseline1.cfg backup/coco-spp-baseline1/coco-spp-baseline1.backup -gpus 0,1,2,3
echo "Done"
