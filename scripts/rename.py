# Rename files

import os
#

dir_source = "/Volumes/ZAHRA5TB/ongoing_data/ccnsd/full_correlation_matrices/2. adolescence/"
dir_destination = "/Volumes/ZAHRA5TB/ongoing_data/ccnsd/full_correlation_matrices/2. adolescence/dest/"

for count, filename in enumerate(os.listdir(dir_source)):
    count += 1
    new_number = count + 74
    source = dir_source + "corr_adol_" + "%03i" % count + ".txt"
    destination = dir_destination + "corr_adolescent_" + "%03i" % count + ".txt"
    os.rename(source, destination)
