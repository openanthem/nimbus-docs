#!/bin/bash

STYLE_SHEET=colony
STYLE_SHEET_PATH=./stylesheets/$STYLE_SHEET.css

DOCS="
BPMConfiguration.adoc 
Documentation.adoc 
Features.adoc 
FrameworkOverview.adoc 
Github.adoc 
Exercise1.adoc 
Exercise2.adoc 
Exercise3.adoc 
Exercise4.adoc 
Exercise5.adoc 
MainMenu.adoc 
Nimbus.adoc 
nimbus-team-org.adoc 
ReleaseNotes.adoc 
SampleApplication.adoc 
TechnicalArchitecture.adoc 
Training.adoc 
ViewConfiguration.adoc 
Querydsl.adoc 
Quickstart.adoc"

asciidoctor -a stylesheet=$STYLE_SHEET_PATH $DOCS