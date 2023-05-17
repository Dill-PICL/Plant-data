echo "START OF PIPELINE.SH\n"

# Convert the preprocessing notebooks to python scripts.
echo "convert notebooks to scripts"
jupyter nbconvert --to script preprocessing/reshaping_maizegdb_data.ipynb --output-dir scripts
jupyter nbconvert --to script preprocessing/reshaping_sgn_data.ipynb --output-dir scripts
jupyter nbconvert --to script preprocessing/reshaping_tair_data.ipynb --output-dir scripts
jupyter nbconvert --to script preprocessing/reshaping_oryzabase_data.ipynb --output-dir scripts
jupyter nbconvert --to script preprocessing/reshaping_oellrich_walls_data.ipynb --output-dir scripts
jupyter nbconvert --to script preprocessing/reshaping_planteome_data.ipynb --output-dir scripts

# Run all the preprocessing scripts to generate files in the reshaped data directory.
cd scripts
echo "\n\nreshaping_maizegdb_data"
python reshaping_maizegdb_data.py
echo "\n\nreshaping_sgn_data"
python reshaping_oryzabase_data.py
echo "\n\nreshaping_tair_data"
python reshaping_tair_data.py
echo "\n\nreshaping_oryzabase_data"
python reshaping_sgn_data.py
echo "\n\nreshaping_oellrich_walls_data\n"
python reshaping_oellrich_walls_data.py
echo "\n\nreshaping_planteome_data"
python reshaping_planteome_data.py


# Combine all those reshaped files into the combined dataset files for the genes, annotations, and phenotypes.
echo "\n\nsave_datasets_to_files"
python save_datasets_to_files.py
echo "\n\nsave_datasets_to_json"
python save_datasets_to_json.py
echo "\n\ncheck_dataset"
python check_dataset.py


# Create the files that map gene objects from the above resources to particular groupings.
# Commenting out running the script that first extracts the KEGG pathway files using the REST API, just retain those files.
# This way this pipeline can be stable and run without any of the underlying files changing, this way it is reproducible.
echo "\n\nsave_kegg_pathway_to_files"
python save_kegg_pathway_to_files.py
echo "\n\nsave_groupings_to_files"
python save_groupings_to_files.py

echo "\ncreate samples\n"
# Create samples of the first few lines of each of the created files into a samples directory for looking at the shape.
cd ..
for path in ./reshaped_data/*.csv; do
	filename=$(basename $path)
	head -100 $path > ./reshaped_samples/$filename
done

echo "END OF PIPELINE.SH"
