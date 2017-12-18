#! /Users/pl6/homebrew/bin/python
## $ ~/scripts/genotype_builder_v2.0.py <out_prefix>

## This script searches a folder for segment trees ("*.{segment}.raxml.tre") 
## with the segment clades annotated on the taxa in each ML tree
## Outputs a tab table of taxa and genotype class for each segment completely as a master doc
## Value is 'UND' for those taxa are present in tree but are unassigned to a clade
## Value is '' for those taxa not present in a segment tree i.e. no sequence data available for that segment

import sys, re, glob
from collections import defaultdict

prefix = sys.argv[1]

outfile = open('genotypes_%s.txt' % prefix, 'w')
is_taxaline = False
segments = ['PB2', 'PB1', 'PA', 'HA', 'NP', 'NA', 'M1', 'NS1']
genotypes = defaultdict(dict)
taxa_to_strain = {}

## Method to parse the clade annotation
def getClade(a, s):
	try:
		g = re.search('%s="([^"]+)"' % s, a).group(1)
	except AttributeError:
		g = 'UND'
	#print g
	return g

## HA mcct
#outfile.write("HA\tNA\t\tPB2\tPB1\tPA\tNP\tM1\tNS1\n")

## PB1 mcct
#outfile.write("PB1\t\tPB2\tPA\tHA\tNP\tNA\tM1\tNS1\n")

## NA mcct
outfile.write("NA\tHA\t\tPB2\tPB1\tPA\tNP\tM1\tNS1\n")


for file in glob.glob("./*.tre"):
	print "Opening file %s" % file
	seg = file.split(".")[-3]
	with open(file, 'r') as infh:
		for line in infh:
			line = line.strip()
		
			##Grab only taxa lines i.e. before ';'
			if ';' in line:
				is_taxaline = False
		
			## Get taxa and annotations in taxa lines
			if is_taxaline:
				taxa = line.split("'")[1]
				
				## Use only strain name (in lower case)
				simple_strain = (taxa.split('|')[0]).lower()
				taxa_to_strain[taxa] = simple_strain
				
				## Get clade from segment annotation
				try:
					annotations = re.search('\[(.*)\]', line).group(1)
				except AttributeError:
					print line
					annotations = ''			
				clade = getClade(annotations, seg)
				
				## Check if segment info already present for strain
				if simple_strain in genotypes:
					if seg in genotypes[simple_strain]:
						if genotypes[simple_strain][seg] == clade:
							continue
						else:
							print("%s does not match %s for %s in %s" % (clade, genotypes[simple_strain][seg], simple_strain, seg))
					else:
						genotypes[simple_strain][seg] = clade
				else:
					genotypes[simple_strain][seg] = clade
				#genotypes[taxa][seg] = getClade(annotations, seg)
						
			##Grab only taxa lines i.e. after taxlabels
			if 'taxlabels' in line:
				is_taxaline = True

cladenums = {'B/Wisconsin/1/2010':'Yam clade 3', 'B/Massachusetts/2/2012':'Yam clade 2', 'B/Florida/4/2006':'Yam clade 1',
'B/Shanghai/361/2002':'ZOther', 'B/Harbin/7/1994':'Yam B/Harbin/6/1994-like', 'B/Yamanashi/166/1998':'Yam B/Yamanashi/166/1998-like',
'B/Brisbane/32/2002':'ZOther', 'other':'ZOther', 'B/Brisbane/60/2008':'Vic clade 1a', 'B/Odessa/3886/2010':'Vic clade 1b',
'B/Dakar/10/2012':'Vic clade 3', 'B/Malaysia/2506/2004':'Vic clade 4', 'B/Cambodia/30/2011':'Vic clade 5', '':'',
'clade 3':'Yam clade 3', 'clade 2':'Yam clade 2', 'clade 1':'Yam clade 1'}

cgenotypes = defaultdict(dict)

for t in taxa_to_strain:
	ss = taxa_to_strain[t]
	for s in segments:
		if s not in genotypes[ss]:
			genotypes[ss][s] = ''
		cgenotypes[ss][s] = cladenums[genotypes[ss][s]]
	g = genotypes[ss]
	#g = cgenotypes[ss]
	
	#outfile.write("%s\t%s\t%s\t\t%s\t%s\t%s\t%s\t%s\t%s\n" % (t, g['HA'], g['NA'], g['PB2'], g['PB1'], g['PA'], g['NP'], g['M1'], g['NS1']))
	#outfile.write("%s\t%s\t\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" % (t, g['PB1'], g['PB2'], g['PA'], g['HA'], g['NP'], g['NA'], g['M1'], g['NS1']))
	outfile.write("%s\t%s\t%s\t\t%s\t%s\t%s\t%s\t%s\t%s\n" % (t, g['NA'], g['HA'], g['PB2'], g['PB1'], g['PA'], g['NP'], g['M1'], g['NS1']))
outfile.close()		
print "Done."			