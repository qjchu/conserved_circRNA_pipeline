#!/bin/bash
org_name=("aegilops_tauschii" "amborella_trichopoda" "arabidopsis_lyrata" "arabidopsis_thaliana" "beta_vulgaris" "brachypodium_distachyon" "brassica_napus" "brassica_oleracea" "brassica_rapa" "chlamydomonas_reinhardtii" "chondrus_crispus" "corchorus_capsularis" "cucumis_sativus" "cyanidioschyzon_merolae" "dioscorea_rotundata" "galdieria_sulphuraria" "glycine_max" "gossypium_raimondii" "helianthus_annuus" "hordeum_vulgare" "leersia_perrieri" "lupinus_angustifolius" "manihot_esculenta" "medicago_truncatula" "musa_acuminata" "nicotiana_attenuata" "oryza_barthii" "oryza_brachyantha" "oryza_glaberrima" "oryza_glumaepatula" "oryza_indica" "oryza_longistaminata" "oryza_meridionalis" "oryza_nivara" "oryza_punctata" "oryza_rufipogon" "oryza_sativa" "ostreococcus_lucimarinus" "phaseolus_vulgaris" "physcomitrella_patens" "populus_trichocarpa" "prunus_persica" "selaginella_moellendorffii" "setaria_italica" "solanum_lycopersicum" "solanum_tuberosum" "sorghum_bicolor" "theobroma_cacao" "trifolium_pratense" "triticum_aestivum" "triticum_urartu" "vitis_vinifera" "zea_mays")
for i in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52
do
  # make a new folder and set the working directory
  # --cscore=.7
	python -m jcvi.compara.catalog ortholog oryza_sativa ${org_name[i]} --cscore=.7 --no_strip_names --cpus=1
	python -m jcvi.compara.synteny screen --minspan=30 --simple oryza_sativa.${org_name[i]}\.anchors oryza_sativa.${org_name[i]}\.anchors.new
	python -m jcvi.compara.synteny mcscan oryza_sativa.bed oryza_sativa.${org_name[i]}\.lifted.anchors --iter=1 -o oryza_sativa.${org_name[i]}\.i1.blocks
  
  # make a new folder and set the working directory
  # --cscore=.8
	python -m jcvi.compara.catalog ortholog oryza_sativa ${org_name[i]} --cscore=.8 --no_strip_names --cpus=1
	python -m jcvi.compara.synteny screen --minspan=30 --simple oryza_sativa.${org_name[i]}\.anchors oryza_sativa.${org_name[i]}\.anchors.new
	python -m jcvi.compara.synteny mcscan oryza_sativa.bed oryza_sativa.${org_name[i]}\.lifted.anchors --iter=1 -o oryza_sativa.${org_name[i]}\.i1.blocks
  
  # make a new folder and set the working directory
  # --cscore=.9
	python -m jcvi.compara.catalog ortholog oryza_sativa ${org_name[i]} --cscore=.9 --no_strip_names --cpus=1
	python -m jcvi.compara.synteny screen --minspan=30 --simple oryza_sativa.${org_name[i]}\.anchors oryza_sativa.${org_name[i]}\.anchors.new
	python -m jcvi.compara.synteny mcscan oryza_sativa.bed oryza_sativa.${org_name[i]}\.lifted.anchors --iter=1 -o oryza_sativa.${org_name[i]}\.i1.blocks
  
  # make a new folder and set the working directory
  # --cscore=.99
	python -m jcvi.compara.catalog ortholog oryza_sativa ${org_name[i]} --cscore=.99 --no_strip_names --cpus=1
	python -m jcvi.compara.synteny screen --minspan=30 --simple oryza_sativa.${org_name[i]}\.anchors oryza_sativa.${org_name[i]}\.anchors.new
	python -m jcvi.compara.synteny mcscan oryza_sativa.bed oryza_sativa.${org_name[i]}\.lifted.anchors --iter=1 -o oryza_sativa.${org_name[i]}\.i1.blocks
done
