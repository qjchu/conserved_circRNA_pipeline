# perl afterMummer1_arrange_osa.pl 
# 47 plants
@rice = ("chondrus_crispus", "galdieria_sulphuraria", "cyanidioschyzon_merolae", "ostreococcus_lucimarinus", "chlamydomonas_reinhardtii", "physcomitrella_patens", "selaginella_moellendorffii", "musa_acuminata", "oryza_brachyantha", "oryza_glaberrima", "oryza_rufipogon", "oryza_sativa", "oryza_glumaepatula", "oryza_barthii", "oryza_longistaminata", "oryza_meridionalis", "oryza_punctata", "leersia_perrieri", "hordeum_vulgare", "triticum_urartu", "triticum_aestivum", "aegilops_tauschii", "brachypodium_distachyon", "sorghum_bicolor", "zea_mays", "vitis_vinifera", "gossypium_raimondii", "theobroma_cacao", "arabidopsis_thaliana", "arabidopsis_lyrata", "brassica_rapa", "brassica_oleracea", "brassica_napus", "cucumis_sativus", "lupinus_angustifolius", "glycine_max", "phaseolus_vulgaris", "medicago_truncatula", "trifolium_pratense", "prunus_persica", "manihot_esculenta", "populus_trichocarpa", "beta_vulgaris", "helianthus_annuus", "solanum_tuberosum", "solanum_lycopersicum", "amborella_trichopoda");

foreach $rice(@rice){
	`dos2unix $rice\\2osaj_coord_best.txt`;
	open IN, $rice."2osaj_coord_best.txt" or die;
	while (<IN>) {
		chomp;
		@aa = split/ /, $_;
		$circ{$aa[7]} = 1;

		if ($aa[2] <= $aa[3]) {
			$to{$rice}{$aa[7]} = $aa[8]."|".$aa[2]."|".$aa[3];
			$idy{$rice}{$aa[7]} = $aa[6];
		}
		if ($aa[2] > $aa[3]) {
			$to{$rice}{$aa[7]} = $aa[8]."|".$aa[3]."|".$aa[2];
			$idy{$rice}{$aa[7]} = $aa[6];
		}
		
	}
	close IN;
	next;
}

open OUT, ">arranged_posi_osaj.txt";
print OUT "circ_name";
foreach $r(@rice){ print OUT "\t$r"; }
print OUT "\n";
foreach $k(sort keys %circ){
	print OUT "$k";
	foreach $r(@rice){
		print OUT "\t$to{$r}{$k}";
	}
	print OUT "\n";
}
close OUT;

open OUT2, ">arranged_identity_osaj.txt";
print OUT2 "species";
foreach $r(sort keys %circ){ print OUT2 "\t$r";}
print OUT2 "\n";
foreach $k(@rice){
	print OUT2 "$k";
	foreach $r(sort keys %circ){
		print OUT2 "\t$idy{$k}{$r}";
	}
	print OUT2 "\n";
}
close OUT2;
