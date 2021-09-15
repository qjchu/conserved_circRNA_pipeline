# 40311circ_2fold_seq.pl # download from PlantcircBase
open IN, "v4_osa_genomic_seq.txt";
while (<IN>) {
	chomp;
	if (/>(.*)/) {
		$name = $1;
	}else{
		$seq{$name} = $_.$_;
	}
}
close IN;

open OUT, ">osa40311_genomic_seq_2fold.txt" or die;
foreach $p(sort keys %seq){
	print OUT ">$p\n$seq{$p}\n";
}
close OUT;
