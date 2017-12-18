#! /bin/bash
# $ ~/scripts/run_pact_batch.sh

## Make directories
mkdir -p global usa europe oceania chinasea japankorea mccts

## Move mcct files
if [ -f *.mcc.tre ]; then
	for mcct in ./*.mcc.tre
	do
		mv $mcct mccts/
	done
fi

## Loop through regions
for i in "usa" "chinasea" "oceania" "europe" "japankorea" "global";
do
	## Move trees files
	if [ -f $i*.combo.trees ]; then
		mv $i*.combo.trees $i/in.trees
	fi
	
	## Enter directory
	cd $i
	
	## If in.trees, run pact formatter and pact
	if [ -f in.trees ]; then
		echo "Analysing $i..." 
		python ~/scripts/pact_formatter.py > pact.out
		/Users/pl6//Software_downloaded/pact > pact.out
	fi
	cd ..
done
echo "Done."