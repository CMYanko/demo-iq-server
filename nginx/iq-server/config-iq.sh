#!/bin/bash

#Note: defaults creds are baked in so this will work on a fresh instance
nexus() {
java -jar nexus-iq-cli-1.45.0-01.jar \
  -s http://localhost:8070 $@
}


cd iq-server

echo "Importing license"
# Update this to point to your license placed in this folder
#nexus license install <your license file>
nexus license install sonatype-nexus-firewall-lifecycle-2017.lic

#these policies are based on the sample set with some changes I've made and exported.
echo "Applying policies"
nexus policy import myPolicies.json

#need to pop back up so we end where we started
cd ..
pwd