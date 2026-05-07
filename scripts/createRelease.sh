#!/bin/bash

set -e

baseUrl='https://files.squeak.org/trunk/'
temp=$(mktemp -d)
resultArchive="$(date +%Y%m%d)-SqueakXR-releaseImage.tar.gz"

function show() {
  echo ">>> $1"
}

function fetchSqueakReleaseName() {
 echo $(curl https://files.squeak.org/trunk/ | grep -Eo '"Squeak[^"]*?64bit' | tail -n1 | tr -d \")
}

function downloadSqueakRelease() {
  location="$baseUrl$1/$2"
  show "Downloading $location to $3"
  curl -o $3 $location
  echo $?
}

function extractSqueakRelease() {
  show "Extracting squeak release to $2"
  mkdir $2
  tar -xzvf $1 --strip-components=1 -C $2
}

function runSqueakInstallationScript() {
  show "Running squeak installation script"
  $1/squeak.sh -nodisplay -nosound "$1/shared/Squeak6.1alpha-23704-64bit.image" "$(pwd)/prepareImage.st" -- \
    -doit "TranscriptStream redirectToStdOut: true. 'lets get this party started'"
}

function archiveImage() {
  show "Creating archive $1"
  (cd $2 && tar -czvf $1 *.image *.changes SqueakV60.sources)
  echo $?
}

show "Temp dir $temp"

show "Creating a new SqueakXR image"
if [ $# -gt 0 ]; then
  if [ ! -f $1 ]; then
    show "File $1 does not exist, aborting"
    exit -1
  fi
  zipLocation=$1
  show "Using existing release $zipLocation"
else
  releaseName=$(fetchSqueakReleaseName)
  # TODO: search this instead
  zipName="$releaseName-202312181441-Linux-x64.tar.gz"
  zipLocation="$temp/$zipName"
  show "Release is $releaseName"
  downloadSqueakRelease $releaseName $zipName $zipLocation
fi
releaseLocation=$temp/release
extractSqueakRelease "$zipLocation" "$releaseLocation" 
runSqueakInstallationScript "$releaseLocation"
if archiveImage $resultArchive $releaseLocation/shared; then
  show "Done!"
  exit 0
fi

show "Failed!"
exit -1

