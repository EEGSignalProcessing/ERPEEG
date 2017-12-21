# ERPEEG
An online repository of the ERPEEG toolbox http://www.tmseeg.com

INTRODUCTION
-------------------
ERPEEG is a Matlab App designed for streamlined processing of ERP data.  Processing steps are presented using a
GUI format with modularity.  

REQUIREMENTS
--------------------
ERPEEG was built on MATLAB v2013a, with use of EEGLAB v12.0.2.6b.  Both
EEGLAB and MATLAB support backward compatibility with more recent releases.

* MATLAB  - http://www.mathworks.com/products/matlab/
* EEGLAB  - http://sccn.ucsd.edu/eeglab/downloadtoolbox.php
* FASTICA - http://research.ics.aalto.fi/ica/fastica/code/dlcode.shtml
* tight_subplot.m - http://www.mathworks.com/matlabcentral/fileexchange/27991-tight-subplot-nh--nw--gap--marg-h--marg-w-

INSTALLATION
---------------------

ERPEEG is packages as a MATLAB App for easy installation.  For further 
instruction: 
http://www.mathworks.com/videos/packaging-and-installing-matlab-apps-70404.html

* Ensure that the MATLAB signal processing toolkit has path priority

MAINTAINER
--------------

Current Maintainers: 
* Faranak Farzan
* Sravya Atluri
* Benjamin Schwartzmann

GETTING STARTED
--------------

Visit the [wiki page](https://github.com/EEGSignalProcessing/ERPEEG/wiki/Getting-Started) for links to [sample data sets](http://www.tmseeg.com/wp-content/uploads/2016/05/SampleData.zip) and the [offical tutorial](http://www.tmseeg.com/wp-content/uploads/2017/02/ERPEEG-Tutorial-v1.pdf). A couple main things to keep in mind  

1) ERPEEG toolbox requires [EEGLAB](https://sccn.ucsd.edu/eeglab/downloadtoolbox.php) to be installed
2) MATLAB is picky about [paths](http://www.mathworks.com/help/matlab/ref/path.html?s_tid=gn_loc_drop). After download, pay attention to how the paths are set as indicated by the tutorial and documentation. If you receive an error that a file is missing it is probably because either the dependencies are not installed or because the paths are not set correctly
3) You'll also need to download [FastICA](http://www.cis.hut.fi/projects/ica/fastica/) and have it on your path for the ERPEEG toolbox to work as is
4) Once you've downloaded everything and have your paths set, open MATLAB to the folder containing ERPEEG and simply doubleclick the .mlappinstall file (erpeeg2017.mlappinstall).
