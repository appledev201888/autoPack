#注意：脚本目录和WorkSpace目录在同一个目录
#工程名字(Target名字)
Project_Name="CWBHuBiApp"
#workspace的名字
Workspace_Name="CWBHuBiApp"
#配置环境，Release或者Debug,默认release
Configuration="release"

#AdHoc版本的Bundle ID
AdHocBundleID="com.hubi.global"
#AppStore版本的Bundle ID
AppStoreBundleID="com.hubi.global"
#enterprise的Bundle ID
EnterpriseBundleID="com.hubi.global"

# ADHOC证书名#描述文件
ADHOCCODE_SIGN_IDENTITY="iPhone Distribution: HK BLOCKCHAIN ERA NETWORK TECHNOLOGY LIMITED (CK65RZRTQ7)"
ADHOCPROVISIONING_PROFILE_NAME="822f4e69-4c55-456c-a8bb-d6260ab83098"

#AppStore证书名#描述文件
APPSTORECODE_SIGN_IDENTITY="iPhone Distribution: xxxxx"
APPSTOREROVISIONING_PROFILE_NAME="xxxxx-xxxx-xxxx-xxxx-xxxxxx"

#企业(enterprise)证书名#描述文件
ENTERPRISECODE_SIGN_IDENTITY="iPhone Distribution: xxxx"
ENTERPRISEROVISIONING_PROFILE_NAME="xxxxx-xxxx-xxx-xxxx"

#加载各个版本的plist文件
ADHOCExportOptionsPlist=./ADHOCExportOptionsPlist.plist
AppStoreExportOptionsPlist=./AppStoreExportOptionsPlist.plist
EnterpriseExportOptionsPlist=./EnterpriseExportOptionsPlist.plist

ADHOCExportOptionsPlist=${ADHOCExportOptionsPlist}
AppStoreExportOptionsPlist=${AppStoreExportOptionsPlist}
EnterpriseExportOptionsPlist=${EnterpriseExportOptionsPlist}

echo "~~~~~~~~~~~~选择打包方式(输入序号)~~~~~~~~~~~~~~~"
echo "      1 adHoc"
echo "      2 AppStore"
echo "      3 Enterprise"

# 读取用户输入并存到变量里
read parameter
sleep 0.5
method="$parameter"

# 判读用户是否有输入
if [ -n "$method" ]
then
if [ "$method" = "1" ]
then
#adhoc脚本
xcodebuild -workspace $Workspace_Name.xcworkspace -scheme $Project_Name -configuration $Configuration -archivePath build/$Project_Name-adhoc.xcarchive clean archive build CODE_SIGN_IDENTITY="${ADHOCCODE_SIGN_IDENTITY}" PROVISIONING_PROFILE="${ADHOCPROVISIONING_PROFILE_NAME}" PRODUCT_BUNDLE_IDENTIFIER="${AdHocBundleID}"
xcodebuild  -exportArchive -archivePath build/$Project_Name-adhoc.xcarchive -exportOptionsPlist ${ADHOCExportOptionsPlist} -exportPath /Users/apple/Desktop/UUTaka/ios/CWBHuBiApp/$Project_Name-adhoc.ipa

elif [ "$method" = "2" ]
then
#appstore脚本
xcodebuild -workspace $Workspace_Name.xcworkspace -scheme $Project_Name -configuration $Configuration -archivePath build/$Project_Name-appstore.xcarchive archive build CODE_SIGN_IDENTITY="${APPSTORECODE_SIGN_IDENTITY}" PROVISIONING_PROFILE="${APPSTOREROVISIONING_PROFILE_NAME}" PRODUCT_BUNDLE_IDENTIFIER="${AppStoreBundleID}"
xcodebuild  -exportArchive -archivePath build/$Project_Name-appstore.xcarchive -exportOptionsPlist ${AppStoreExportOptionsPlist} -exportPath /Users/apple/Desktop/UUTaka/ios/CWBHuBiApp/$Project_Name-appstore.ipa

elif [ "$method" = "3" ]
then
#企业打包脚本
xcodebuild -workspace $Workspace_Name.xcworkspace -scheme $Project_Name -configuration $Configuration -archivePath build/$Project_Name-enterprise.xcarchive archive build CODE_SIGN_IDENTITY="${ENTERPRISECODE_SIGN_IDENTITY}" PROVISIONING_PROFILE="${ENTERPRISEROVISIONING_PROFILE_NAME}" PRODUCT_BUNDLE_IDENTIFIER="${EnterpriseBundleID}"
xcodebuild  -exportArchive -archivePath build/$Project_Name-enterprise.xcarchive -exportOptionsPlist ${EnterpriseExportOptionsPlist} -exportPath /Users/apple/Desktop/UUTaka/ios/CWBHuBiApp/$Project_Name-enterprise.ipa
else
echo "参数无效...."
exit 1
fi
fi

