#!/bin/bash

set -eu

source smoketest-settings/helpers.sh

host=`setting "kratos_admin_endpoint"`
port=`setting "kratos_admin_port"`

set +e
for i in {1..15}; do
  echo "Attempt ${i} to curl kratos"
  curl --location -f ${host}:${port}/admin/health/ready
  if [[ $? == 0 ]]; then success="true"; break; fi;
  sleep 1
done
set -e

if [[ "$success" != "true" ]]; then echo "Smoke test failed" && exit 1; fi;
