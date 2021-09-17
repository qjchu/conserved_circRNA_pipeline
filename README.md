# conserved_circRNA_pipeline
Detailed pipelines for analysing the conservation of circRNAs.

## Assembly of full-length circRNAs
1. Download rice circRNAs with back-splicing information form PlantcircBase (http://ibi.zju.edu.cn/plantcircbase/).
2. Duplicate the genomic sequences of circRNAs once and combine to form a pseudo reference sequences.
```bash
perl 40311circ_2fold_seq.pl
```
3. Align RNA-Seq datasets to pseudo reference sequences and count the number and names of reads that supporting the back-splicing sites.
```bash
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
```bash
# an example as following
filterbyname.sh in=SRR1005257.1_1.fastq.gz in2=SRR1005257.1_2.fastq.gz out=SRR1005257.1_bsj_1.fastq out2=SRR1005257.1_bsj_2.fastq names=SRR1005257.1_to_osa40311circ_bowtieout.txt_reads_name.txt include=t
```
5. Predict complete sequences of circRNAs based on CIRI-full (Zheng et al., 2019), CIRCexplorer2 (Zhang et al., 2016), or circseq_cup (Ye et al., 2017).
* CIRI-full
```bash
# an example for predicting full-length sequences of circRNAs using CIRI-full
# CIRI-full uses raw reads
bwa index -a bwtsw Oryza_sativa.IRGSP-1.0.dna.toplevel.fa
java -jar CIRI-full_v2.0/CIRI-full.jar Pipeline -1 SRR1005257.1_bsj_1.fastq -2 SRR1005257.1_bsj_2.fastq -d cirifull_res/SRR1005257.1_bsj -o SRR1005257.1_bsj -r Oryza_sativa.IRGSP-1.0.dna.toplevel.fa -a Oryza_sativa.IRGSP-1.0.38.gtf -t 2
```

* CIRCexplorer2
```bash
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
```bash
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
```bash
perl circ_full_length.pl circseqcup_res_updated/SRR1005257.1_output/SRR1005257.1_res circseqcup_res/Oryza_sativa.IRGSP-1.0.dna.toplevel.chrname.fa cirifull_res/SRR1005257.1_bsj/CIRI-full_output/SRR1005257.1_bsj_merge_circRNA_detail.anno circexplorer2_res/SRR1005257.1_denovo/circularRNA_full.txt SRR1005257.1
```

batch processing:
```bash
for id in SRR1005284.1 SRR1005320 SRR1005347.1 SRR1005258.1
do 
  echo $id
  perl circ_full_length.pl circseqcup_res_updated/$id\_output/$id\_res circseqcup_res/Oryza_sativa.IRGSP-1.0.dna.toplevel.chrname.fa cirifull_res/$id\_bsj/CIRI-full_output/$id\_bsj_merge_circRNA_detail.anno circexplorer2_res/$id\_denovo/circularRNA_full.txt $id osa40311_info_2019.txt
done
```

combine results from different samples:
```bash
cat *_full_length.txt > all_osa_samples.txt
perl circ_full_length_step2.pl all_osa_samples.txt all_circ_full_length_osa.txt
```

7. Extract the full-length sequences of circRNAs
```bash
perl extract_circ_full_length_osa.pl all_circ_full_length_osa.txt all_circ_full_length_osa_seq.txt
```

Format of output file:
```
# >chr_start_end|circ_name|(total exons)_(exon number)_(exon start)-(exon end)
>10_11629937_11630996|osa_circ_006625|2_1_11629937-11629955
ACAGGTTAATGGCCTCTTG
>10_11629937_11630996|osa_circ_006625|2_2_11630827-11630996
CTGGCCATCAAAGTGAGCAACCAAAACAGTGGAAGAACCAGGAGAGTGCGCTTCATCTGCAGCCTTGGAAAGAACTTGTTCGGGTTTAATATCTGCAGCGCCTTGATTCTCCATAATGAACTTTTTACAACCATCCATTAGCTCCCTTGCATAAAGCCCTGCATTGATAC
```

## Find similar circRNA sequences among different species
MUMmer were used in this section.

1. Seclect suitable parameters
```bash
sh -v test_mummer_parameters.sh
```

2. Run MUMmer
```bash
sh -v mummer_osa_210712.sh
```
files named as ```**2osaj_coord.txt``` will be used for downstream analysis.

3. Arrange the results of MUMmer, and extract circRNA transcript sequences from each species
```bash
# extract best hit of circRNAs based on the results of MUMmer
# example of four plant species
for id in hordeum_vulgare triticum_aestivum zea_mays arabidopsis_thaliana; do perl afterMummer0_best_coord_osa.pl $id; done
```
```bash
# arrange orthologous positions of circRNAs in different species, and extract the length identity of mapped sequences
perl afterMummer1_arrange_osa.pl
```
```bash
# extract the corresponding orthologous circRNA sequences from different species
perl afterMummer2_extract_genome_seq_osa40311circs.pl
```
This script generates files named ```seq_name.fasta```, which contain orthologous sequences of one circRNA in differernt species. These files could be used for multiple sequences alignments by MAFFT.
```bash
perl afterMummer3_extract_seq_each_species.pl
```
This script generates files named ```(species name)_circ_seq.txt```, which contain all circRNA sequences of one certain species. These files could be used for quantification of circRNA expression.

## Find orthologous genes among different species
MCScan were used in this section.

1. Seclect suitable parameters
```bash
sh -v test_mcscan_parameters.sh
```

2. Run MCScan
```bash
sh -v mcscan_osaj_53species.sh
```

3. Arrange the results of MCScan
```bash
# combine blocks
# results from 47 species
python -m jcvi.formats.base join oryza_sativa.chondrus_crispus.i1.blocks oryza_sativa.galdieria_sulphuraria.i1.blocks oryza_sativa.cyanidioschyzon_merolae.i1.blocks oryza_sativa.ostreococcus_lucimarinus.i1.blocks oryza_sativa.chlamydomonas_reinhardtii.i1.blocks oryza_sativa.physcomitrella_patens.i1.blocks oryza_sativa.selaginella_moellendorffii.i1.blocks oryza_sativa.musa_acuminata.i1.blocks oryza_sativa.oryza_brachyantha.i1.blocks oryza_sativa.oryza_glaberrima.i1.blocks oryza_sativa.oryza_rufipogon.i1.blocks oryza_sativa.oryza_sativa.i1.blocks oryza_sativa.oryza_glumaepatula.i1.blocks oryza_sativa.oryza_barthii.i1.blocks oryza_sativa.oryza_longistaminata.i1.blocks oryza_sativa.oryza_meridionalis.i1.blocks oryza_sativa.oryza_punctata.i1.blocks oryza_sativa.leersia_perrieri.i1.blocks oryza_sativa.hordeum_vulgare.i1.blocks oryza_sativa.triticum_urartu.i1.blocks oryza_sativa.triticum_aestivum.i1.blocks oryza_sativa.aegilops_tauschii.i1.blocks oryza_sativa.brachypodium_distachyon.i1.blocks oryza_sativa.sorghum_bicolor.i1.blocks oryza_sativa.zea_mays.i1.blocks oryza_sativa.vitis_vinifera.i1.blocks oryza_sativa.gossypium_raimondii.i1.blocks oryza_sativa.theobroma_cacao.i1.blocks oryza_sativa.arabidopsis_thaliana.i1.blocks oryza_sativa.arabidopsis_lyrata.i1.blocks oryza_sativa.brassica_rapa.i1.blocks oryza_sativa.brassica_oleracea.i1.blocks oryza_sativa.brassica_napus.i1.blocks oryza_sativa.cucumis_sativus.i1.blocks oryza_sativa.lupinus_angustifolius.i1.blocks oryza_sativa.glycine_max.i1.blocks oryza_sativa.phaseolus_vulgaris.i1.blocks oryza_sativa.medicago_truncatula.i1.blocks oryza_sativa.trifolium_pratense.i1.blocks oryza_sativa.prunus_persica.i1.blocks oryza_sativa.manihot_esculenta.i1.blocks oryza_sativa.populus_trichocarpa.i1.blocks oryza_sativa.beta_vulgaris.i1.blocks oryza_sativa.helianthus_annuus.i1.blocks oryza_sativa.solanum_tuberosum.i1.blocks oryza_sativa.solanum_lycopersicum.i1.blocks oryza_sativa.amborella_trichopoda.i1.blocks --noheader | cut -f1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,88,90,92,94,96 > 47_species.i1.blocks
```


## Contact me
This pipeline is developed and maintained by Qinjie Chu: qinjiechu@zju.edu.cn
Any questions or suggestions, please feel free to contact me.
