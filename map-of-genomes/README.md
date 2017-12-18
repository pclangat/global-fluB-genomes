## Map of genomes

The data and code to generate Figure 1.

#### 1. Count samples per location and provide longitude and latitude annotations for each location
Usage: `location_counter.py <table_of_samples.tsv> <country or city-level> <outprefix>`

i.e. `location_counter.py unique_fullgen.txt city fluB —>` outputs: fluB_location_summary.txt


#### 2. Count samples per year for time series summary
Usage: `timeseries_counter.py <table_of_samples.tsv> <outprefix>`

i.e. `timeseries_counter.py unique_fullgen.txt fluB` —> outputs: fluB_timeseries_summary.txt


#### 3. Plot the map and time series summaries using Tableau Notebooks
fluB_unique_fullgenomes.twb

fluB_unique_fullgenomes_timeseries.twb
