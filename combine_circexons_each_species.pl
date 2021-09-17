# combine_circexons_each_species.pl
open IN, "$ARGV[0]" or die "NO *_circ_seq.txt FILE!\n";
# *_circ_seq.txt contains exon sequences of circRNAs
while (<IN>) {
	chomp;
	if (/>(.+)/) {
		$name = $1;
		$name =~ s/\_1\_/\_01\_/g;
		$name =~ s/\_2\_/\_02\_/g;
		$name =~ s/\_3\_/\_03\_/g;
		$name =~ s/\_4\_/\_04\_/g;
		$name =~ s/\_5\_/\_05\_/g;
		$name =~ s/\_6\_/\_06\_/g;
		$name =~ s/\_7\_/\_07\_/g;
		$name =~ s/\_8\_/\_08\_/g;
		$name =~ s/\_9\_/\_09\_/g;
	}else{
		$seq{$name} = $_;
	}
}
close IN;

foreach $key (sort keys %seq) {
	@aa = split/\|/, $key;
	if (!exists $ha{$aa[0]."|".$aa[1]}) {
		$ha{$aa[0]."|".$aa[1]} = $seq{$key};
	}else{
		$ha{$aa[0]."|".$aa[1]} .= $seq{$key};
	}
}

$filename = (split/\./, $ARGV[0])[0];
open OUT, ">".$filename."\_trans.txt";
foreach $k (sort keys %ha) {
	print OUT ">$k\n$ha{$k}\n";
}
close OUT;
