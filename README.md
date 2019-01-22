# autoPack
ios app 自动打包脚本

特别说明：1.项目没有采用Cocoapods管理，使用“方法一”完成自动打包
2.使用Cocoapods管理，项目使用“方法二”完成自动打包
方法一：

1.脚本
#注意：脚本目录和xxxx.xcodeproj要在同一个目录，如果放到其他目录，请自行修改脚本。
#工程名字(Target名字)
Project_Name="Target名字，系统默认和工程名字一样"
#配置环境，Release或者Debug
Configuration="Release"

#AdHoc版本的Bundle ID
AdHocBundleID="com.xxxxx"
#AppStore版本的Bundle ID
AppStoreBundleID="com.xxxxx"
#enterprise的Bundle ID
EnterpriseBundleID="com.xxxxx"

# ADHOC
#证书名#描述文件
ADHOCCODE_SIGN_IDENTITY="iPhone Distribution: xxxxx"
ADHOCPROVISIONING_PROFILE_NAME="xxxxx-xxxx-xxxxx-xxxxx"

#AppStore证书名#描述文件
APPSTORECODE_SIGN_IDENTITY="iPhone Distribution: xxxx"
APPSTOREROVISIONING_PROFILE_NAME="xxxx-xxxx-xxxx-xxxx-xxxx"

#企业(enterprise)证书名#描述文件
ENTERPRISECODE_SIGN_IDENTITY="iPhone Distribution: xxxx"
ENTERPRISEROVISIONING_PROFILE_NAME="xxxx-xxxx-xxxx-xxxx-xxxx"

#加载各个版本的plist文件
ADHOCExportOptionsPlist=./ADHOCExportOptionsPlist.plist
AppStoreExportOptionsPlist=./AppStoreExportOptionsPlist.plist
EnterpriseExportOptionsPlist=./EnterpriseExportOptionsPlist.plist

ADHOCExportOptionsPlist=${ADHOCExportOptionsPlist}
AppStoreExportOptionsPlist=${AppStoreExportOptionsPlist}
EnterpriseExportOptionsPlist=${EnterpriseExportOptionsPlist}

echo "~~~~~~~~~~~~选择打包方式(输入序号)~~~~~~~~~~~~~~~"
echo "      1 appstore"
echo "      2 adhoc"
echo "      3 enterprise"

# 读取用户输入并存到变量里
read parameter
sleep 0.5
method="$parameter"

# 判读用户是否有输入
if [ -n "$method" ]
then

#clean下
xcodebuild clean -xcodeproj ./$Project_Name/$Project_Name.xcodeproj -configuration $Configuration -alltargets

    if [ "$method" = "1" ]
    then

#appstore脚本
xcodebuild -project $Project_Name.xcodeproj -scheme $Project_Name -configuration $Configuration -archivePath build/$Project_Name-appstore.xcarchive clean archive build  CODE_SIGN_IDENTITY="${APPSTORECODE_SIGN_IDENTITY}" PROVISIONING_PROFILE="${APPSTOREROVISIONING_PROFILE_NAME}" PRODUCT_BUNDLE_IDENTIFIER="${AppStoreBundleID}"
xcodebuild -exportArchive -archivePath build/$Project_Name-appstore.xcarchive -exportOptionsPlist $AppStoreExportOptionsPlist -exportPath ~/Desktop/$Project_Name-appstore.ipa
    elif [ "$method" = "2" ]
    then
#adhoc脚本
xcodebuild -project $Project_Name.xcodeproj -scheme $Project_Name -configuration $Configuration -archivePath build/$Project_Name-adhoc.xcarchive clean archive build CODE_SIGN_IDENTITY="${ADHOCCODE_SIGN_IDENTITY}" PROVISIONING_PROFILE="${ADHOCPROVISIONING_PROFILE_NAME}" PRODUCT_BUNDLE_IDENTIFIER="${AdHocBundleID}"
xcodebuild -exportArchive -archivePath build/$Project_Name-adhoc.xcarchive -exportOptionsPlist $ADHOCExportOptionsPlist -exportPath ~/Desktop/$Project_Name-adhoc.ipa
    elif [ "$method" = "3" ]
    then
#企业打包脚本
xcodebuild -project $Project_Name.xcodeproj -scheme $Project_Name -configuration $Configuration -archivePath build/$Project_Name-enterprise.xcarchive clean archive build CODE_SIGN_IDENTITY="${ENTERPRISECODE_SIGN_IDENTITY}" PROVISIONING_PROFILE="${ENTERPRISEROVISIONING_PROFILE_NAME}" PRODUCT_BUNDLE_IDENTIFIER="${EnterpriseBundleID}"
xcodebuild -exportArchive -archivePath build/$Project_Name-enterprise.xcarchive -exportOptionsPlist $EnterpriseExportOptionsPlist -exportPath ~/Desktop/$Project_Name-enterprise.ipa
else
    echo "参数无效...."
    exit 1
    fi
fi


2.将脚本文件和配置文件放到项目中（由于脚本配置的路径问题，所以xcodebuild.sh和xxx.xcodeproj放到同一个目录下，否则会出现路径问题）
3.由于Xcode可以在Project->General中自动配置证书，所以用脚本打包前先去掉该功能。
4.配置脚本，需要配置的信息。
1>不需要的版本可以不用配置。比如只需要AppStore的ipa，则只需要配置AppStore版本相关的配置。
2>这里APPSTOREROVISIONING_PROFILE_NAME=、ADHOCPROVISIONING_PROFILE_NAME=和ENTERPRISEROVISIONING_PROFILE_NAME= 需要填描述文件的UUID而不是描述文件名称。查看证书名字
打开钥匙串访问,找到证书，点击显示简介，里面有个常用名称即是证书名字
点击桌面，依次点击“前往”－“前往文件夹”，输入以下地址：~/Library/MobileDevice/Provisioning Profiles
找到刚才看到的描述文件，文件名称即是描述文件的UUID，不要复制文件后缀。
5.文件的UUID添加到对应的plist文件中。
6.打开终端，cd到当前脚本所在路径，然后执行: ./xcodebuild.sh即可。
7.导出的ipa包默认保存到桌面，当前保存目录如果需要修改，可以自己修改脚本。

方法二：
1.如果你的项目用的Cocoapods管理,则上面的脚本不适用了，具体脚本如下，脚本配置和上面一样。

#注意：脚本目录和WorkSpace目录在同一个目录
#工程名字(Target名字)
Project_Name="Target名字,系统默认等于工程名字"
#workspace的名字
Workspace_Name="WorkSpace名字"
#配置环境，Release或者Debug,默认release
Configuration="Release"

#AdHoc版本的Bundle ID
AdHocBundleID="com.xxxx"
#AppStore版本的Bundle ID
AppStoreBundleID="com.xxxx"
#enterprise的Bundle ID
EnterpriseBundleID="com.xxxx"

# ADHOC证书名#描述文件
ADHOCCODE_SIGN_IDENTITY="iPhone Distribution: xxxx"
ADHOCPROVISIONING_PROFILE_NAME="xxxxx-xxxx-xxxx-xxxx-xxxxxx"

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
xcodebuild  -exportArchive -archivePath build/$Project_Name-adhoc.xcarchive -exportOptionsPlist ${ADHOCExportOptionsPlist} -exportPath ~/Desktop/$Project_Name-adhoc.ipa

    elif [ "$method" = "2" ]
    then
#appstore脚本
xcodebuild -workspace $Workspace_Name.xcworkspace -scheme $Project_Name -configuration $Configuration -archivePath build/$Project_Name-appstore.xcarchive archive build CODE_SIGN_IDENTITY="${APPSTORECODE_SIGN_IDENTITY}" PROVISIONING_PROFILE="${APPSTOREROVISIONING_PROFILE_NAME}" PRODUCT_BUNDLE_IDENTIFIER="${AppStoreBundleID}"
xcodebuild  -exportArchive -archivePath build/$Project_Name-appstore.xcarchive -exportOptionsPlist ${AppStoreExportOptionsPlist} -exportPath ~/Desktop/$Project_Name-appstore.ipa

    elif [ "$method" = "3" ]
    then
#企业打包脚本
xcodebuild -workspace $Workspace_Name.xcworkspace -scheme $Project_Name -configuration $Configuration -archivePath build/$Project_Name-enterprise.xcarchive archive build CODE_SIGN_IDENTITY="${ENTERPRISECODE_SIGN_IDENTITY}" PROVISIONING_PROFILE="${ENTERPRISEROVISIONING_PROFILE_NAME}" PRODUCT_BUNDLE_IDENTIFIER="${EnterpriseBundleID}"
xcodebuild  -exportArchive -archivePath build/$Project_Name-enterprise.xcarchive -exportOptionsPlist ${EnterpriseExportOptionsPlist} -exportPath ~/Desktop/$Project_Name-enterprise.ipa
    else
    echo "参数无效...."
    exit 1
    fi
fi

可能出现的问题
1.如果配置的证书名字、BundleID、配置文件UUID不一致，脚本就会报错
2.如果执行脚本的过程出现如下错误，在终端输入:rvm system，回车即可。
3.如果执行脚本的过程出现-bash: ./xx.sh: Permission denied,表示权限问题可以参考《Xcode编译时执行sh脚本报"Permission Denied"》
补充说明：
上面脚本默认启动Bitcode，如果你的项目中没有开启Bitcode，则可以在上面几个plist文件中加上两个键值对，分别是：uploadBitcode=NO,compileBitcode=NO
