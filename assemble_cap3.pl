# assemble_cap3.pl 

open C, "osa40311_info_2019.txt" or die "NO osa40311_info_2019.txt FILE!";
while (<C>) {
	chomp;
	@aa = split/\t/, $_;
	$posi{$aa[0]} = $aa[2]."_".$aa[3]."_".$aa[4];
}
close C;

open IN, "bowtie_out/$ARGV[0]\_to_osa40311circ_bowtieout.txt_count.txt" or die "NO *_to_osa40311circ_bowtieout.txt_count.txt FILE!";
`mkdir -p $ARGV[0]\_output/pack_reads`;
open OUT, ">$ARGV[0]\_output/$ARGV[0]\_reads_num" or die;
while (<IN>) {
	chomp;
	@aa = split/\t/, $_;
	if ($aa[2] != '') {
		%read_name = ();
		@reads = split/\,/, $aa[3];

		for ($i=0; $i <= $#reads; $i++) {
			$reads[$i] =~ s/\/1$//;
			$reads[$i] =~ s/\/2$//;
			$read_name{$reads[$i]} = 1;
		}

		foreach $key (sort keys %read_name) {
			`grep -A 3 "$key" bowtie_out/$ARGV[0]\_bsj_1_tri.fastq >> $ARGV[0]\_output/pack_reads/$posi{$aa[0]}`;
			`grep -A 3 "$key" bowtie_out/$ARGV[0]\_bsj_2_tri.fastq >> $ARGV[0]\_output/pack_reads/$posi{$aa[0]}`;
		}

		print OUT "$posi{$aa[0]}\t$aa[2]\n";

	}
}
close IN;
close OUT;
