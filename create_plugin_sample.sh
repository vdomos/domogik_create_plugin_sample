#! /bin/bash

# Create main folders and files in one shot for Domogik Plugins
# http://docs.domogik.org/domogik/develop/en/package_development/plugins/plugin_file_tree/create_sample.html?highlight=create_sample
# sh create_plugin_sample.sh plugin_name

# -----------------------------------------------------------------------------
PLUGIN_ID=$1
if [ -z "$PLUGIN_ID" ]
then
	echo "    Usage: $0 plugin_name copyright"
	echo "     Example: $0 plugin_name '2015, Name'"
	exit 1
fi

COPYRIGHT=$2
if [ -z "$COPYRIGHT" ]
then
	COPYRIGHT='2015, noname'
fi

# -----------------------------------------------------------------------------

mkdir "plugin_$PLUGIN_ID"
cd plugin_$PLUGIN_ID

# python part
touch __init__.py
mkdir bin
touch bin/__init__.py
touch bin/${PLUGIN_ID}.py
mkdir lib
touch lib/__init__.py
touch lib/${PLUGIN_ID}.py
mkdir conversion
touch conversion/__init__.py

# various
mkdir data
mkdir udev
mkdir design
#touch design/icon.png
echo "icon PNG format, 96*96 px, Be GPL compliant (don’t use private or non free existing icons)" > design/icon.txt

# tests
touch .travis.yml
mkdir tests

# docs
mkdir docs
touch docs/dev.txt 
touch docs/tests.txt

# -----------------------------------------------------------------------------
# docs/conf.py 
cat << EOF >> docs/conf.py

import sys
import os

extensions = [
    'sphinx.ext.todo',
]

source_suffix = '.txt'

master_doc = 'index'

### part to update ###################################
project = u'domogik-plugin-${PLUGIN_ID}'
copyright = u'$COPYRIGHT'
version = '0.1'
release = version
######################################################

pygments_style = 'sphinx'

html_theme = 'default'
html_static_path = ['_static']
EOF


# -----------------------------------------------------------------------------
# docs/index.txt 
cat << EOF >> docs/index.txt
.. _toc:

================
Table Of Content
================

.. toctree::

    /script
    /dev
    /tests
    /changelog
EOF


# -----------------------------------------------------------------------------
# docs/${PLUGIN_ID}.txt 
cat << EOF >> docs/${PLUGIN_ID}.txt 
.. _index:

===================
Plugin ${PLUGIN_ID}
===================

Purpose
=======

.. raw:: html

   <br />
   <hr>

Dependencies
============

.. raw:: html

   <br />
   <hr>

Plugin configuration
====================

.. raw:: html

   <br />
   <hr>

Create the devices
==================

Device parameters configuration
-------------------------------

X parameters are needed for a domogik device creation ...


===================== =========================== ======================================================================
Key                   Type                        Description
===================== =========================== ======================================================================
key1                  datatype                    ...
--------------------- --------------------------- ----------------------------------------------------------------------
key2                  datatype                    ...
===================== =========================== ======================================================================


.. raw:: html

   <br />
   <hr>

Start the plugin
================

You can now start the plugin (start button) and use the created devices.

.. raw:: html

   <br />
   <hr>

Set up your widgets on the user interface
=========================================

You can now place the widgets of your devices features on the user interface.

.. raw:: html

   <br />
EOF


# -----------------------------------------------------------------------------
# docs/changelog.txt
cat << EOF >> docs/changelog.txt
=========
Changelog
=========

0.1
===

* Plugin creation
EOF


# -----------------------------------------------------------------------------
# README.md
cat << EOF >> README.md
# Domogik Plugin $PLUGIN_ID

## Purpose

This is a package for Domogik : http://www.domogik.org

Domogik is an open source home automation solution.

## Documentation 

You can find the documentation source in the **docs/** folder. When the package will be installed, the documentation will be available in the **Documentation** menu of the Domogik administration for this package.
You may also find online documentation for this plugin. You will be able to find the documentation url on http://repo-public.domogik.org/dashboard

## Install the package

To install this package on your Domogik system, you can go in this GitHub repository releases page and get the link to a release .zip file. Then you just have to do :

    dmg_package -i http://path.to/the/file.zip
EOF


# -----------------------------------------------------------------------------
# CHANGELOG
echo "The changelog informations are available in docs/changelog.txt" > CHANGELOG


# -----------------------------------------------------------------------------
# start.sh
echo "export PYTHONPATH=/var/lib/domogik && /usr/bin/python bin/$PLUGIN_ID.py -f" > start.sh
chmod u+x start.sh


# -----------------------------------------------------------------------------
# .gitignore
cat << EOF >> .gitignore
*.pyc
*.swp
_build_doc
*~
*.20*

EOF


# -----------------------------------------------------------------------------
# json part
cat << EOF >> info.json
{
    "json_version": 2,
    "products" : [],
    "identity": {},
    "configuration": [],
    "commands": {},
    "xpl_commands": {},
    "sensors": {},
    "xpl_stats": {},
    "device_types": {},
}
EOF

