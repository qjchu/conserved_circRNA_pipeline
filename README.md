# conserved_circRNA_pipeline
Detailed pipelines for analysing the conservation of circRNAs

## Assembly of full-length circRNAs
1. Download rice circRNAs with back-splicing information form PlantcircBase (http://ibi.zju.edu.cn/plantcircbase/).
2. Duplicate the genomic sequences of circRNAs once and combine to form a pseudo reference sequences.
```
perl 40311circ_2fold_seq.pl
```
3. Align RNA-Seq datasets to pseudo reference sequences and count the number and names of reads that supporting the back-splicing sites.
```
# build bowtie index
bowtie-build osa40311_genomic_seq_2fold.txt osa40311_genomic_seq_2fold

# bowtie align and count
for id in SRR1005257.1 SRR1005284.1 SRR1005320 SRR1005347.1 
do
  echo $id
  bowtie -p 8 --al bowtie_out/aligned_$id\.fq osa40311_genomic_seq_2fold -1 /public4/chuqj/raw_data/rice_ribozero_data/$id\_1_tri.fastq -2 /public4/chuqj/raw_data/rice_ribozero_data/$id\_2_tri.fastq > bowtie_out/$id\_to_osa40311circ_bowtieout.txt
  perl count_reads_from_bowtie_osa40311.pl bowtie_out/$id\_to_osa40311circ_bowtieout.txt
done
```
4. Extract sequences of reads supporting back-splicing site based on the names of reads using BBmap
```
# an example as following
filterbyname.sh in=SRR1005257.1_1.fastq.gz in2=SRR1005257.1_2.fastq.gz out=SRR1005257.1_bsj_1.fastq out2=SRR1005257.1_bsj_2.fastq names=SRR1005257.1_to_osa40311circ_bowtieout.txt_reads_name.txt include=t
```
5. Predict complete sequences of circRNAs based on CIRI-full (Zheng et al., 2019), CIRCexplorer2 (Zhang et al., 2016), or circseq_cup (Ye et al., 2017).

## Find similar circRNA sequences among different species
MUMmer were used here.


