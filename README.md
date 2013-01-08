[Nimbus](https://github.com/jverkoey/nimbus) has one of the best image gallery libraries around.  The only thing of value in this repo is the [nimbusMinimumExtraction.sh](https://github.com/bluwave/NimbusPhotoGalleryMin/blob/master/script/nimbusMinimumExtraction.sh) script that copies the bare minimum files from the slightly large nimbus project to get the image gallery working.  

## steps to get this example working

steps to make this work:

1. git clone ...
2. git submodule update --init --recursive 
3. `cd script && chmod 755 nimbusMinimumExtraction.sh && ./nimbusMinimumExtraction.sh`

## nimbusMinimumExtraction script

This script copies the bare minimum files from the nimbus project into the folder `lib/nimbusPhotoMin`.  You must have already fetched (step 2 above) the nimbus submodule for the script to work.

## caching

Nimbus includes caching `NIInMemoryCache`.  If you desire to use a different type of caching, you can comment out the following lines in the `nimbusMinimumExtraction.sh` script

```bash
cp ${NIMBUS_CORE}/NIDataStructures.* ${DST}
cp ${NIMBUS_CORE}/NIInMemoryCache.* ${DST}
cp ${NIMBUS_CORE}/NIPreprocessorMacros.h ${DST}
````

## adding minimum nimbus photo galleries to an existing project

1. copy [script](https://github.com/bluwave/NimbusPhotoGalleryMin/blob/master/script/nimbusMinimumExtraction.sh) to your project directory
2. clone the [nimbus](https://github.com/jverkoey/nimbus) project locally
3. change the [script](https://github.com/bluwave/NimbusPhotoGalleryMin/blob/master/script/nimbusMinimumExtraction.sh) *DIRECTORY LOCATION VARIABLES* to point to nimbus project folder you just cloned and the location in your existing project where you would like nimbus photo gallery files to be located.
    i.e.

    ```bash 
	#DIRECTORY LOCATION VARIABLES
	NIMBUS_DIR=<path to nimbus project here>
	DST=<nimbus folder in LIB DIRECTORY of your existing project (i.e. DST="lib/nimbusPhotoMinFiles")>
	```	

4. run the script
5. Add the directory of minimum nimbus files you just copied from the script to your existing xcode project.

