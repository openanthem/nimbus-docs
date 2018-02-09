#!/bin/bash

# First create the HTML outputs for each of the parent pages to be published.

# Docmentation outline

# nimbus
## features
## training
## documentation
## framework-overview

# You have to create the HTML first
asciidoctor -d book src/Nimbus.adoc -D build/html5/

# Now you can publish the html to confluence.
#../scratch/doctoolchain/bin/doctoolchain . publishToConfluence -PconfluenceConfigFile=scripts/Documentation-ConfluenceConfig.groovy
$HOME/.doctoolchain/bin/doctoolchain . publishToConfluence -PconfluenceConfigFile=scripts/DeployNimbusDocumentation-ConfluenceConfig.groovy --no-daemon -q --stacktrace --debug
