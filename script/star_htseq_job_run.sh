#!/bin/bash
module load snakemake/6.8.2; 
snakemake -s RNA-seq_pipeline_STAR_HT-Seq.snake -j 51 --latency-wait 60 --cluster-config=cluster.yml --cluster "sbatch --gres=lscratch:40 --time=004:00:00 --cpus-per-task={threads} --mem={params.mem} --partition={cluster.partition} " 2>snake.error
