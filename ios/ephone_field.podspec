#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
#
Pod::Spec.new do |s|
  s.name             = 'ephone_field'
  s.version          = '0.0.3'
  s.summary          = 'Email/phone TextFormField with bundled Google libphonenumber.'
  s.description      = <<-DESC
Email and phone Flutter field. Android/iOS builds include Google libphonenumber (C++)
via dart:ffi for validation, E.164 formatting, and as-you-type formatting.
                       DESC
  s.homepage         = 'https://github.com/desxz/ephone_field'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Murat Gun' => 'muratgun545@gmail.com' }
  s.source           = { :path => '.' }

  # Thin Obj-C/C++ shim kept so Flutter generates the ephone_field framework;
  # real symbols come from the CMake static stack force-loaded below.
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'
  s.libraries = 'c++'
  s.frameworks = 'Foundation'

  s.preserve_paths = [
    'cmake_build.sh',
    'ephone_exports.txt',
    'prebuilt/**/*',
    '../src/**/*',
    '../third_party/libphonenumber/**/*',
  ]

  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    # Apple Silicon simulators are arm64-only; our prebuilt stacks match that.
    # Building x86_64 (Intel sim) would fail to force_load the arm64 archive.
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 x86_64',
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++17',
    'OTHER_CFLAGS' => '-DEPHONE_HAS_LIBPHONENUMBER=1',
    'OTHER_CPLUSPLUSFLAGS' => '-DEPHONE_HAS_LIBPHONENUMBER=1',
    'ONLY_ACTIVE_ARCH' => 'YES',
    'OTHER_LDFLAGS' => '$(inherited) -force_load "${PODS_TARGET_SRCROOT}/build/libephone_phonenumber_stack-${PLATFORM_NAME}.a" -lc++',
  }

  s.script_phases = [
    {
      :name => 'Build ephone_field libphonenumber stack',
      :execution_position => :before_compile,
      :script => <<-SCRIPT
        set -e
        chmod +x "${PODS_TARGET_SRCROOT}/cmake_build.sh"
        export PLATFORM_NAME="${PLATFORM_NAME}"
        export ARCHS="${ARCHS}"
        export CONFIGURATION="${CONFIGURATION}"
        export IPHONEOS_DEPLOYMENT_TARGET="${IPHONEOS_DEPLOYMENT_TARGET}"
        "${PODS_TARGET_SRCROOT}/cmake_build.sh"
      SCRIPT
    }
  ]

  s.swift_version = '5.0'
end
