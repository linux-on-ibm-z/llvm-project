; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mcpu=pwr8 -mattr=+vsx \
; RUN:   -mtriple=powerpc64le-unknown-linux-gnu < %s | FileCheck %s

; RUN: llc -verify-machineinstrs -mcpu=pwr9 -mattr=-power9-vector \
; RUN:   -mtriple=powerpc64le-unknown-linux-gnu < %s | FileCheck %s

; RUN: llc -verify-machineinstrs -mcpu=pwr9 -mattr=+vsx \
; RUN:   -mtriple=powerpc64le-unknown-linux-gnu < %s | FileCheck %s \
; RUN:   --check-prefix=CHECK-P9 --implicit-check-not xxswapd

define <2 x double> @test00(<2 x double>* %p1, <2 x double>* %p2) {
; CHECK-LABEL: test00:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lxvd2x 0, 0, 3
; CHECK-NEXT:    xxspltd 34, 0, 0
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: test00:
; CHECK-P9:       # %bb.0:
; CHECK-P9-NEXT:    lxv 0, 0(3)
; CHECK-P9-NEXT:    xxspltd 34, 0, 1
; CHECK-P9-NEXT:    blr
  %v1 = load <2 x double>, <2 x double>* %p1
  %v2 = load <2 x double>, <2 x double>* %p2
  %v3 = shufflevector <2 x double> %v1, <2 x double> %v2, <2 x i32> < i32 0, i32 0>
  ret <2 x double> %v3
}

define <2 x double> @test01(<2 x double>* %p1, <2 x double>* %p2) {
; CHECK-LABEL: test01:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lxvd2x 0, 0, 3
; CHECK-NEXT:    xxswapd 34, 0
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: test01:
; CHECK-P9:       # %bb.0:
; CHECK-P9-NEXT:    lxv 34, 0(3)
; CHECK-P9-NEXT:    blr
  %v1 = load <2 x double>, <2 x double>* %p1
  %v2 = load <2 x double>, <2 x double>* %p2
  %v3 = shufflevector <2 x double> %v1, <2 x double> %v2, <2 x i32> < i32 0, i32 1>
  ret <2 x double> %v3
}

define <2 x double> @test02(<2 x double>* %p1, <2 x double>* %p2) {
; CHECK-LABEL: test02:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lxvd2x 0, 0, 3
; CHECK-NEXT:    lxvd2x 1, 0, 4
; CHECK-NEXT:    xxswapd 0, 0
; CHECK-NEXT:    xxswapd 1, 1
; CHECK-NEXT:    xxmrgld 34, 1, 0
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: test02:
; CHECK-P9:       # %bb.0:
; CHECK-P9-NEXT:    lxv 0, 0(3)
; CHECK-P9-NEXT:    lxv 1, 0(4)
; CHECK-P9-NEXT:    xxmrgld 34, 1, 0
; CHECK-P9-NEXT:    blr
  %v1 = load <2 x double>, <2 x double>* %p1
  %v2 = load <2 x double>, <2 x double>* %p2
  %v3 = shufflevector <2 x double> %v1, <2 x double> %v2, <2 x i32> < i32 0, i32 2>
  ret <2 x double> %v3
}

define <2 x double> @test03(<2 x double>* %p1, <2 x double>* %p2) {
; CHECK-LABEL: test03:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lxvd2x 0, 0, 3
; CHECK-NEXT:    lxvd2x 1, 0, 4
; CHECK-NEXT:    xxswapd 0, 0
; CHECK-NEXT:    xxswapd 1, 1
; CHECK-NEXT:    xxpermdi 34, 1, 0, 1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: test03:
; CHECK-P9:       # %bb.0:
; CHECK-P9-NEXT:    lxv 0, 0(3)
; CHECK-P9-NEXT:    lxv 1, 0(4)
; CHECK-P9-NEXT:    xxpermdi 34, 1, 0, 1
; CHECK-P9-NEXT:    blr
  %v1 = load <2 x double>, <2 x double>* %p1
  %v2 = load <2 x double>, <2 x double>* %p2
  %v3 = shufflevector <2 x double> %v1, <2 x double> %v2, <2 x i32> < i32 0, i32 3>
  ret <2 x double> %v3
}

define <2 x double> @test10(<2 x double>* %p1, <2 x double>* %p2) {
; CHECK-LABEL: test10:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lxvd2x 34, 0, 3
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: test10:
; CHECK-P9:       # %bb.0:
; CHECK-P9-NEXT:    lxvd2x 34, 0, 3
; CHECK-P9-NEXT:    blr
  %v1 = load <2 x double>, <2 x double>* %p1
  %v2 = load <2 x double>, <2 x double>* %p2
  %v3 = shufflevector <2 x double> %v1, <2 x double> %v2, <2 x i32> < i32 1, i32 0>
  ret <2 x double> %v3
}

define <2 x double> @test11(<2 x double>* %p1, <2 x double>* %p2) {
; CHECK-LABEL: test11:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lxvd2x 0, 0, 3
; CHECK-NEXT:    xxspltd 34, 0, 1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: test11:
; CHECK-P9:       # %bb.0:
; CHECK-P9-NEXT:    lxv 0, 0(3)
; CHECK-P9-NEXT:    xxspltd 34, 0, 0
; CHECK-P9-NEXT:    blr
  %v1 = load <2 x double>, <2 x double>* %p1
  %v2 = load <2 x double>, <2 x double>* %p2
  %v3 = shufflevector <2 x double> %v1, <2 x double> %v2, <2 x i32> < i32 1, i32 1>
  ret <2 x double> %v3
}

define <2 x double> @test12(<2 x double>* %p1, <2 x double>* %p2) {
; CHECK-LABEL: test12:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lxvd2x 0, 0, 3
; CHECK-NEXT:    lxvd2x 1, 0, 4
; CHECK-NEXT:    xxswapd 0, 0
; CHECK-NEXT:    xxswapd 1, 1
; CHECK-NEXT:    xxpermdi 34, 1, 0, 2
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: test12:
; CHECK-P9:       # %bb.0:
; CHECK-P9-NEXT:    lxv 0, 0(3)
; CHECK-P9-NEXT:    lxv 1, 0(4)
; CHECK-P9-NEXT:    xxpermdi 34, 1, 0, 2
; CHECK-P9-NEXT:    blr
  %v1 = load <2 x double>, <2 x double>* %p1
  %v2 = load <2 x double>, <2 x double>* %p2
  %v3 = shufflevector <2 x double> %v1, <2 x double> %v2, <2 x i32> < i32 1, i32 2>
  ret <2 x double> %v3
}

define <2 x double> @test13(<2 x double>* %p1, <2 x double>* %p2) {
; CHECK-LABEL: test13:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lxvd2x 0, 0, 3
; CHECK-NEXT:    lxvd2x 1, 0, 4
; CHECK-NEXT:    xxswapd 0, 0
; CHECK-NEXT:    xxswapd 1, 1
; CHECK-NEXT:    xxmrghd 34, 1, 0
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: test13:
; CHECK-P9:       # %bb.0:
; CHECK-P9-NEXT:    lxv 0, 0(3)
; CHECK-P9-NEXT:    lxv 1, 0(4)
; CHECK-P9-NEXT:    xxmrghd 34, 1, 0
; CHECK-P9-NEXT:    blr
  %v1 = load <2 x double>, <2 x double>* %p1
  %v2 = load <2 x double>, <2 x double>* %p2
  %v3 = shufflevector <2 x double> %v1, <2 x double> %v2, <2 x i32> < i32 1, i32 3>
  ret <2 x double> %v3
}

define <2 x double> @test20(<2 x double>* %p1, <2 x double>* %p2) {
; CHECK-LABEL: test20:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lxvd2x 0, 0, 3
; CHECK-NEXT:    lxvd2x 1, 0, 4
; CHECK-NEXT:    xxswapd 0, 0
; CHECK-NEXT:    xxswapd 1, 1
; CHECK-NEXT:    xxmrgld 34, 0, 1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: test20:
; CHECK-P9:       # %bb.0:
; CHECK-P9-NEXT:    lxv 0, 0(3)
; CHECK-P9-NEXT:    lxv 1, 0(4)
; CHECK-P9-NEXT:    xxmrgld 34, 0, 1
; CHECK-P9-NEXT:    blr
  %v1 = load <2 x double>, <2 x double>* %p1
  %v2 = load <2 x double>, <2 x double>* %p2
  %v3 = shufflevector <2 x double> %v1, <2 x double> %v2, <2 x i32> < i32 2, i32 0>
  ret <2 x double> %v3
}

define <2 x double> @test21(<2 x double>* %p1, <2 x double>* %p2) {
; CHECK-LABEL: test21:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lxvd2x 0, 0, 3
; CHECK-NEXT:    lxvd2x 1, 0, 4
; CHECK-NEXT:    xxswapd 0, 0
; CHECK-NEXT:    xxswapd 1, 1
; CHECK-NEXT:    xxpermdi 34, 0, 1, 1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: test21:
; CHECK-P9:       # %bb.0:
; CHECK-P9-NEXT:    lxv 0, 0(3)
; CHECK-P9-NEXT:    lxv 1, 0(4)
; CHECK-P9-NEXT:    xxpermdi 34, 0, 1, 1
; CHECK-P9-NEXT:    blr
  %v1 = load <2 x double>, <2 x double>* %p1
  %v2 = load <2 x double>, <2 x double>* %p2
  %v3 = shufflevector <2 x double> %v1, <2 x double> %v2, <2 x i32> < i32 2, i32 1>
  ret <2 x double> %v3
}

define <2 x double> @test22(<2 x double>* %p1, <2 x double>* %p2) {
; CHECK-LABEL: test22:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lxvd2x 0, 0, 4
; CHECK-NEXT:    xxspltd 34, 0, 0
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: test22:
; CHECK-P9:       # %bb.0:
; CHECK-P9-NEXT:    lxv 0, 0(4)
; CHECK-P9-NEXT:    xxspltd 34, 0, 1
; CHECK-P9-NEXT:    blr
  %v1 = load <2 x double>, <2 x double>* %p1
  %v2 = load <2 x double>, <2 x double>* %p2
  %v3 = shufflevector <2 x double> %v1, <2 x double> %v2, <2 x i32> < i32 2, i32 2>
  ret <2 x double> %v3
}

define <2 x double> @test23(<2 x double>* %p1, <2 x double>* %p2) {
; CHECK-LABEL: test23:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lxvd2x 0, 0, 4
; CHECK-NEXT:    xxswapd 34, 0
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: test23:
; CHECK-P9:       # %bb.0:
; CHECK-P9-NEXT:    lxv 34, 0(4)
; CHECK-P9-NEXT:    blr
  %v1 = load <2 x double>, <2 x double>* %p1
  %v2 = load <2 x double>, <2 x double>* %p2
  %v3 = shufflevector <2 x double> %v1, <2 x double> %v2, <2 x i32> < i32 2, i32 3>
  ret <2 x double> %v3
}

define <2 x double> @test30(<2 x double>* %p1, <2 x double>* %p2) {
; CHECK-LABEL: test30:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lxvd2x 0, 0, 3
; CHECK-NEXT:    lxvd2x 1, 0, 4
; CHECK-NEXT:    xxswapd 0, 0
; CHECK-NEXT:    xxswapd 1, 1
; CHECK-NEXT:    xxpermdi 34, 0, 1, 2
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: test30:
; CHECK-P9:       # %bb.0:
; CHECK-P9-NEXT:    lxv 0, 0(3)
; CHECK-P9-NEXT:    lxv 1, 0(4)
; CHECK-P9-NEXT:    xxpermdi 34, 0, 1, 2
; CHECK-P9-NEXT:    blr
  %v1 = load <2 x double>, <2 x double>* %p1
  %v2 = load <2 x double>, <2 x double>* %p2
  %v3 = shufflevector <2 x double> %v1, <2 x double> %v2, <2 x i32> < i32 3, i32 0>
  ret <2 x double> %v3
}

define <2 x double> @test31(<2 x double>* %p1, <2 x double>* %p2) {
; CHECK-LABEL: test31:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lxvd2x 0, 0, 3
; CHECK-NEXT:    lxvd2x 1, 0, 4
; CHECK-NEXT:    xxswapd 0, 0
; CHECK-NEXT:    xxswapd 1, 1
; CHECK-NEXT:    xxmrghd 34, 0, 1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: test31:
; CHECK-P9:       # %bb.0:
; CHECK-P9-NEXT:    lxv 0, 0(3)
; CHECK-P9-NEXT:    lxv 1, 0(4)
; CHECK-P9-NEXT:    xxmrghd 34, 0, 1
; CHECK-P9-NEXT:    blr
  %v1 = load <2 x double>, <2 x double>* %p1
  %v2 = load <2 x double>, <2 x double>* %p2
  %v3 = shufflevector <2 x double> %v1, <2 x double> %v2, <2 x i32> < i32 3, i32 1>
  ret <2 x double> %v3
}

define <2 x double> @test32(<2 x double>* %p1, <2 x double>* %p2) {
; CHECK-LABEL: test32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lxvd2x 34, 0, 4
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: test32:
; CHECK-P9:       # %bb.0:
; CHECK-P9-NEXT:    lxvd2x 34, 0, 4
; CHECK-P9-NEXT:    blr
  %v1 = load <2 x double>, <2 x double>* %p1
  %v2 = load <2 x double>, <2 x double>* %p2
  %v3 = shufflevector <2 x double> %v1, <2 x double> %v2, <2 x i32> < i32 3, i32 2>
  ret <2 x double> %v3
}

define <2 x double> @test33(<2 x double>* %p1, <2 x double>* %p2) {
; CHECK-LABEL: test33:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lxvd2x 0, 0, 4
; CHECK-NEXT:    xxspltd 34, 0, 1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: test33:
; CHECK-P9:       # %bb.0:
; CHECK-P9-NEXT:    lxv 0, 0(4)
; CHECK-P9-NEXT:    xxspltd 34, 0, 0
; CHECK-P9-NEXT:    blr
  %v1 = load <2 x double>, <2 x double>* %p1
  %v2 = load <2 x double>, <2 x double>* %p2
  %v3 = shufflevector <2 x double> %v1, <2 x double> %v2, <2 x i32> < i32 3, i32 3>
  ret <2 x double> %v3
}
