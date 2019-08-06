sfdx force:org:create -s -d 30 -f config/DE.json -a $1
sfdx force:source:push -f
sfdx force:org:open