#!/bin/bash

# args: releasetag massage?

[[ $# -ne 2 ]] && echo "need release tag and release massage" && exit 1

name="ATAP"

tmp=$(mktemp --tmpdir -d ATAPXXXXXXX)
scriptDir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
callDir=$(pwd)  # need to cd back after tar directory change

auditor="$scriptDir/../../ATAPAuditor"
report="$scriptDir/../../ATAPHtmlReport"

specForm="$scriptDir/assets_RPM/$name.spec"
spec="$tmp/rpmbuild/SPECS/$name.spec"
source="$tmp/rpmbuild/SOURCES/$name-$1"
sourceDir="$tmp/rpmbuild/SOURCES"
package="$tmp/rpmbuild/RPMS/noarch/$name-$1-*.noarch.rpm"


# create dir structure
mkdir -p $tmp/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
mkdir $source


# copie needed files and create tar package
cp -r -t $source $auditor $report
cd $sourceDir
tar -czvf $name-$1.tar.gz $name-$1 &>/dev/null
cd $callDir


# ready changelogentry for spec
date=$(LANG=en_US date +"%a %b %d %Y %H:%M:%S %z")
sed "s/<version>/$1/ ; s/<massage>/$2/ ; s/<date>/$date/" $specForm > $spec


# build & move rpm package and rm dir structure
rpmbuild --define "_topdir $tmp/rpmbuild" -ba $spec &>/dev/null
mv $package ./$name.rpm && echo "successfully created $name.rpm"
rm -r $tmp

exit 0