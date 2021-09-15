# count_reads_from_bowtie_osa40311.pl
# Usage:
# perl count_reads_from_bowtie_osa40311.pl bowtie_out/$id\_to_osa40311circ_bowtieout.txt

open IN, "osa40311_genomic_seq_2fold.txt" or die;
while (<IN>) {
	chomp;
	if (/>(.*)/) {
		$seq_name = $1;
	}
	else{
		$seq_len = length($_) / 2;
		$ha{$seq_name} = $seq_len;
	}
}
close IN;

open B, $ARGV[0] or die;
while (<B>) {
	chomp;
	@aa = split/\t/, $_;
	if ($aa[3] < $ha{$aa[2]} -10 && $aa[3] > $ha{$aa[2]} +10 -length($aa[4]) ) {
		$count{$aa[2]} ++;
		$reads{$aa[2]} .= $aa[0].",";
		$reads_name{$aa[0]} = 1;
	}
}
close OUT;

open OUT, ">$ARGV[0]\_count.txt";
foreach	$key(sort keys %ha){
	# print OUT "$key\t$ha{$key}\t$count{$key}\t$reads{$key}\t$count2{$key}\t$reads2{$key}\n";
	print OUT "$key\t$ha{$key}\t$count{$key}\t$reads{$key}\n";
}

open OUT2, ">$ARGV[0]\_reads_name.txt";
foreach	$key(sort keys %reads_name){
	$key =~ s/\/1$//;
	$key =~ s/\/2$//;
	print OUT2 "$key\n";
}
