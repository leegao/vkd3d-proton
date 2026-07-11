# bash package-release.sh build . --dev-build

ninja -C vkd3d-proton-build/build.64

# ls vkd3d-proton-build/x86
# d3d12.dll  d3d12.dll.a  d3d12core.dll  d3d12core.dll.a
# ls vkd3d-proton-build/x64
# d3d12.dll  d3d12.dll.a  d3d12core.dll  d3d12core.dll.a

function package {
  cd vkd3d-proton-build

  rm -rf packaging
  mkdir -p packaging
  cp -r x64 packaging/system32
  cp -r x86 packaging/syswow64

  cd packaging
  tar -cvf vkd3d-proton-2.14.1-debug.tar system32 syswow64
  zstd vkd3d-proton-2.14.1-debug.tar -o vkd3d-proton-2.14.1-debug.tzst
  cd ../../

}

package
