#!/bin/bash

###############################################################################
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corporation 2019. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
###############################################################################

. $(dirname "$0")/set_common.sh

npmPath=$(which npm)

if [[ $? = 0 ]]; then
  npmPath=$(dirname "$npmPath")
else
  echo "No npm, something must seriously be wrong."
  exit 1
fi

# npm install -g npm@3.8.0

export PATH="$npmPath":"$PATH"

git clone --depth 1 "https://$IDS_TOKEN@github.ibm.com/org-ids/otc-deploy"

otc-deploy/cf-apps/common/pipeline.build.sh

npm install
npm run unittests
