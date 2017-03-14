
SCHEMENAME=Test
BRANCHNAME=develop

# config
DATE=`date +%Y%m%d_%H%M`
# echo "DATE=$DATE"
SOURCEPATH=$( cd "$( dirname $0 )" && pwd)
# echo "工程目录是：$SOURCEPATH"
IPAPATH=$SOURCEPATH/AutoBuildIPA/$BRANCHNAME/$DATE
IPANAME=$SCHEMENAME_$DATE.ipa
echo "Start"
# start build
xcodebuild \
-workspace $SOURCEPATH/$SCHEMENAME.xcodeproj/project.xcworkspace \
-scheme $SCHEMENAME \
-configuration Debug \
-sdk iphoneos \
clean \
build \
-derivedDataPath $IPAPATH

# CODE_SIGN_IDENTITY="iPhone Developer: JianCheng Lin(2327WL4BK7)" \
# PROVISIONING_PROFILE="9fc08dcd-ea32-4c9b-8e8a-0ffddf6ea56a.mobileprovision" \

if [ -e $IPAPATH ]; then
	echo "xcodebuild Successfil"
else
	echo "xcodebuild error"
	exit 1
fi

#xcrun .ipa
xcrun -sdk iphoneos PackageApplication \
	-v $IPAPATH/Build/Products/Debug-iphoneos/$SCHEMENAME.app \
	-o $IPAPATH/$IPANAME

if [ -e $IPAPATH/$IPANAME ]; then
	echo "----------------------------\n\n\n"
	echo "xcrun build Successful"
	echo "----------------------------\n\n\n"
else 
	echo "----------------------------\n\n\n"
	echo "xcrun build error"
	echo "----------------------------\n\n\n"
fi
