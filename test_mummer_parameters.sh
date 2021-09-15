# v1
nucmer -c 20 -D 500 -d 12 -g 9000 --prefix=osai2osaj 137_osaj_genomic_seq.txt /data2/chuqj/mummer/Oryza_indica.ASM465v1.dna.toplevel.fa
show-coords -rcl osai2osaj.delta > osai2osaj.coords
show-coords -T -q -H osai2osaj.delta > osai2osaj_coord.txt
show-snps -Clr osai2osaj.delta > osai2osaj.snps
delta-filter -1 osai2osaj.delta > osai2osaj_best.delta
show-coords -T -q -H osai2osaj_best.delta > osai2osaj_best.txt

# v2: default
nucmer --prefix=osai2osaj ../137_osaj_genomic_seq.txt /data2/chuqj/mummer/Oryza_indica.ASM465v1.dna.toplevel.fa
show-coords -rcl osai2osaj.delta > osai2osaj.coords
show-coords -T -q -H osai2osaj.delta > osai2osaj_coord.txt
show-snps -Clr osai2osaj.delta > osai2osaj.snps
delta-filter -1 osai2osaj.delta > osai2osaj_best.delta
show-coords -T -q -H osai2osaj_best.delta > osai2osaj_best.txt

# v3: --maxmatch
nucmer --maxmatch --prefix=osai2osaj_v3 ../137_osaj_genomic_seq.txt /data2/chuqj/mummer/Oryza_indica.ASM465v1.dna.toplevel.fa
show-coords -T -q -H osai2osaj_v3.delta > osai2osaj_v3_coord.txt
delta-filter -1 osai2osaj_v3.delta > osai2osaj_v3_best.delta
show-coords -T -q -H osai2osaj_v3_best.delta > osai2osaj_v3_best.txt

# v4: --nosimplify
nucmer --nosimplify --prefix=osai2osaj_v4 ../137_osaj_genomic_seq.txt /data2/chuqj/mummer/Oryza_indica.ASM465v1.dna.toplevel.fa
show-coords -T -q -H osai2osaj_v4.delta > osai2osaj_v4_coord.txt
delta-filter -1 osai2osaj_v4.delta > osai2osaj_v4_best.delta
show-coords -T -q -H osai2osaj_v4_best.delta > osai2osaj_v4_best.txt

# v5: --maxmatch -c 20 
nucmer --maxmatch -c 20 --prefix=osai2osaj_v5 ../137_osaj_genomic_seq.txt /data2/chuqj/mummer/Oryza_indica.ASM465v1.dna.toplevel.fa
show-coords -T -q -H osai2osaj_v5.delta > osai2osaj_v5_coord.txt  # for downstream analyze
delta-filter -1 osai2osaj_v5.delta > osai2osaj_v5_best.delta
show-coords -T -q -H osai2osaj_v5_best.delta > osai2osaj_v5_best.txt

# v6: --maxmatch -c 50
nucmer --maxmatch -c 50 --prefix=osai2osaj_v6 ../137_osaj_genomic_seq.txt /data2/chuqj/mummer/Oryza_indica.ASM465v1.dna.toplevel.fa
show-coords -T -q -H osai2osaj_v6.delta > osai2osaj_v6_coord.txt
delta-filter -1 osai2osaj_v6.delta > osai2osaj_v6_best.delta
show-coords -T -q -H osai2osaj_v6_best.delta > osai2osaj_v6_best.txt

# v7: -c 20 
nucmer -c 20 --prefix=osai2osaj_v7 ../137_osaj_genomic_seq.txt /data2/chuqj/mummer/Oryza_indica.ASM465v1.dna.toplevel.fa
show-coords -T -q -H osai2osaj_v7.delta > osai2osaj_v7_coord.txt
delta-filter -1 osai2osaj_v7.delta > osai2osaj_v7_best.delta
show-coords -T -q -H osai2osaj_v7_best.delta > osai2osaj_v7_best.txt
