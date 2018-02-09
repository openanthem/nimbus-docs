[![license](https://img.shields.io/github/license/openanthem/nimbus-docs.svg)]() [![GitHub last commit](https://img.shields.io/github/last-commit/openanthem/nimbus-docs.svg)]() [![GitHub contributors](https://img.shields.io/github/contributors/openanthem/nimbus-docs.svg)]()


# Automation overview

# Workstation setup for local builds

Requirements for NIMBUS-DOCS

* Have the nimbus-docs repository cloned.
* Ruby must be available on workstation
    * Windows:
        * https://rubyinstaller.org/downloads/
        * Download and install latest version 
        * Make sure to select Use UTF-8 as default external encoding. 
        * Upon completed installation, clicking finish -  allow Ruby Installed to run, select option 1 MSYS2 base installation
        * Select defaults during installation of MSYS2 base
    * Linux:  
        * Documentation Source:  https://rvm.io/rvm/install
        * Install ruby version manager
        * gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
        * \curl -sSL https://get.rvm.io | bash
        * rvm install ruby-2.5.0
* Installing asciidoctor
    * Documentation Source: http://asciidoctor.org/docs/install-toolchain/
    * Windows
        * Click start, search Start command prompt with Ruby, which opens a cmd prompt
    * Linux
        * You will have to exit terminal, and open a new terminal for path statements and ruby to be available.
    * Type: gem install asciidoctor
* Installing doctoolchain
    * Windows and Linux: **INSTALL to $HOME/.doctoolchain
    * Documentation source: https://doctoolchain.github.io/docToolchain/#_get_the_tool
        * Download: https://github.com/docToolchain/docToolchain/archive/master.zip
        * Extract doctoolchain to a folder, called <doctoolchain> here on out
        * Download: https://github.com/hakimel/reveal.js/archive/tags/3.3.0.zip
        * Extract contents reveal.js archive into <doctoolchain>\resources\reveal.js
        * Download: https://github.com/asciidoctor/asciidoctor-reveal.js/archive/9667f5c.zip
        * Extract contents of asciidoctor-reveal.js archive into <doctoolchain>\resources\asciidoctor-reveal.js
        * Append to your workstations system path <doctoolchain>\bin
* Open a new ruby command prompt, so as to refresh shells paths.
    * Change directory into the nimbus-docs repository
    * Execute: scripts\generate-nimbus-documentation.sh

When the execution completed, you will find the updated documentation in nimbus-docs/builds/html5



# Useful links:

http://asciidoctor.org/docs/user-manual/

Some notes to help build documentation later.

** If you'd like to generate local documentation for your review

Requirements:

Asciidoctor works on Linux, OS X (aka Mac OS X) and Windows.

Asciidoctor requires one of the following implementations of Ruby:

* Ruby 1.8.7

* Ruby 1.9.3

* Ruby 2 (2.0.0 or better)

* JRuby 1.7 (Ruby 1.8 and 1.9 modes)

* JRuby 9000

* Rubinius 2.0 (Ruby 1.8 and 1.9 modes)

* Opal (Javascript)

For ruby, i'd recommend using Ruby Version Manager (rvm), as its available for all platforms.

Once ruby is installed, Asciidoctor can be installed through

gem install Asciidoctor

Installation can be verified with
asciidoctor --version

Once Asciidoctor is installed you can continue

1. Clone this respository
2. Cd into cloned repositories directory
3. Execute: asciidoctor -d book src/Nimbus.adoc -D build/html5/

# Known issues
## Issue #1 that must be averted

Line 1 of any page of a book is reserved for the title, and if you're executing
a macro you must begin on line 2.  

For example, if the dashed lines represent the top of page.

This is wrong, and will not render properly - Graphical breakout will not render.
-----------------------------------
.More to come
NOTE: More fun things to come soon
-----------------------------------

This is correct, if the line represents top of page
-----------------------------------

.More to come
NOTE: More fun things to come soon
-----------------------------------

## Issue #2 that must be averted

All characters which are normally encoded with http parsers, for safety reasons,
should also be coded in the page's text.  This must occur because all Asciidoc
pages will be converted to XHTML and uploaded to Confluence via rest api and
text on a page is preserved, and as such the payload will cause the processor
to exit with HTTP 400 errors, bad request.

Example:

Good: https://&lt;USEDID&gt;@bitbucket.anthem.com/scm/nim/petclinic-training.git
Bad: https://<USEDID>@bitbucket.anthem.com/scm/nim/petclinic-training.git

Make sure to escape the following

Space	&#32;	&nbsp;
"	&#34;	&quot;
&	&#38;	&amp;
<	&#60;	&lt;
>	&#62;	&gt;

The above are the most often seen, however if you use keyboards other than standard
108 us layout, then you may need others.  A complete list can be found.

http://www.theukwebdesigncompany.com/articles/entity-escape-characters.php

## Issue #3 that we can't forget

When supplying the user name and the password to the scripts/DeployNimbusDocumentation-Confluence.groovy file

You must base64 encode the credentials string of USERNAME:PASSWORD and supply that hash

Confluence library doesn't perform this for you, and the system will never authenticate or upload.

This can be performed from command line with the following command

echo -n 'USERNAME:PASSWORD' | openssl base64


# How-to make changes
## Document how to structure chapters, and pages in documentation book

Keen note that must be remembered, you must pay special attention to the rules
of Asciidocs for :sects - Example you must not skip levels, either forward or backward
it should be progressive.

Documentation link: http://asciidoctor.org/docs/asciidoc-writers-guide/#section-titles

Section levels cannot be chosen arbitrarily. There are two rules you must follow:

A document can only have multiple level 0 sections if the doctype is set to book.[1]

Section levels cannot be skipped when nesting sections

For example, the following syntax is illegal:

= Document Title

= Illegal Level 0 Section (violates rule #1)

== First Section

==== Illegal Nested Section (violates rule #2)


Content above the first section (after the document title) is part of the preamble. Once the first section is reached, content is associated with the section that precedes it:

== First Section

Content of first section

=== Nested Section

Content of nested section

== Second Section

Content of second section

## How to DeployNimbusDocumentation-ConfluenceConfig

1. Clone this respository
2. cd into folder
3. Execute ./scripts/generate-nimbus-documentation.sh

This will build the html files, and then upload them to the confluence page



** TODOS

1. Modify the generate-nimbus-documentation.sh script to perform base64 encoding, and stuff into environment variable
2. Modify the groovy script to read the base64 encoded username and password from env.
3. Store the username and password as a global variable in build system.  That way we do not expose critical credentials.

** AsciiDocs cheat sheet
https://powerman.name/doc/asciidoc
