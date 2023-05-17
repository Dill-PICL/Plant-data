import os
import sys

sys.path.append("../../oats")
from oats.biology.groupings import Groupings

path_to_kegg = "../databases/kegg/"

ath = str(path_to_kegg) + "ath_pathway_files_from_api"
zma = str(path_to_kegg) + "zma_pathway_files_from_api"
osa = str(path_to_kegg) + "osa_pathway_files_from_api"
mtr = str(path_to_kegg) + "mtr_pathway_files_from_api"
gmx = str(path_to_kegg) + "gmx_pathway_files_from_api"
sly = str(path_to_kegg) + "sly_pathway_files_from_api"
hsa = str(path_to_kegg) + "hsa_pathway_files_from_api"

species_to_directories = {
	"ath":str(ath),
	"zma":str(zma),
	"osa":str(osa),
	"mtr":str(mtr),
	"gmx":str(gmx),
	"sly":str(sly),
	"hsa":str(hsa)
}

Groupings.save_all_kegg_pathway_files(species_to_directories)