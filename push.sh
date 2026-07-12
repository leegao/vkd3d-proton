bash compile.sh

# adb push vkd3d-proton-build/packaging/vkd3d-proton-2.14.1-debug.tzst /data/local/tmp

# $ adb shell run-as com.ludashi.benchmark ls -lh files/contents/VKD3D/2.9-0/system32
# total 2.8K
# -rwxrwx--x 1 u0_a390 u0_a390  84K 2026-07-10 18:46 d3d12.dll
# -rwxrwx--x 1 u0_a390 u0_a390 2.7M 2026-07-10 18:46 d3d12core.dll

push() {
    FILENAME=$(basename $1)
	adb push $1 /data/local/tmp/$FILENAME
	adb shell run-as com.ludashi.benchmark "mkdir -p $(dirname $2)"
	adb shell run-as com.ludashi.benchmark "cp /data/local/tmp/$FILENAME $2"
}

push profile.json files/contents/VKD3D/2.14-1/profile.json
push vkd3d-proton-build/x64/d3d12.dll files/contents/VKD3D/2.14-1/system32/d3d12.dll
push vkd3d-proton-build/x64/d3d12core.dll files/contents/VKD3D/2.14-1/system32/d3d12core.dll
# push vkd3d-proton-build/x86/d3d12.dll files/contents/VKD3D/2.14-1/syswow64/d3d12.dll
# push vkd3d-proton-build/x86/d3d12core.dll files/contents/VKD3D/2.14-1/syswow64/d3d12core.dll
# files/imagefs/home/xuser/.wine/drive_c/windows/system32/
push vkd3d-proton-build/x64/d3d12.dll files/imagefs/home/xuser/.wine/drive_c/windows/system32/d3d12.dll
push vkd3d-proton-build/x64/d3d12core.dll files/imagefs/home/xuser/.wine/drive_c/windows/system32/d3d12core.dll
# push vkd3d-proton-build/x86/d3d12.dll files/imagefs/home/xuser/.wine/drive_c/windows/syswow64/d3d12.dll
# push vkd3d-proton-build/x86/d3d12core.dll files/imagefs/home/xuser/.wine/drive_c/windows/syswow64/d3d12core.dll
