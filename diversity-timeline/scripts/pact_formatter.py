#! /Users/pl6/homebrew/bin/python
# $ ~/scripts/pact_formatter.py

### This script accepts a in.trees file and formats an in.param file for input for pact
### By finding oldest and most recent tip dates
### Sets up tmrca skyline analysis

import sys, re, os, datetime

#from datetime import date
## For local
sys.path.insert(0, "/Users/pl6/homebrew/lib/python2.7/site-packages/")

## For farm
#sys.path.insert(0, "/software/pathogen/external/lib/python2.7/site-packages/DendroPy-3.12.0-py2.7.egg/")
import dendropy

## Accept user arguments
tree_file = "in.trees"

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
		except (ValueError, IndexError) as e:
			day = 1
		
		plain_date = '%s-%s-%s' % (yr, mth, day)
		plain_date = datetime.datetime.strptime(plain_date, '%Y-%m-%d').date()
		start_year = datetime.date(year=plain_date.year, month=1, day=1).toordinal()
		node_date = plain_date.toordinal()
		next_year = datetime.date(plain_date.year+1, 1, 1).toordinal()
		dec_date = plain_date.year + (node_date - start_year) / float(next_year - start_year)
	
	elif re.search("[0-9][0-9][0-9][0-9]", plain_date):
		yr = int(plain_date.split('-')[0])
		plain_date = '%s-01-01' % yr
		plain_date = datetime.datetime.strptime(plain_date, '%Y-%m-%d').date()
		start_year = datetime.date(year=plain_date.year, month=1, day=1).toordinal()
		node_date = plain_date.toordinal()
		next_year = datetime.date(plain_date.year+1, 1, 1).toordinal()
		dec_date = plain_date.year + (node_date - start_year) / float(next_year - start_year)
	
	else:
		sys.exit("[ERROR]: Unusual parsing of date %s" % plain_date)
	#print "decimal date: %s\n" % dec_date
	return dec_date

## Load trees file
taxa = dendropy.TaxonNamespace()
tree_yielder = dendropy.Tree.yield_from_files(files=[tree_file], schema='nexus', taxon_namespace=taxa, extract_comment_metadata=True)

for i, tree in enumerate(tree_yielder):
	## Only read the first tree
	if i < 1:
		most_recent_date = -1e10
		oldest_date = 1e10
		for node in tree.leaf_node_iter():
			#Get leaf num_date from taxaname
			node.num_date = get_num_date(str(node.taxon))
		
			if node.num_date > most_recent_date:
				most_recent_date = node.num_date
			
			if node.num_date < oldest_date:
				oldest_date = node.num_date
	else:
		break

## Get beginning skyline time
j = oldest_date % 1.0
if j < 0.33:
	beg_sky = oldest_date - j + 0.33
elif j > 0.33 and j < 0.83:
	beg_sky = oldest_date - j + 0.83
elif j > 0.83:
	beg_sky = oldest_date - j + 1.33
else:
	print "oops %s" % oldest_date

## ending skyline time
k = most_recent_date % 1.0
if k > 0.83:
	end_sky = most_recent_date - k + 0.83
elif k > 0.33 and k < 0.83:
	end_sky = most_recent_date - k + 0.33
elif k < 0.33:
	end_sky = most_recent_date - k - 0.17
else:
	print "oops %s" % most_recent_date

'''## Special skyline times for start and end at *.83:
r = abs((beg_sky % 1) - 0.83)
if r < 0.001:
	beg_sky = beg_sky
else:
	beg_sky = beg_sky + 0.5

s = abs((end_sky % 1) - 0.83)
if s < 0.001:
	end_sky = end_sky
else:
	end_sky = end_sky + 0.5'''
	
with open('in.param', 'w') as outfh:
	outfh.write('push times back %s %s\n' % (oldest_date, most_recent_date))
	outfh.write('skyline settings %s %s 0.5\n' % (beg_sky, end_sky))
	outfh.write('skyline diversity')

print("Done")