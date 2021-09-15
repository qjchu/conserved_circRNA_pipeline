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
for id in SRR1005257.1
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
* CIRI-full
```
# an example for predicting full-length sequences of circRNAs using CIRI-full
# CIRI-full uses raw reads
bwa index -a bwtsw Oryza_sativa.IRGSP-1.0.dna.toplevel.fa
java -jar CIRI-full_v2.0/CIRI-full.jar Pipeline -1 SRR1005257.1_bsj_1.fastq -2 SRR1005257.1_bsj_2.fastq -d cirifull_res/SRR1005257.1_bsj -o SRR1005257.1_bsj -r Oryza_sativa.IRGSP-1.0.dna.toplevel.fa -a Oryza_sativa.IRGSP-1.0.38.gtf -t 2
```

* CIRCexplorer2
```
# build index
bowtie-build Oryza_sativa.IRGSP-1.0.dna.toplevel.fa Oryza_sativa.IRGSP-1.0.dna.toplevel.fa
bowtie2-build Oryza_sativa.IRGSP-1.0.dna.toplevel.fa Oryza_sativa.IRGSP-1.0.dna.toplevel.fa

# run CIRCexplorer2
for id in SRR1005257.1
do
  # align
  CIRCexplorer2 align -G Oryza_sativa.IRGSP-1.0.38.gtf -i Oryza_sativa.IRGSP-1.0.dna.toplevel.fa -j Oryza_sativa.IRGSP-1.0.dna.toplevel.fa -f bowtie_out/$id\_bsj_1.fastq,bowtie_out/$id\_bsj_2.fastq -o $id\_alignment -b $id\_back_spliced_junction.bed
  # annotate
  CIRCexplorer2 annotate -r Oryza_sativa.IRGSP-1.0.38.gff3.new.GenePred -g Oryza_sativa.IRGSP-1.0.dna.toplevel.fa -b $id\_back_spliced_junction.bed -o $id\_circularRNA_known.txt
  # assemble
  CIRCexplorer2 assemble -r Oryza_sativa.IRGSP-1.0.38.gff3.new.GenePred -m $id\_alignment/tophat -o $id\_assemble
  # denovo
  CIRCexplorer2 denovo -r Oryza_sativa.IRGSP-1.0.38.gff3.new.GenePred -g Oryza_sativa.IRGSP-1.0.dna.toplevel.fa -b $id\_back_spliced_junction.bed -d $id\_assemble -o $id\_denovo
done
```

* circseq_cup
```
# quality control of reads supporting back-splicing
for id in SRR1005257.1
do 
  echo $id
  fastp --thread=2 -i $id\_bsj_1.fastq -o $id\_bsj_1_tri.fastq -I $id\_bsj_2.fastq -O $id\_bsj_2_tri.fastq -j $id\_fastp.json -h $id\_fastp.html 2> $id\_fastp.txt
done

# an example for predicting full-length sequences of circRNAs using circseq_cup
for id in SRR1005257.1
do 
  echo $id
  # align
  tophat2 -o $id\_tophat_fusion -p 10 --fusion-search --keep-fasta-order --bowtie1 --no-coverage-search Oryza_sativa.IRGSP-1.0.dna.toplevel.fa bowtie_out/$id\_bsj_1_tri.fastq bowtie_out/$id\_bsj_2_tri.fastq
  # run circseqcup
  python RunMe.py -o $id -t tophat_fusion -f $id\_tophat_fusion -r Oryza_sativa.IRGSP-1.0.38.gff3.new.GenePred -g Oryza_sativa.IRGSP-1.0.dna.toplevel.chrname.fa -1 bowtie_out/$id\_bsj_1_tri.fastq -2 bowtie_out/$id\_bsj_2_tri.fastq
done
```

6. Combine the results of three tools (CIRI-full, CIRCexplorer2, circseq_cup)
```
perl circ_full_length.pl circseqcup_res_updated/SRR1005257.1_output/SRR1005257.1_res circseqcup_res/Oryza_sativa.IRGSP-1.0.dna.toplevel.chrname.fa cirifull_res/SRR1005257.1_bsj/CIRI-full_output/SRR1005257.1_bsj_merge_circRNA_detail.anno circexplorer2_res/SRR1005257.1_denovo/circularRNA_full.txt SRR1005257.1
```

batch processing
```
for id in SRR1005284.1 SRR1005320 SRR1005347.1 SRR1005258.1
do 
  echo $id
  perl circ_full_length.pl circseqcup_res_updated/$id\_output/$id\_res circseqcup_res/Oryza_sativa.IRGSP-1.0.dna.toplevel.chrname.fa cirifull_res/$id\_bsj/CIRI-full_output/$id\_bsj_merge_circRNA_detail.anno circexplorer2_res/$id\_denovo/circularRNA_full.txt $id osa40311_info_2019.txt
done
```

combine results from different samples
```
cat *_full_length.txt > all_osa_samples.txt
perl circ_full_length_step2.pl all_osa_samples.txt all_circ_full_length_osa.txt
```


## Find similar circRNA sequences among different species
MUMmer were used here.


