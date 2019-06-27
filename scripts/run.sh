#!/bin/sh -xe
if echo $CODEBUILD_SOURCE_VERSION | grep -q 'pr/'; then
  /bin/sh scripts/plan.sh
else
  /bin/sh scripts/apply.sh
fi

