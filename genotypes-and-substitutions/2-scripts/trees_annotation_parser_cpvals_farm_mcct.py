#! /usr/local/bin/python
# $ ~/scripts/trees_annotation_parser_cpvals_farm_mcct_v2.py tree_file annotation_prfx

##This script takes the mcct from renaissance counting run, parses the cpvals to generate amino acid sequence
##and annotates the substitutions along the trunk lineages of the output mcct. 
##It also outputs a summary file of the trunk substitutions and the years/95%HPDs that they occurred.
##This is a revised version of trees_annotation_parser_cpvals_farm_mcct.py, where the removal of annotations does NOT remove posterior annotations

import sys, re, os, datetime
from collections import defaultdict
#from datetime import date

##Add path insert for dendropy package location
##If no dendropy, install using: pip install dendropy
## For local
#sys.path.insert(0, "/Users/pl6/homebrew/lib/python2.7/site-packages/")
sys.path.insert(0, '/usr/local/lib/python2.7/site-packages/')

## For farm
## Uses Dendropy 4 which is annoying, because many things are deprecated and now AnnotationSet uses single quotes not double
#sys.path.insert(0, "/software/pathogen/external/lib/python2.7/site-packages/DendroPy-3.12.0-py2.7.egg/")
import dendropy
#from dendropy import tree_source_iter

tree_file = sys.argv[1]
prfx = sys.argv[2]

summary_file = open('%strunk_subs_dates.csv' % prfx, 'w')
summary_file.write('substitution,date,date_95HPD_low,date_95HPD_high\n')

year_int = 25
#posterior_cutoff = 0.9
key_sites = [0,1000]

clade2_taxon = 'Massachusetts/07/2014'
clade3_taxon = 'Peru/21/2015'

## PB1
#clade2_taxon = 'B/Laos/110/2015'
#clade3_taxon = 'B/Peru/20/2015'

#posterior_subs = defaultdict(dict)
taxa = dendropy.TaxonNamespace()

genetic_code = {
    'ttt' : 'F', 'ttc' : 'F', 'tta' : 'L', 'ttg' : 'L',
  	'ctt' : 'L', 'ctc' : 'L', 'cta' : 'L', 'ctg' : 'L',
  	'att' : 'I', 'atc' : 'I', 'ata' : 'I', 'atg' : 'M',
  	'gtt' : 'V', 'gtc' : 'V', 'gta' : 'V', 'gtg' : 'V',
  	'tct' : 'S', 'tcc' : 'S', 'tca' : 'S', 'tcg' : 'S',
  	'cct' : 'P', 'ccc' : 'P', 'cca' : 'P', 'ccg' : 'P',
  	'act' : 'T', 'acc' : 'T', 'aca' : 'T', 'acg' : 'T',
  	'gct' : 'A', 'gcc' : 'A', 'gca' : 'A', 'gcg' : 'A',
  	'tat' : 'Y', 'tac' : 'Y', 'taa' : '*', 'tag' : '*',
  	'cat' : 'H', 'cac' : 'H', 'caa' : 'Q', 'cag' : 'Q',
  	'aat' : 'N', 'aac' : 'N', 'aaa' : 'K', 'aag' : 'K',
  	'gat' : 'D', 'gac' : 'D', 'gaa' : 'E', 'gag' : 'E',
  	'tgt' : 'C', 'tgc' : 'C', 'tga' : '*', 'tgg' : 'W',
  	'cgt' : 'R', 'cgc' : 'R', 'cga' : 'R', 'cgg' : 'R',
  	'agt' : 'S', 'agc' : 'S', 'aga' : 'R', 'agg' : 'R',
  	'ggt' : 'G', 'ggc' : 'G', 'gga' : 'G', 'ggg' : 'G' }

## Method to get an annotation from set of annotations string
def get_basic_annotation(type, a):
	x = re.search('%s=([^,|\]]*)' % type, a)
	if x is not None:
		x = x.group(1)
		x = re.sub('"', '', x)
		x = re.sub("'", "", x)
	return x

## Method to get a bounded annotation from set of annotations string
def get_bounded_annotation(type, a):
	x = re.search('%s=([^\]]*)' % type, a)
	if x is not None:
		x = x.group(1)
		x = re.sub('"', '', x)
		x = re.sub("'", "", x)
		x = re.sub("\[", "{", x)
		x = "%s}" % x
	return x

## Method to get codon partition sequence annotation from set of annotations
def get_cp(cp_type, a):
	cp_val = re.search('%s%s=([^,]*),' % (prfx,cp_type), a)
	if cp_val is None:
		cp_val = re.search('%s%s=([^,|\]]*)\]' % (prfx,cp_type), a)
	if cp_val is None:
		print "Problem cp_val found in %s" % a
	if cp_val is not None:
		cp_val = cp_val.group(1)
		cp_val = re.sub('"', '', cp_val)
		cp_val = re.sub("'", "", cp_val)
	if '+' in cp_val:
		cp_val = cp_val.split('+')[0]
	#print cp_val
	return cp_val

## Method to get amino acid sequence from cp values, returns cds of HA not including sig pep (first 15 aa)
def get_aaseq(p1,p2,p3):
	## Cycle through codons positions
	#print("codon sites: %s - %s - %s" % (len(p1), len(p2), len(p3)))
	i = 0
	aa_seq = ""
	while i < len(cp1):
		codon = (p1[i]).lower() + (p2[i]).lower() + (p3[i]).lower()
		aa = genetic_code[codon]
		aa_seq += aa
		i+=1
	#HA only
	#aa_seq = aa_seq[15:]
	#print aa_seq
	return aa_seq	

## Method to get subs from the nt seq's annotations inferred from renaissance counting
def get_subs(ancestral, current):
	i = 0
	sub = ''
	subs = ''
	ksubs = ''
	while i < len(current):
		if ancestral[i] != current[i]:
			sub =  "%s%s%s" % (ancestral[i], i+1, current[i])
			if (i+1) in key_sites:
				if ksubs == '':
					ksubs = sub
				else:
					ksubs = "%s-%s" % (ksubs, sub)
			if subs == '':
				subs = sub
			else:
				subs = "%s-%s" % (subs, sub)
		i+=1
	#print subs
	return subs, ksubs


## Method to parse tip dates from taxanames and convert dates to decimal years
def get_num_date(tn):
	#print tn
	plain_date = tn.split('|')[2]
	if '-' in plain_date:
		yr = int(plain_date.split('-')[0])
		try:
			mth = int(plain_date.split('-')[1])
		except ValueError:
			mth = 1
		try:
			day = int(plain_date.split('-')[2])
		except ValueError:
			day = 1
		
		plain_date = '%s-%s-%s' % (yr, mth, day)
		plain_date = datetime.datetime.strptime(plain_date, '%Y-%m-%d').date()
		start_year = datetime.date(year=plain_date.year, month=1, day=1).toordinal()
		node_date = plain_date.toordinal()
		next_year = datetime.date(plain_date.year+1, 1, 1).toordinal()
		dec_date = plain_date.year + (node_date - start_year) / float(next_year - start_year)

	else:
		print "Unusual parsing of date %s" % plain_date
	#print "decimal date: %s\n" % dec_date
	return dec_date

## Method to define/trace the trunk of the tree for isolates from specified date range
def define_trunk(dt = None):
	#Trace current lineages backward to define trunk
	if dt is None:
		#dt = self.dt
		dt = 1
	# Find most recent tip
	most_recent_date = -1e10
	for node in tree.leaf_node_iter():
		#Get leaf num_date from taxaname
		node.num_date = get_num_date(str(node.taxon))
		
		if node.num_date>most_recent_date:
			most_recent_date=node.num_date
	
	#print most_recent_date
	
	for node in tree.postorder_node_iter():
		node.trunk_count=0
		node.lineage=None		

	# Mark ancestry of recent tips
	number_recent = 0
	for node in tree.leaf_node_iter():
		if most_recent_date - node.num_date < dt:
			number_recent += 1
			parent = node.parent_node
			while (parent != None):
				# Adding lineage info from tip
				if clade2_taxon in str(node.taxon):
					if parent.lineage:
						parent.lineage = 'common'
					else:
						parent.lineage = 'clade2'
				elif clade3_taxon in str(node.taxon):
					if parent.lineage:
						parent.lineage = 'common'
					else:
						parent.lineage = 'clade3'
				
				# Normal marking
				parent.trunk_count += 1
				parent = parent.parent_node

	# Mark trunk nodes
	#print number_recent
	for node in tree.postorder_node_iter():
		#print node.trunk_count
		if node.trunk_count == number_recent:
			node.trunk = True
		else:
			node.trunk = False
	return most_recent_date

## Method to summarise dates of trunk substitutions
def write_mutation_dates_summary(a, m):
	
	## Parse and modify annotation values
	s = str(a.find(name="substitutions"))
	h = str(a.find(name="height"))
	h_hpd = str(a.find(name="height_95%_HPD"))
	
	s = s.split("'")[1]
	h = h.split("'")[1]
	
	if 'None' in h_hpd:
		h_lo = h
		h_hi = h
	else:
		h_hpd = h_hpd.split("'")[1]
		h_hpd = re.sub('{', '', h_hpd)
		h_hpd = re.sub('}', '', h_hpd)
		h_lo, h_hi = h_hpd.split(",")
	
	h = float(h)
	h_lo = float(h_lo)
	h_hi = float(h_hi)
	
	## Calculate dates
	date = m - h
	date_lo = m - h_hi
	date_hi = m - h_lo
	
	## Write to file
	summary_file.write('%s,%s,%s,%s\n' % (s, date, date_lo, date_hi))	
	
## Method to get consensus of trunk mutations across posterior of trees
def get_consensus_subs(psubs, n):
	print("Summarising trunk mutations present in %s%% of %s posterior trees" % (posterior_cutoff*100, n))
	with open('%strunk_mutations.csv' % prfx, 'w') as outfh:
		outfh.write("lineage,trunk substitution\n")
		for l in psubs:
			for s in psubs[l]:
				p = float(psubs[l][s])/float(n)
				#print "%s\t%s: %.3f" % (l, s, p) 
				if p >= float(posterior_cutoff):
					#print p
					outfh.write("%s,%s\n" % (l, s))
		
#### MAIN #####
## STEP 1. Load trees file
print("Loading trees")
sys.stdout.flush() 
curated_trees = dendropy.TreeList()
tree_yielder = dendropy.Tree.yield_from_files(files=[tree_file], schema='nexus', taxon_namespace=taxa, extract_comment_metadata=True)

## STEP 2. Reading the trees
i = 0
burnin=0
for tree_idx, tree in enumerate(tree_yielder):	
	# skip burnin
	if tree_idx < burnin:
		print("burning tree %s" % tree_idx)
		sys.stdout.flush()
		continue
	
	print("parsing tree %s" % tree_idx)
	sys.stdout.flush() 

	mrd = define_trunk(year_int)

	root_node = False
	for node in tree.preorder_node_iter():

		if node.parent_node is None:
			parent_node = 'Nothing'
			root_node = True
		else:
			parent_node = node.parent_node
			
		## Retrieve node annotations
		annotations = str(node.annotations)
		
		## Doing this way because the dendropy parser screws up parsing annotation sets sometimes
		cp1 = get_cp("CP1", annotations)
		cp2 = get_cp("CP2", annotations)
		cp3 = get_cp("CP3", annotations)
			
		if cp1 is None or cp2 is None or cp3 is None:
			print "Missing a value for %s" % node.taxon
			print node.annotations
			break
		
		## Get amino acid sequence from cp values, cds of HA excluding signal peptide (first 15 aa) 
		aa_seq = get_aaseq(cp1,cp2,cp3)
		
		## Retrieve important basic annotations
		posterior = get_basic_annotation('posterior', annotations)
		height = get_basic_annotation('height', annotations)
		length = get_basic_annotation('length', annotations)
		rate = get_basic_annotation('rate', annotations)
		
		height_95_HPD = get_bounded_annotation('height_95%_HPD', annotations)
		length_95_HPD = get_bounded_annotation('length_95%_HPD', annotations)
		rate_95_HPD = get_bounded_annotation('rate_95%_HPD', annotations)
	
		
		'''Full Annotations List
		prfx.CP1
		prfx.CP2
		prfx.CP3
		
		prfx.CP1.prob
		prfx.CP2.prob
		prfx.CP3.prob
		
		b_u_N=
		b_u_N_range=
		b_u_N_median=x.x
		b_u_N_95%_HPD
		
		N=x
		N_range=[x, y]
		N_median
		N_95%_HPD=[x, y]
		
		b_u_S
		b_u_S_range
		b_u_s_median
		b_u_S_95
		
		S
		S_range
		S_median
		S_95%_HPD
		
		rate
		rate_range
		rate_median
		rate_95%_HPD
		
		height
		height_range
		height_median
		height_95%_HPD
		
		length
		length_range
		length_median
		length_95%_HPD
		
		posterior		
		'''
		
		## Drop annotations
		node.annotations.drop()

		## Retain important annotations
		if posterior:
			node.annotations.add_new(name="posterior", value=posterior)
		if height:
			node.annotations.add_new(name="height", value=height)
		if length:
			node.annotations.add_new(name="length", value=length)
		if rate:
			node.annotations.add_new(name="rate", value=rate)
		if height_95_HPD:
			node.annotations.add_new(name="height_95%_HPD", value=height_95_HPD)
		if length_95_HPD:
			node.annotations.add_new(name="length_95%_HPD", value=length_95_HPD)
		if rate_95_HPD:
			node.annotations.add_new(name="rate_95%_HPD", value=rate_95_HPD)
			
		## Add new annotations
		#print node.taxon
		node.annotations.add_new(name="aa_seq", value=("'%s'" % aa_seq))
		node.annotations.add_new(name="trunk_weight", value=node.trunk_count)
		node.annotations.add_new(name="lineage", value=node.lineage)

		if not root_node:
			ancestral = (node.parent_node).annotations.find(name="aa_seq")
			#print ancestral
			ancestral = (str(ancestral)).split("'")[2]
			current = node.annotations.find(name="aa_seq")
			current = (str(current)).split("'")[2]
			
			## Get substitutions between ancestral node to current node
			subs, key_subs = get_subs(ancestral, current)
			if node.trunk_count > 10:
				node.annotations.add_new(name="substitutions", value=("%s" % subs))
				
				## Get dates and add to summary file
				if subs:
					write_mutation_dates_summary(node.annotations, mrd)
		root_node = False
	curated_trees.append(tree)
	i += 1

## STEP 3. Save consensus of trunk mutations 
	
## Remove all the weird empty lines that dendropy adds when writing tree lists 
curated_trees_string = os.linesep.join([s for s in (curated_trees.as_string("nexus")).splitlines() if s])

## Write edited tree list string to file	
with open('annotated_%s' % tree_file, 'w') as outfh:
	outfh.write(curated_trees_string)

print "Done."
summary_file.close()
sys.stdout.flush() 
