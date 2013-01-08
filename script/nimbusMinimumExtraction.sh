NIMBUS_DIR=../lib/nimbus
DST=../lib/nimbusPhotoMin

PATH1="src/pagingscrollview/src"
PATH2="src/photos/src"
NIMBUS_CORE="${NIMBUS_DIR}/src/core/src"

if [ ! -e ${DST} ]
	then
	echo "doesn't exist"
	mkdir ${DST}
fi


 cp ${NIMBUS_DIR}/${PATH1}/* ${DST}
 cp ${NIMBUS_DIR}/${PATH2}/* ${DST}
 cp ${NIMBUS_CORE}/NIViewRecycler.* ${DST}
 cp ${NIMBUS_CORE}/NimbusCore.* ${DST}
 cp ${NIMBUS_CORE}/NIPreprocessorMacros.h ${DST}
 cp ${NIMBUS_CORE}/NISDKAvailability.* ${DST}
 cp ${NIMBUS_CORE}/NIPaths.* ${DST}
 cp ${NIMBUS_CORE}/NIDebuggingTools.* ${DST}
 cp ${NIMBUS_CORE}/NIFoundationMethods.* ${DST}
 cp ${NIMBUS_CORE}/NICommonMetrics.* ${DST}
 cp ${NIMBUS_CORE}/NIDeviceOrientation.* ${DST}
#	if you want to use the NIInMemoryCache include these files
 cp ${NIMBUS_CORE}/NIDataStructures.* ${DST}
 cp ${NIMBUS_CORE}/NIInMemoryCache.* ${DST}
 cp ${NIMBUS_CORE}/NIPreprocessorMacros.h ${DST}

 # cp ${NIMBUS_DIR}/examples/photos/NetworkPhotoAlbums/src/NetworkPhotoAlbumViewController.* ${DST}
 cp -r ${NIMBUS_DIR}/src/photos/resources/NimbusPhotos.bundle ${DST}


pushd ${DST}
sed -ie 's|#import "NIError.h"|//#import "NIError.h"|g' NimbusCore.h
sed -ie 's|#import "NIInMemoryCache.h"|//#import "NIInMemoryCache.h"|g' NimbusCore.h
sed -ie 's|#import "NINavigationAppearance.h"|//#import "NINavigationAppearance.h"|g' NimbusCore.h
sed -ie 's|#import "NINetworkActivity.h"|//#import "NINetworkActivity.h"|g' NimbusCore.h
sed -ie 's|#import "NINonEmptyCollectionTesting.h"|//#import "NINonEmptyCollectionTesting.h"|g' NimbusCore.h
sed -ie 's|#import "NINonRetainingCollections.h"|//#import "NINonRetainingCollections.h"|g' NimbusCore.h
sed -ie 's|#import "NIOperations.h"|//#import "NIOperations.h"|g' NimbusCore.h
sed -ie 's|#import "NIRuntimeClassModifications.h"|//#import "NIRuntimeClassModifications.h"|g' NimbusCore.h
sed -ie 's|#import "NISnapshotRotation.h"|//#import "NISnapshotRotation.h"|g' NimbusCore.h
sed -ie 's|#import "NIState.h"|//#import "NIState.h"|g' NimbusCore.h
rm NimbusCore.he
popd
