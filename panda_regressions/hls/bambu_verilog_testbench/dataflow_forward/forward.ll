; ModuleID = 'linked.ll'
source_filename = "llvm-link"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx16.0.0"

%class.ac_channel = type <{ %"class.std::__1::deque", i32, float, i32, [4 x i8] }>
%"class.std::__1::deque" = type { %"struct.std::__1::__split_buffer", i64, %"class.std::__1::__compressed_pair.1" }
%"struct.std::__1::__split_buffer" = type { ptr, ptr, ptr, %"class.std::__1::__compressed_pair" }
%"class.std::__1::__compressed_pair" = type { %"struct.std::__1::__compressed_pair_elem" }
%"struct.std::__1::__compressed_pair_elem" = type { ptr }
%"class.std::__1::__compressed_pair.1" = type { %"struct.std::__1::__compressed_pair_elem.2" }
%"struct.std::__1::__compressed_pair_elem.2" = type { i64 }
%"class.std::__1::__deque_iterator" = type { ptr, ptr }
%"struct.std::__1::integral_constant.7" = type { i8 }
%struct.ac_exception = type { ptr, i32, i32, ptr }
%"struct.std::__1::__split_buffer.8" = type { ptr, ptr, ptr, %"class.std::__1::__compressed_pair.9" }
%"class.std::__1::__compressed_pair.9" = type { %"struct.std::__1::__compressed_pair_elem", %"struct.std::__1::__compressed_pair_elem" }
%"class.std::__1::unique_ptr" = type { %"class.std::__1::__compressed_pair.11" }
%"class.std::__1::__compressed_pair.11" = type { %"struct.std::__1::__compressed_pair_elem", %"struct.std::__1::__compressed_pair_elem.13" }
%"struct.std::__1::__compressed_pair_elem.13" = type { %"class.std::__1::__allocator_destructor" }
%"class.std::__1::__allocator_destructor" = type { ptr, i64 }
%"struct.std::__1::__split_buffer<float *, std::__1::allocator<float *> &>::_ConstructTransaction" = type { ptr, ptr, ptr }

@.str = private unnamed_addr constant [76 x i8] c"/Users/tdysart/SODA-OPT/panda/install-devpanda19/include/panda/ac_channel.h\00", align 1
@__stderrp = external global ptr, align 8
@.str.1 = private unnamed_addr constant [7 x i8] c"Assert\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c" in file %s:%u\00", align 1
@.str.3 = private unnamed_addr constant [5 x i8] c" %s\0A\00", align 1
@__func__._ZN10ac_channelIfE9ac_assertEbPKciRKN20ac_channel_exception4codeE = private unnamed_addr constant [10 x i8] c"ac_assert\00", align 1
@.str.4 = private unnamed_addr constant [13 x i8] c"ac_channel.h\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"0\00", align 1
@_ZZN20ac_channel_exception3msgERKNS_4codeEE1s = linkonce_odr constant [9 x ptr] [ptr @.str.6, ptr @.str.7, ptr @.str.8, ptr @.str.9, ptr @.str.10, ptr @.str.11, ptr @.str.12, ptr @.str.13, ptr @.str.14], align 8
@.str.6 = private unnamed_addr constant [24 x i8] c"Read from empty channel\00", align 1
@.str.7 = private unnamed_addr constant [26 x i8] c"fifo not empty when reset\00", align 1
@.str.8 = private unnamed_addr constant [39 x i8] c"No operator[] defined for channel type\00", align 1
@.str.9 = private unnamed_addr constant [35 x i8] c"No insert defined for channel type\00", align 1
@.str.10 = private unnamed_addr constant [33 x i8] c"No peek defined for channel type\00", align 1
@.str.11 = private unnamed_addr constant [36 x i8] c"Connections does not support size()\00", align 1
@.str.12 = private unnamed_addr constant [40 x i8] c"Connections does not support num_free()\00", align 1
@.str.13 = private unnamed_addr constant [42 x i8] c"Connections::Out does not support empty()\00", align 1
@.str.14 = private unnamed_addr constant [22 x i8] c"Write to full channel\00", align 1
@_ZTISt20bad_array_new_length = external constant ptr

define void @node0(ptr noalias %0, ptr noalias %1) {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca float, align 4
  %7 = alloca ptr, align 8
  br label %8

8:                                                ; preds = %25, %2
  %9 = phi i64 [ %26, %25 ], [ 0, %2 ]
  %10 = icmp slt i64 %9, 8
  br i1 %10, label %11, label %27

11:                                               ; preds = %14, %8
  %12 = phi i64 [ %24, %14 ], [ 0, %8 ]
  %13 = icmp slt i64 %12, 4
  br i1 %13, label %14, label %25

14:                                               ; preds = %11
  call void @llvm.lifetime.start.p0(i64 8, ptr %3)
  call void @llvm.lifetime.start.p0(i64 8, ptr %4)
  call void @llvm.lifetime.start.p0(i64 8, ptr %5)
  call void @llvm.lifetime.start.p0(i64 4, ptr %6)
  call void @llvm.lifetime.start.p0(i64 8, ptr %7)
  store ptr %0, ptr %7, align 8
  %15 = load ptr, ptr %7, align 8
  store ptr %15, ptr %5, align 8
  %16 = load ptr, ptr %5, align 8
  store ptr %16, ptr %3, align 8
  store ptr %6, ptr %4, align 8
  %17 = load ptr, ptr %3, align 8
  %18 = call noundef float @_ZN10ac_channelIfE20_read_bambu_internalIfEEKT_v(ptr noundef nonnull align 8 dereferenceable(60) %17)
  %19 = load ptr, ptr %4, align 8
  store float %18, ptr %19, align 4
  %20 = load float, ptr %6, align 4
  call void @llvm.lifetime.end.p0(i64 8, ptr %3)
  call void @llvm.lifetime.end.p0(i64 8, ptr %4)
  call void @llvm.lifetime.end.p0(i64 8, ptr %5)
  call void @llvm.lifetime.end.p0(i64 4, ptr %6)
  call void @llvm.lifetime.end.p0(i64 8, ptr %7)
  %21 = mul i64 %9, 4
  %22 = add i64 %21, %12
  %23 = getelementptr float, ptr %1, i64 %22
  store float %20, ptr %23, align 4
  %24 = add i64 %12, 1
  br label %11

25:                                               ; preds = %11
  %26 = add i64 %9, 1
  br label %8

27:                                               ; preds = %8
  ret void
}

define void @node1(ptr noalias %0, ptr noalias %1, ptr noalias %2, double %3, float %4) {
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca float, align 4
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca ptr, align 8
  %15 = alloca float, align 4
  %16 = alloca ptr, align 8
  br label %17

17:                                               ; preds = %46, %5
  %18 = phi i64 [ %47, %46 ], [ 0, %5 ]
  %19 = icmp slt i64 %18, 8
  br i1 %19, label %20, label %48

20:                                               ; preds = %23, %17
  %21 = phi i64 [ %45, %23 ], [ 0, %17 ]
  %22 = icmp slt i64 %21, 4
  br i1 %22, label %23, label %46

23:                                               ; preds = %20
  call void @llvm.lifetime.start.p0(i64 8, ptr %12)
  call void @llvm.lifetime.start.p0(i64 8, ptr %13)
  call void @llvm.lifetime.start.p0(i64 8, ptr %14)
  call void @llvm.lifetime.start.p0(i64 4, ptr %15)
  call void @llvm.lifetime.start.p0(i64 8, ptr %16)
  store ptr %0, ptr %16, align 8
  %24 = load ptr, ptr %16, align 8
  store ptr %24, ptr %14, align 8
  %25 = load ptr, ptr %14, align 8
  store ptr %25, ptr %12, align 8
  store ptr %15, ptr %13, align 8
  %26 = load ptr, ptr %12, align 8
  %27 = call noundef float @_ZN10ac_channelIfE20_read_bambu_internalIfEEKT_v(ptr noundef nonnull align 8 dereferenceable(60) %26)
  %28 = load ptr, ptr %13, align 8
  store float %27, ptr %28, align 4
  %29 = load float, ptr %15, align 4
  call void @llvm.lifetime.end.p0(i64 8, ptr %12)
  call void @llvm.lifetime.end.p0(i64 8, ptr %13)
  call void @llvm.lifetime.end.p0(i64 8, ptr %14)
  call void @llvm.lifetime.end.p0(i64 4, ptr %15)
  call void @llvm.lifetime.end.p0(i64 8, ptr %16)
  %30 = mul i64 %18, 4
  %31 = add i64 %30, %21
  %32 = getelementptr float, ptr %1, i64 %31
  %33 = load float, ptr %32, align 4
  %34 = fptrunc double %3 to float
  %35 = fmul float %33, %34
  %36 = fmul float %29, %4
  %37 = fadd float %36, %35
  call void @llvm.lifetime.start.p0(i64 8, ptr %6)
  call void @llvm.lifetime.start.p0(i64 8, ptr %7)
  call void @llvm.lifetime.start.p0(i64 8, ptr %8)
  call void @llvm.lifetime.start.p0(i64 8, ptr %9)
  call void @llvm.lifetime.start.p0(i64 8, ptr %10)
  call void @llvm.lifetime.start.p0(i64 4, ptr %11)
  store ptr %2, ptr %10, align 8
  store float %37, ptr %11, align 4
  %38 = load ptr, ptr %10, align 8
  store ptr %38, ptr %8, align 8
  store ptr %11, ptr %9, align 8
  %39 = load ptr, ptr %8, align 8
  %40 = load ptr, ptr %9, align 8
  store ptr %39, ptr %6, align 8
  store ptr %40, ptr %7, align 8
  %41 = load ptr, ptr %6, align 8
  %42 = load ptr, ptr %7, align 8
  %43 = load float, ptr %42, align 4
  %44 = call noundef zeroext i1 @_ZN10ac_channelIfE21_write_bambu_internalIfEEbT_(ptr noundef nonnull align 8 dereferenceable(60) %41, float noundef %43)
  call void @llvm.lifetime.end.p0(i64 8, ptr %6)
  call void @llvm.lifetime.end.p0(i64 8, ptr %7)
  call void @llvm.lifetime.end.p0(i64 8, ptr %8)
  call void @llvm.lifetime.end.p0(i64 8, ptr %9)
  call void @llvm.lifetime.end.p0(i64 8, ptr %10)
  call void @llvm.lifetime.end.p0(i64 4, ptr %11)
  %45 = add i64 %21, 1
  br label %20

46:                                               ; preds = %20
  %47 = add i64 %18, 1
  br label %17

48:                                               ; preds = %17
  ret void
}

define void @node2(ptr noalias %0, ptr noalias %1, ptr noalias %2, float %3) {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca float, align 4
  %11 = alloca float, i64 32, align 64
  br label %12

12:                                               ; preds = %57, %4
  %13 = phi i64 [ %58, %57 ], [ 0, %4 ]
  %14 = icmp slt i64 %13, 8
  br i1 %14, label %15, label %59

15:                                               ; preds = %55, %12
  %16 = phi i64 [ %56, %55 ], [ 0, %12 ]
  %17 = icmp slt i64 %16, 4
  br i1 %17, label %18, label %57

18:                                               ; preds = %53, %15
  %19 = phi i64 [ %54, %53 ], [ 0, %15 ]
  %20 = icmp slt i64 %19, 6
  br i1 %20, label %21, label %55

21:                                               ; preds = %18
  %22 = mul i64 %13, 6
  %23 = add i64 %22, %19
  %24 = getelementptr float, ptr %0, i64 %23
  %25 = load float, ptr %24, align 4
  %26 = mul i64 %19, 4
  %27 = add i64 %26, %16
  %28 = getelementptr float, ptr %1, i64 %27
  %29 = load float, ptr %28, align 4
  %30 = icmp eq i64 %19, 0
  br i1 %30, label %31, label %35

31:                                               ; preds = %21
  %32 = mul i64 %13, 4
  %33 = add i64 %32, %16
  %34 = getelementptr float, ptr %11, i64 %33
  store float %3, ptr %34, align 4
  br label %35

35:                                               ; preds = %31, %21
  %36 = mul i64 %13, 4
  %37 = add i64 %36, %16
  %38 = getelementptr float, ptr %11, i64 %37
  %39 = load float, ptr %38, align 4
  %40 = fmul float %25, %29
  %41 = fadd float %39, %40
  store float %41, ptr %38, align 4
  %42 = add i64 %19, -5
  %43 = icmp eq i64 %42, 0
  br i1 %43, label %44, label %53

44:                                               ; preds = %35
  %45 = load float, ptr %38, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr %5)
  call void @llvm.lifetime.start.p0(i64 8, ptr %6)
  call void @llvm.lifetime.start.p0(i64 8, ptr %7)
  call void @llvm.lifetime.start.p0(i64 8, ptr %8)
  call void @llvm.lifetime.start.p0(i64 8, ptr %9)
  call void @llvm.lifetime.start.p0(i64 4, ptr %10)
  store ptr %2, ptr %9, align 8
  store float %45, ptr %10, align 4
  %46 = load ptr, ptr %9, align 8
  store ptr %46, ptr %7, align 8
  store ptr %10, ptr %8, align 8
  %47 = load ptr, ptr %7, align 8
  %48 = load ptr, ptr %8, align 8
  store ptr %47, ptr %5, align 8
  store ptr %48, ptr %6, align 8
  %49 = load ptr, ptr %5, align 8
  %50 = load ptr, ptr %6, align 8
  %51 = load float, ptr %50, align 4
  %52 = call noundef zeroext i1 @_ZN10ac_channelIfE21_write_bambu_internalIfEEbT_(ptr noundef nonnull align 8 dereferenceable(60) %49, float noundef %51)
  call void @llvm.lifetime.end.p0(i64 8, ptr %5)
  call void @llvm.lifetime.end.p0(i64 8, ptr %6)
  call void @llvm.lifetime.end.p0(i64 8, ptr %7)
  call void @llvm.lifetime.end.p0(i64 8, ptr %8)
  call void @llvm.lifetime.end.p0(i64 8, ptr %9)
  call void @llvm.lifetime.end.p0(i64 4, ptr %10)
  br label %53

53:                                               ; preds = %44, %35
  %54 = add i64 %19, 1
  br label %18

55:                                               ; preds = %18
  %56 = add i64 %16, 1
  br label %15

57:                                               ; preds = %15
  %58 = add i64 %13, 1
  br label %12

59:                                               ; preds = %12
  ret void
}

define void @forward(ptr noalias %0, ptr noalias %1, ptr noalias %2, ptr noalias %3) {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca %class.ac_channel, i64 1, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr %8)
  store ptr %9, ptr %8, align 8
  %10 = load ptr, ptr %8, align 8
  %11 = call noundef ptr @_ZN10ac_channelIfEC1Ev(ptr noundef nonnull align 8 dereferenceable(60) %10)
  call void @llvm.lifetime.end.p0(i64 8, ptr %8)
  %12 = alloca %class.ac_channel, i64 1, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr %7)
  store ptr %12, ptr %7, align 8
  %13 = load ptr, ptr %7, align 8
  %14 = call noundef ptr @_ZN10ac_channelIfEC1Ev(ptr noundef nonnull align 8 dereferenceable(60) %13)
  call void @llvm.lifetime.end.p0(i64 8, ptr %7)
  call void @node2(ptr %0, ptr %1, ptr %12, float 0.000000e+00)
  call void @node1(ptr %12, ptr %2, ptr %9, double 1.000000e-01, float 5.000000e-01)
  call void @node0(ptr %9, ptr %3)
  call void @llvm.lifetime.start.p0(i64 8, ptr %6)
  store ptr %9, ptr %6, align 8
  %15 = load ptr, ptr %6, align 8
  %16 = call noundef ptr @_ZN10ac_channelIfED1Ev(ptr noundef nonnull align 8 dereferenceable(60) %15) #13
  call void @llvm.lifetime.end.p0(i64 8, ptr %6)
  call void @llvm.lifetime.start.p0(i64 8, ptr %5)
  store ptr %12, ptr %5, align 8
  %17 = load ptr, ptr %5, align 8
  %18 = call noundef ptr @_ZN10ac_channelIfED1Ev(ptr noundef nonnull align 8 dereferenceable(60) %17) #13
  call void @llvm.lifetime.end.p0(i64 8, ptr %5)
  ret void
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define void @__df_anchor_f32() #0 {
  %1 = alloca %class.ac_channel, align 8
  %2 = call noundef ptr @_ZN10ac_channelIfEC1Ev(ptr noundef nonnull align 8 dereferenceable(60) %1)
  %3 = call noundef ptr @_ZN10ac_channelIfED1Ev(ptr noundef nonnull align 8 dereferenceable(60) %1) #13
  ret void
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN10ac_channelIfEC1Ev(ptr noundef nonnull returned align 8 dereferenceable(60) %0) unnamed_addr #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN10ac_channelIfEC2Ev(ptr noundef nonnull align 8 dereferenceable(60) %3)
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN10ac_channelIfED1Ev(ptr noundef nonnull returned align 8 dereferenceable(60) %0) unnamed_addr #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN10ac_channelIfED2Ev(ptr noundef nonnull align 8 dereferenceable(60) %3) #13
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN10ac_channelIfED2Ev(ptr noundef nonnull returned align 8 dereferenceable(60) %0) unnamed_addr #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %class.ac_channel, ptr %3, i32 0, i32 0
  %5 = call noundef ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEED1B8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %4) #13
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEED1B8ne190107Ev(ptr noundef nonnull returned align 8 dereferenceable(48) %0) unnamed_addr #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEED2B8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %3) #13
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEED2B8ne190107Ev(ptr noundef nonnull returned align 8 dereferenceable(48) %0) unnamed_addr #1 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %6 = load ptr, ptr %3, align 8
  store ptr %6, ptr %2, align 8
  call void @_ZNSt3__15dequeIfNS_9allocatorIfEEE5clearEv(ptr noundef nonnull align 8 dereferenceable(48) %6) #13
  call void @_ZNKSt3__15dequeIfNS_9allocatorIfEEE17__annotate_deleteB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %6) #13
  %7 = getelementptr inbounds %"class.std::__1::deque", ptr %6, i32 0, i32 0
  %8 = call noundef ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE5beginB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %7) #13
  store ptr %8, ptr %4, align 8
  %9 = getelementptr inbounds %"class.std::__1::deque", ptr %6, i32 0, i32 0
  %10 = call noundef ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE3endB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %9) #13
  store ptr %10, ptr %5, align 8
  br label %11

11:                                               ; preds = %19, %1
  %12 = load ptr, ptr %4, align 8
  %13 = load ptr, ptr %5, align 8
  %14 = icmp ne ptr %12, %13
  br i1 %14, label %15, label %22

15:                                               ; preds = %11
  %16 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %6) #13
  %17 = load ptr, ptr %4, align 8
  %18 = load ptr, ptr %17, align 8
  call void @_ZNSt3__116allocator_traitsINS_9allocatorIfEEE10deallocateB8ne190107ERS2_Pfm(ptr noundef nonnull align 1 dereferenceable(1) %16, ptr noundef %18, i64 noundef 1024) #13
  br label %19

19:                                               ; preds = %15
  %20 = load ptr, ptr %4, align 8
  %21 = getelementptr inbounds ptr, ptr %20, i32 1
  store ptr %21, ptr %4, align 8
  br label %11, !llvm.loop !7

22:                                               ; preds = %11
  %23 = getelementptr inbounds %"class.std::__1::deque", ptr %6, i32 0, i32 0
  %24 = call noundef ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEED1Ev(ptr noundef nonnull align 8 dereferenceable(32) %23) #13
  %25 = load ptr, ptr %2, align 8
  ret ptr %25
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__15dequeIfNS_9allocatorIfEEE5clearEv(ptr noundef nonnull align 8 dereferenceable(48) %0) #1 personality ptr @__gxx_personality_v0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca %"class.std::__1::__deque_iterator", align 8
  %5 = alloca %"class.std::__1::__deque_iterator", align 8
  store ptr %0, ptr %2, align 8
  %6 = load ptr, ptr %2, align 8
  call void @_ZNKSt3__15dequeIfNS_9allocatorIfEEE17__annotate_deleteB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %6) #13
  %7 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %6) #13
  store ptr %7, ptr %3, align 8
  %8 = call [2 x i64] @_ZNSt3__15dequeIfNS_9allocatorIfEEE5beginB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %6) #13
  store [2 x i64] %8, ptr %4, align 8
  %9 = call [2 x i64] @_ZNSt3__15dequeIfNS_9allocatorIfEEE3endB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %6) #13
  store [2 x i64] %9, ptr %5, align 8
  br label %10

10:                                               ; preds = %20, %1
  %11 = invoke noundef zeroext i1 @_ZNSt3__1neB8ne190107ERKNS_16__deque_iteratorIfPfRfPS1_lLl1024EEES6_(ptr noundef nonnull align 8 dereferenceable(16) %4, ptr noundef nonnull align 8 dereferenceable(16) %5)
          to label %12 unwind label %45

12:                                               ; preds = %10
  br i1 %11, label %13, label %21

13:                                               ; preds = %12
  %14 = load ptr, ptr %3, align 8
  %15 = invoke noundef nonnull align 4 dereferenceable(4) ptr @_ZNKSt3__116__deque_iteratorIfPfRfPS1_lLl1024EEdeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(16) %4)
          to label %16 unwind label %45

16:                                               ; preds = %13
  invoke void @_ZNSt3__116allocator_traitsINS_9allocatorIfEEE7destroyB8ne190107IfTnNS_9enable_ifIXsr13__has_destroyIS2_PT_EE5valueEiE4typeELi0EEEvRS2_S7_(ptr noundef nonnull align 1 dereferenceable(1) %14, ptr noundef %15)
          to label %17 unwind label %45

17:                                               ; preds = %16
  br label %18

18:                                               ; preds = %17
  %19 = invoke noundef nonnull align 8 dereferenceable(16) ptr @_ZNSt3__116__deque_iteratorIfPfRfPS1_lLl1024EEppB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(16) %4)
          to label %20 unwind label %45

20:                                               ; preds = %18
  br label %10, !llvm.loop !9

21:                                               ; preds = %12
  %22 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEE6__sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %6) #13
  store i64 0, ptr %22, align 8
  br label %23

23:                                               ; preds = %35, %21
  %24 = getelementptr inbounds %"class.std::__1::deque", ptr %6, i32 0, i32 0
  %25 = invoke noundef i64 @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE4sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %24)
          to label %26 unwind label %45

26:                                               ; preds = %23
  %27 = icmp ugt i64 %25, 2
  br i1 %27, label %28, label %36

28:                                               ; preds = %26
  %29 = load ptr, ptr %3, align 8
  %30 = getelementptr inbounds %"class.std::__1::deque", ptr %6, i32 0, i32 0
  %31 = invoke noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE5frontB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %30)
          to label %32 unwind label %45

32:                                               ; preds = %28
  %33 = load ptr, ptr %31, align 8
  call void @_ZNSt3__116allocator_traitsINS_9allocatorIfEEE10deallocateB8ne190107ERS2_Pfm(ptr noundef nonnull align 1 dereferenceable(1) %29, ptr noundef %33, i64 noundef 1024) #13
  %34 = getelementptr inbounds %"class.std::__1::deque", ptr %6, i32 0, i32 0
  invoke void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9pop_frontB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %34)
          to label %35 unwind label %45

35:                                               ; preds = %32
  br label %23, !llvm.loop !10

36:                                               ; preds = %26
  %37 = getelementptr inbounds %"class.std::__1::deque", ptr %6, i32 0, i32 0
  %38 = invoke noundef i64 @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE4sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %37)
          to label %39 unwind label %45

39:                                               ; preds = %36
  switch i64 %38, label %44 [
    i64 1, label %40
    i64 2, label %42
  ]

40:                                               ; preds = %39
  %41 = getelementptr inbounds %"class.std::__1::deque", ptr %6, i32 0, i32 1
  store i64 512, ptr %41, align 8
  br label %44

42:                                               ; preds = %39
  %43 = getelementptr inbounds %"class.std::__1::deque", ptr %6, i32 0, i32 1
  store i64 1024, ptr %43, align 8
  br label %44

44:                                               ; preds = %42, %40, %39
  call void @_ZNKSt3__15dequeIfNS_9allocatorIfEEE14__annotate_newB8ne190107Em(ptr noundef nonnull align 8 dereferenceable(48) %6, i64 noundef 0) #13
  ret void

45:                                               ; preds = %36, %32, %28, %23, %18, %16, %13, %10
  %46 = landingpad { ptr, i32 }
          catch ptr null
  %47 = extractvalue { ptr, i32 } %46, 0
  call void @__clang_call_terminate(ptr %47) #14
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNKSt3__15dequeIfNS_9allocatorIfEEE17__annotate_deleteB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE5beginB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %3, i32 0, i32 1
  %5 = load ptr, ptr %4, align 8
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE3endB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %3, i32 0, i32 2
  %5 = load ptr, ptr %4, align 8
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::deque", ptr %3, i32 0, i32 2
  %5 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__117__compressed_pairImNS_9allocatorIfEEE6secondB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #13
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__116allocator_traitsINS_9allocatorIfEEE10deallocateB8ne190107ERS2_Pfm(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1, i64 noundef %2) #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i64 %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load i64, ptr %6, align 8
  call void @_ZNSt3__19allocatorIfE10deallocateB8ne190107EPfm(ptr noundef nonnull align 1 dereferenceable(1) %7, ptr noundef %8, i64 noundef %9) #13
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEED1Ev(ptr noundef nonnull returned align 8 dereferenceable(32) %0) unnamed_addr #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEED2Ev(ptr noundef nonnull align 8 dereferenceable(32) %3) #13
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEED2Ev(ptr noundef nonnull returned align 8 dereferenceable(32) %0) unnamed_addr #1 personality ptr @__gxx_personality_v0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  store ptr %4, ptr %2, align 8
  call void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE5clearB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %4) #13
  %5 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %4, i32 0, i32 0
  %6 = load ptr, ptr %5, align 8
  %7 = icmp ne ptr %6, null
  br i1 %7, label %8, label %14

8:                                                ; preds = %1
  %9 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %4) #13
  %10 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %4, i32 0, i32 0
  %11 = load ptr, ptr %10, align 8
  %12 = invoke noundef i64 @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE8capacityB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %4)
          to label %13 unwind label %16

13:                                               ; preds = %8
  call void @_ZNSt3__116allocator_traitsINS_9allocatorIPfEEE10deallocateB8ne190107ERS3_PS2_m(ptr noundef nonnull align 1 dereferenceable(1) %9, ptr noundef %11, i64 noundef %12) #13
  br label %14

14:                                               ; preds = %13, %1
  %15 = load ptr, ptr %2, align 8
  ret ptr %15

16:                                               ; preds = %8
  %17 = landingpad { ptr, i32 }
          catch ptr null
  %18 = extractvalue { ptr, i32 } %17, 0
  call void @__clang_call_terminate(ptr %18) #14
  unreachable
}

declare i32 @__gxx_personality_v0(...)

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE5clearB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %3, i32 0, i32 1
  %5 = load ptr, ptr %4, align 8
  call void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE17__destruct_at_endB8ne190107EPS1_(ptr noundef nonnull align 8 dereferenceable(32) %3, ptr noundef %5) #13
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %3, i32 0, i32 3
  %5 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__117__compressed_pairIPPfNS_9allocatorIS1_EEE6secondB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #13
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef i64 @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE8capacityB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %3) #13
  %5 = load ptr, ptr %4, align 8
  %6 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %3, i32 0, i32 0
  %7 = load ptr, ptr %6, align 8
  %8 = ptrtoint ptr %5 to i64
  %9 = ptrtoint ptr %7 to i64
  %10 = sub i64 %8, %9
  %11 = sdiv exact i64 %10, 8
  ret i64 %11
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__116allocator_traitsINS_9allocatorIPfEEE10deallocateB8ne190107ERS3_PS2_m(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1, i64 noundef %2) #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i64 %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load i64, ptr %6, align 8
  call void @_ZNSt3__19allocatorIPfE10deallocateB8ne190107EPS1_m(ptr noundef nonnull align 1 dereferenceable(1) %7, ptr noundef %8, i64 noundef %9) #13
  ret void
}

; Function Attrs: noinline noreturn nounwind ssp uwtable(sync)
define linkonce_odr hidden void @__clang_call_terminate(ptr noundef %0) #2 {
  %2 = call ptr @__cxa_begin_catch(ptr %0) #13
  call void @_ZSt9terminatev() #14
  unreachable
}

declare ptr @__cxa_begin_catch(ptr)

declare void @_ZSt9terminatev()

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__19allocatorIPfE10deallocateB8ne190107EPS1_m(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1, i64 noundef %2) #1 personality ptr @__gxx_personality_v0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i64 %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load i64, ptr %6, align 8
  %10 = mul i64 %9, 8
  invoke void @_ZNSt3__119__libcpp_deallocateB8ne190107EPvmm(ptr noundef %8, i64 noundef %10, i64 noundef 8)
          to label %11 unwind label %12

11:                                               ; preds = %3
  ret void

12:                                               ; preds = %3
  %13 = landingpad { ptr, i32 }
          catch ptr null
  %14 = extractvalue { ptr, i32 } %13, 0
  call void @__clang_call_terminate(ptr %14) #14
  unreachable
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__119__libcpp_deallocateB8ne190107EPvmm(ptr noundef %0, i64 noundef %1, i64 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  store i64 %2, ptr %6, align 8
  %8 = load i64, ptr %6, align 8
  %9 = call noundef zeroext i1 @_ZNSt3__124__is_overaligned_for_newB8ne190107Em(i64 noundef %8) #13
  br i1 %9, label %10, label %15

10:                                               ; preds = %3
  %11 = load i64, ptr %6, align 8
  store i64 %11, ptr %7, align 8
  %12 = load ptr, ptr %4, align 8
  %13 = load i64, ptr %5, align 8
  %14 = load i64, ptr %7, align 8
  call void @_ZNSt3__127__do_deallocate_handle_sizeB8ne190107IJSt11align_val_tEEEvPvmDpT_(ptr noundef %12, i64 noundef %13, i64 noundef %14)
  br label %18

15:                                               ; preds = %3
  %16 = load ptr, ptr %4, align 8
  %17 = load i64, ptr %5, align 8
  call void @_ZNSt3__127__do_deallocate_handle_sizeB8ne190107IJEEEvPvmDpT_(ptr noundef %16, i64 noundef %17)
  br label %18

18:                                               ; preds = %15, %10
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef zeroext i1 @_ZNSt3__124__is_overaligned_for_newB8ne190107Em(i64 noundef %0) #1 {
  %2 = alloca i64, align 8
  store i64 %0, ptr %2, align 8
  %3 = load i64, ptr %2, align 8
  %4 = icmp ugt i64 %3, 16
  ret i1 %4
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__127__do_deallocate_handle_sizeB8ne190107IJSt11align_val_tEEEvPvmDpT_(ptr noundef %0, i64 noundef %1, i64 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  store i64 %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load i64, ptr %5, align 8
  %9 = load i64, ptr %6, align 8
  call void @_ZNSt3__124__libcpp_operator_deleteB8ne190107IJPvmSt11align_val_tEEEvDpT_(ptr noundef %7, i64 noundef %8, i64 noundef %9)
  ret void
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__127__do_deallocate_handle_sizeB8ne190107IJEEEvPvmDpT_(ptr noundef %0, i64 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load i64, ptr %4, align 8
  call void @_ZNSt3__124__libcpp_operator_deleteB8ne190107IJPvmEEEvDpT_(ptr noundef %5, i64 noundef %6)
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__124__libcpp_operator_deleteB8ne190107IJPvmEEEvDpT_(ptr noundef %0, i64 noundef %1) #1 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load i64, ptr %4, align 8
  call void @_ZdlPvm(ptr noundef %5, i64 noundef %6) #15
  ret void
}

; Function Attrs: nobuiltin nounwind
declare void @_ZdlPvm(ptr noundef, i64 noundef) #3

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__124__libcpp_operator_deleteB8ne190107IJPvmSt11align_val_tEEEvDpT_(ptr noundef %0, i64 noundef %1, i64 noundef %2) #1 {
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  store i64 %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load i64, ptr %5, align 8
  %9 = load i64, ptr %6, align 8
  call void @_ZdlPvmSt11align_val_t(ptr noundef %7, i64 noundef %8, i64 noundef %9) #15
  ret void
}

; Function Attrs: nobuiltin nounwind
declare void @_ZdlPvmSt11align_val_t(ptr noundef, i64 noundef, i64 noundef) #3

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %3, i32 0, i32 3
  %5 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__117__compressed_pairIPPfNS_9allocatorIS1_EEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #13
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__117__compressed_pairIPPfNS_9allocatorIS1_EEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__122__compressed_pair_elemIPPfLi0ELb0EE5__getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__122__compressed_pair_elemIPPfLi0ELb0EE5__getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %3, i32 0, i32 0
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__117__compressed_pairIPPfNS_9allocatorIS1_EEE6secondB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__122__compressed_pair_elemINS_9allocatorIPfEELi1ELb1EE5__getB8ne190107Ev(ptr noundef nonnull align 1 dereferenceable(1) %3) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__122__compressed_pair_elemINS_9allocatorIPfEELi1ELb1EE5__getB8ne190107Ev(ptr noundef nonnull align 1 dereferenceable(1) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE17__destruct_at_endB8ne190107EPS1_(ptr noundef nonnull align 8 dereferenceable(32) %0, ptr noundef %1) #1 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca %"struct.std::__1::integral_constant.7", align 1
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %6 = load ptr, ptr %3, align 8
  %7 = load ptr, ptr %4, align 8
  call void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE17__destruct_at_endB8ne190107EPS1_NS_17integral_constantIbLb0EEE(ptr noundef nonnull align 8 dereferenceable(32) %6, ptr noundef %7) #13
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE17__destruct_at_endB8ne190107EPS1_NS_17integral_constantIbLb0EEE(ptr noundef nonnull align 8 dereferenceable(32) %0, ptr noundef %1) #1 personality ptr @__gxx_personality_v0 {
  %3 = alloca %"struct.std::__1::integral_constant.7", align 1
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %6 = load ptr, ptr %4, align 8
  br label %7

7:                                                ; preds = %18, %2
  %8 = load ptr, ptr %5, align 8
  %9 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %6, i32 0, i32 2
  %10 = load ptr, ptr %9, align 8
  %11 = icmp ne ptr %8, %10
  br i1 %11, label %12, label %19

12:                                               ; preds = %7
  %13 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %6) #13
  %14 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %6, i32 0, i32 2
  %15 = load ptr, ptr %14, align 8
  %16 = getelementptr inbounds ptr, ptr %15, i32 -1
  store ptr %16, ptr %14, align 8
  %17 = call noundef ptr @_ZNSt3__112__to_addressB8ne190107IPfEEPT_S3_(ptr noundef %16) #13
  invoke void @_ZNSt3__116allocator_traitsINS_9allocatorIPfEEE7destroyB8ne190107IS2_TnNS_9enable_ifIXsr13__has_destroyIS3_PT_EE5valueEiE4typeELi0EEEvRS3_S8_(ptr noundef nonnull align 1 dereferenceable(1) %13, ptr noundef %17)
          to label %18 unwind label %20

18:                                               ; preds = %12
  br label %7, !llvm.loop !11

19:                                               ; preds = %7
  ret void

20:                                               ; preds = %12
  %21 = landingpad { ptr, i32 }
          catch ptr null
  %22 = extractvalue { ptr, i32 } %21, 0
  call void @__clang_call_terminate(ptr %22) #14
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__112__to_addressB8ne190107IPfEEPT_S3_(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr void @_ZNSt3__116allocator_traitsINS_9allocatorIPfEEE7destroyB8ne190107IS2_TnNS_9enable_ifIXsr13__has_destroyIS3_PT_EE5valueEiE4typeELi0EEEvRS3_S8_(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  call void @_ZNSt3__19allocatorIPfE7destroyB8ne190107EPS1_(ptr noundef nonnull align 1 dereferenceable(1) %5, ptr noundef %6)
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__19allocatorIPfE7destroyB8ne190107EPS1_(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1) #1 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__19allocatorIfE10deallocateB8ne190107EPfm(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1, i64 noundef %2) #1 personality ptr @__gxx_personality_v0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i64 %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load i64, ptr %6, align 8
  %10 = mul i64 %9, 4
  invoke void @_ZNSt3__119__libcpp_deallocateB8ne190107EPvmm(ptr noundef %8, i64 noundef %10, i64 noundef 4)
          to label %11 unwind label %12

11:                                               ; preds = %3
  ret void

12:                                               ; preds = %3
  %13 = landingpad { ptr, i32 }
          catch ptr null
  %14 = extractvalue { ptr, i32 } %13, 0
  call void @__clang_call_terminate(ptr %14) #14
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__117__compressed_pairImNS_9allocatorIfEEE6secondB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__122__compressed_pair_elemINS_9allocatorIfEELi1ELb1EE5__getB8ne190107Ev(ptr noundef nonnull align 1 dereferenceable(1) %3) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__122__compressed_pair_elemINS_9allocatorIfEELi1ELb1EE5__getB8ne190107Ev(ptr noundef nonnull align 1 dereferenceable(1) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden [2 x i64] @_ZNSt3__15dequeIfNS_9allocatorIfEEE5beginB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %0) #1 personality ptr @__gxx_personality_v0 {
  %2 = alloca %"class.std::__1::__deque_iterator", align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %"class.std::__1::deque", ptr %5, i32 0, i32 0
  %7 = call noundef ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE5beginB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %6) #13
  %8 = getelementptr inbounds %"class.std::__1::deque", ptr %5, i32 0, i32 1
  %9 = load i64, ptr %8, align 8
  %10 = udiv i64 %9, 1024
  %11 = getelementptr inbounds ptr, ptr %7, i64 %10
  store ptr %11, ptr %4, align 8
  %12 = load ptr, ptr %4, align 8
  %13 = getelementptr inbounds %"class.std::__1::deque", ptr %5, i32 0, i32 0
  %14 = invoke noundef zeroext i1 @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE5emptyB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %13)
          to label %15 unwind label %28

15:                                               ; preds = %1
  br i1 %14, label %16, label %17

16:                                               ; preds = %15
  br label %24

17:                                               ; preds = %15
  %18 = load ptr, ptr %4, align 8
  %19 = load ptr, ptr %18, align 8
  %20 = getelementptr inbounds %"class.std::__1::deque", ptr %5, i32 0, i32 1
  %21 = load i64, ptr %20, align 8
  %22 = urem i64 %21, 1024
  %23 = getelementptr inbounds float, ptr %19, i64 %22
  br label %24

24:                                               ; preds = %17, %16
  %25 = phi ptr [ null, %16 ], [ %23, %17 ]
  %26 = call noundef ptr @_ZNSt3__116__deque_iteratorIfPfRfPS1_lLl1024EEC1B8ne190107ES3_S1_(ptr noundef nonnull align 8 dereferenceable(16) %2, ptr noundef %12, ptr noundef %25) #13
  %27 = load [2 x i64], ptr %2, align 8
  ret [2 x i64] %27

28:                                               ; preds = %1
  %29 = landingpad { ptr, i32 }
          catch ptr null
  %30 = extractvalue { ptr, i32 } %29, 0
  call void @__clang_call_terminate(ptr %30) #14
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden [2 x i64] @_ZNSt3__15dequeIfNS_9allocatorIfEEE3endB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %0) #1 {
  %2 = alloca %"class.std::__1::__deque_iterator", align 8
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %6 = load ptr, ptr %3, align 8
  %7 = call noundef i64 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE4sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %6) #13
  %8 = getelementptr inbounds %"class.std::__1::deque", ptr %6, i32 0, i32 1
  %9 = load i64, ptr %8, align 8
  %10 = add i64 %7, %9
  store i64 %10, ptr %4, align 8
  %11 = getelementptr inbounds %"class.std::__1::deque", ptr %6, i32 0, i32 0
  %12 = call noundef ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE5beginB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %11) #13
  %13 = load i64, ptr %4, align 8
  %14 = udiv i64 %13, 1024
  %15 = getelementptr inbounds ptr, ptr %12, i64 %14
  store ptr %15, ptr %5, align 8
  %16 = load ptr, ptr %5, align 8
  %17 = getelementptr inbounds %"class.std::__1::deque", ptr %6, i32 0, i32 0
  %18 = call noundef zeroext i1 @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE5emptyB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %17)
  br i1 %18, label %19, label %20

19:                                               ; preds = %1
  br label %26

20:                                               ; preds = %1
  %21 = load ptr, ptr %5, align 8
  %22 = load ptr, ptr %21, align 8
  %23 = load i64, ptr %4, align 8
  %24 = urem i64 %23, 1024
  %25 = getelementptr inbounds float, ptr %22, i64 %24
  br label %26

26:                                               ; preds = %20, %19
  %27 = phi ptr [ null, %19 ], [ %25, %20 ]
  %28 = call noundef ptr @_ZNSt3__116__deque_iteratorIfPfRfPS1_lLl1024EEC1B8ne190107ES3_S1_(ptr noundef nonnull align 8 dereferenceable(16) %2, ptr noundef %16, ptr noundef %27) #13
  %29 = load [2 x i64], ptr %2, align 8
  ret [2 x i64] %29
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef zeroext i1 @_ZNSt3__1neB8ne190107ERKNS_16__deque_iteratorIfPfRfPS1_lLl1024EEES6_(ptr noundef nonnull align 8 dereferenceable(16) %0, ptr noundef nonnull align 8 dereferenceable(16) %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = call noundef zeroext i1 @_ZNSt3__1eqB8ne190107ERKNS_16__deque_iteratorIfPfRfPS1_lLl1024EEES6_(ptr noundef nonnull align 8 dereferenceable(16) %5, ptr noundef nonnull align 8 dereferenceable(16) %6)
  %8 = xor i1 %7, true
  ret i1 %8
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 4 dereferenceable(4) ptr @_ZNKSt3__116__deque_iteratorIfPfRfPS1_lLl1024EEdeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(16) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %3, i32 0, i32 1
  %5 = load ptr, ptr %4, align 8
  ret ptr %5
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr void @_ZNSt3__116allocator_traitsINS_9allocatorIfEEE7destroyB8ne190107IfTnNS_9enable_ifIXsr13__has_destroyIS2_PT_EE5valueEiE4typeELi0EEEvRS2_S7_(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  call void @_ZNSt3__19allocatorIfE7destroyB8ne190107EPf(ptr noundef nonnull align 1 dereferenceable(1) %5, ptr noundef %6)
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(16) ptr @_ZNSt3__116__deque_iteratorIfPfRfPS1_lLl1024EEppB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(16) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %3, i32 0, i32 1
  %5 = load ptr, ptr %4, align 8
  %6 = getelementptr inbounds float, ptr %5, i32 1
  store ptr %6, ptr %4, align 8
  %7 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %3, i32 0, i32 0
  %8 = load ptr, ptr %7, align 8
  %9 = load ptr, ptr %8, align 8
  %10 = ptrtoint ptr %6 to i64
  %11 = ptrtoint ptr %9 to i64
  %12 = sub i64 %10, %11
  %13 = sdiv exact i64 %12, 4
  %14 = icmp eq i64 %13, 1024
  br i1 %14, label %15, label %23

15:                                               ; preds = %1
  %16 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %3, i32 0, i32 0
  %17 = load ptr, ptr %16, align 8
  %18 = getelementptr inbounds ptr, ptr %17, i32 1
  store ptr %18, ptr %16, align 8
  %19 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %3, i32 0, i32 0
  %20 = load ptr, ptr %19, align 8
  %21 = load ptr, ptr %20, align 8
  %22 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %3, i32 0, i32 1
  store ptr %21, ptr %22, align 8
  br label %23

23:                                               ; preds = %15, %1
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEE6__sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::deque", ptr %3, i32 0, i32 2
  %5 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__117__compressed_pairImNS_9allocatorIfEEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #13
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef i64 @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE4sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %3, i32 0, i32 2
  %5 = load ptr, ptr %4, align 8
  %6 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %3, i32 0, i32 1
  %7 = load ptr, ptr %6, align 8
  %8 = ptrtoint ptr %5 to i64
  %9 = ptrtoint ptr %7 to i64
  %10 = sub i64 %8, %9
  %11 = sdiv exact i64 %10, 8
  ret i64 %11
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE5frontB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %3, i32 0, i32 1
  %5 = load ptr, ptr %4, align 8
  ret ptr %5
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9pop_frontB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %3, i32 0, i32 1
  %5 = load ptr, ptr %4, align 8
  %6 = getelementptr inbounds ptr, ptr %5, i64 1
  call void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE19__destruct_at_beginB8ne190107EPS1_(ptr noundef nonnull align 8 dereferenceable(32) %3, ptr noundef %6)
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNKSt3__15dequeIfNS_9allocatorIfEEE14__annotate_newB8ne190107Em(ptr noundef nonnull align 8 dereferenceable(48) %0, i64 noundef %1) #1 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  ret void
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE19__destruct_at_beginB8ne190107EPS1_(ptr noundef nonnull align 8 dereferenceable(32) %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca %"struct.std::__1::integral_constant.7", align 1
  %6 = alloca %"struct.std::__1::integral_constant.7", align 1
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %7 = load ptr, ptr %3, align 8
  %8 = load ptr, ptr %4, align 8
  call void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE19__destruct_at_beginEPS1_NS_17integral_constantIbLb1EEE(ptr noundef nonnull align 8 dereferenceable(32) %7, ptr noundef %8)
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE19__destruct_at_beginEPS1_NS_17integral_constantIbLb1EEE(ptr noundef nonnull align 8 dereferenceable(32) %0, ptr noundef %1) #1 {
  %3 = alloca %"struct.std::__1::integral_constant.7", align 1
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = load ptr, ptr %5, align 8
  %8 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %6, i32 0, i32 1
  store ptr %7, ptr %8, align 8
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__117__compressed_pairImNS_9allocatorIfEEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__122__compressed_pair_elemImLi0ELb0EE5__getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__122__compressed_pair_elemImLi0ELb0EE5__getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem.2", ptr %3, i32 0, i32 0
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__19allocatorIfE7destroyB8ne190107EPf(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1) #1 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef zeroext i1 @_ZNSt3__1eqB8ne190107ERKNS_16__deque_iteratorIfPfRfPS1_lLl1024EEES6_(ptr noundef nonnull align 8 dereferenceable(16) %0, ptr noundef nonnull align 8 dereferenceable(16) %1) #1 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %5, i32 0, i32 1
  %7 = load ptr, ptr %6, align 8
  %8 = load ptr, ptr %4, align 8
  %9 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %8, i32 0, i32 1
  %10 = load ptr, ptr %9, align 8
  %11 = icmp eq ptr %7, %10
  ret i1 %11
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef i64 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE4sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__15dequeIfNS_9allocatorIfEEE6__sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %3) #13
  %5 = load i64, ptr %4, align 8
  ret i64 %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef zeroext i1 @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE5emptyB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %3, i32 0, i32 2
  %5 = load ptr, ptr %4, align 8
  %6 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %3, i32 0, i32 1
  %7 = load ptr, ptr %6, align 8
  %8 = icmp eq ptr %5, %7
  ret i1 %8
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__116__deque_iteratorIfPfRfPS1_lLl1024EEC1B8ne190107ES3_S1_(ptr noundef nonnull returned align 8 dereferenceable(16) %0, ptr noundef %1, ptr noundef %2) unnamed_addr #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = call noundef ptr @_ZNSt3__116__deque_iteratorIfPfRfPS1_lLl1024EEC2B8ne190107ES3_S1_(ptr noundef nonnull align 8 dereferenceable(16) %7, ptr noundef %8, ptr noundef %9) #13
  ret ptr %7
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__116__deque_iteratorIfPfRfPS1_lLl1024EEC2B8ne190107ES3_S1_(ptr noundef nonnull returned align 8 dereferenceable(16) %0, ptr noundef %1, ptr noundef %2) unnamed_addr #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %7, i32 0, i32 0
  %9 = load ptr, ptr %5, align 8
  store ptr %9, ptr %8, align 8
  %10 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %7, i32 0, i32 1
  %11 = load ptr, ptr %6, align 8
  store ptr %11, ptr %10, align 8
  ret ptr %7
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__15dequeIfNS_9allocatorIfEEE6__sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::deque", ptr %3, i32 0, i32 2
  %5 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__117__compressed_pairImNS_9allocatorIfEEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #13
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__117__compressed_pairImNS_9allocatorIfEEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__122__compressed_pair_elemImLi0ELb0EE5__getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__122__compressed_pair_elemImLi0ELb0EE5__getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem.2", ptr %3, i32 0, i32 0
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN10ac_channelIfEC2Ev(ptr noundef nonnull returned align 8 dereferenceable(60) %0) unnamed_addr #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %class.ac_channel, ptr %3, i32 0, i32 0
  %5 = call noundef ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEEC1B8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %4) #13
  %6 = getelementptr inbounds %class.ac_channel, ptr %3, i32 0, i32 1
  store i32 0, ptr %6, align 8
  %7 = getelementptr inbounds %class.ac_channel, ptr %3, i32 0, i32 3
  store i32 0, ptr %7, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEEC1B8ne190107Ev(ptr noundef nonnull returned align 8 dereferenceable(48) %0) unnamed_addr #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEEC2B8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %3) #13
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEEC2B8ne190107Ev(ptr noundef nonnull returned align 8 dereferenceable(48) %0) unnamed_addr #1 personality ptr @__gxx_personality_v0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca %"struct.std::__1::integral_constant.7", align 1
  store ptr %0, ptr %2, align 8
  %5 = load ptr, ptr %2, align 8
  %6 = getelementptr inbounds %"class.std::__1::deque", ptr %5, i32 0, i32 0
  %7 = call noundef ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEEC1B8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %6) #13
  %8 = getelementptr inbounds %"class.std::__1::deque", ptr %5, i32 0, i32 1
  store i64 0, ptr %8, align 8
  %9 = getelementptr inbounds %"class.std::__1::deque", ptr %5, i32 0, i32 2
  store i32 0, ptr %3, align 4
  %10 = invoke noundef ptr @_ZNSt3__117__compressed_pairImNS_9allocatorIfEEEC1B8ne190107IiNS_18__default_init_tagEEEOT_OT0_(ptr noundef nonnull align 8 dereferenceable(8) %9, ptr noundef nonnull align 4 dereferenceable(4) %3, ptr noundef nonnull align 1 dereferenceable(1) %4)
          to label %11 unwind label %12

11:                                               ; preds = %1
  call void @_ZNKSt3__15dequeIfNS_9allocatorIfEEE14__annotate_newB8ne190107Em(ptr noundef nonnull align 8 dereferenceable(48) %5, i64 noundef 0) #13
  ret ptr %5

12:                                               ; preds = %1
  %13 = landingpad { ptr, i32 }
          catch ptr null
  %14 = extractvalue { ptr, i32 } %13, 0
  call void @__clang_call_terminate(ptr %14) #14
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEEC1B8ne190107Ev(ptr noundef nonnull returned align 8 dereferenceable(32) %0) unnamed_addr #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEEC2B8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %3) #13
  ret ptr %3
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__117__compressed_pairImNS_9allocatorIfEEEC1B8ne190107IiNS_18__default_init_tagEEEOT_OT0_(ptr noundef nonnull returned align 8 dereferenceable(8) %0, ptr noundef nonnull align 4 dereferenceable(4) %1, ptr noundef nonnull align 1 dereferenceable(1) %2) unnamed_addr #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = call noundef ptr @_ZNSt3__117__compressed_pairImNS_9allocatorIfEEEC2B8ne190107IiNS_18__default_init_tagEEEOT_OT0_(ptr noundef nonnull align 8 dereferenceable(8) %7, ptr noundef nonnull align 4 dereferenceable(4) %8, ptr noundef nonnull align 1 dereferenceable(1) %9)
  ret ptr %7
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__117__compressed_pairImNS_9allocatorIfEEEC2B8ne190107IiNS_18__default_init_tagEEEOT_OT0_(ptr noundef nonnull returned align 8 dereferenceable(8) %0, ptr noundef nonnull align 4 dereferenceable(4) %1, ptr noundef nonnull align 1 dereferenceable(1) %2) unnamed_addr #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca %"struct.std::__1::integral_constant.7", align 1
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %8 = load ptr, ptr %4, align 8
  %9 = load ptr, ptr %5, align 8
  %10 = call noundef ptr @_ZNSt3__122__compressed_pair_elemImLi0ELb0EEC2B8ne190107IiTnNS_9enable_ifIXntsr7is_sameIS1_u7__decayIT_EEE5valueEiE4typeELi0EEEOS4_(ptr noundef nonnull align 8 dereferenceable(8) %8, ptr noundef nonnull align 4 dereferenceable(4) %9)
  %11 = load ptr, ptr %6, align 8
  %12 = call noundef ptr @_ZNSt3__122__compressed_pair_elemINS_9allocatorIfEELi1ELb1EEC2B8ne190107ENS_18__default_init_tagE(ptr noundef nonnull align 1 dereferenceable(1) %8)
  ret ptr %8
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__122__compressed_pair_elemImLi0ELb0EEC2B8ne190107IiTnNS_9enable_ifIXntsr7is_sameIS1_u7__decayIT_EEE5valueEiE4typeELi0EEEOS4_(ptr noundef nonnull returned align 8 dereferenceable(8) %0, ptr noundef nonnull align 4 dereferenceable(4) %1) unnamed_addr #1 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem.2", ptr %5, i32 0, i32 0
  %7 = load ptr, ptr %4, align 8
  %8 = load i32, ptr %7, align 4
  %9 = sext i32 %8 to i64
  store i64 %9, ptr %6, align 8
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__122__compressed_pair_elemINS_9allocatorIfEELi1ELb1EEC2B8ne190107ENS_18__default_init_tagE(ptr noundef nonnull returned align 1 dereferenceable(1) %0) unnamed_addr #1 {
  %2 = alloca %"struct.std::__1::integral_constant.7", align 1
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  %5 = call noundef ptr @_ZNSt3__19allocatorIfEC2B8ne190107Ev(ptr noundef nonnull align 1 dereferenceable(1) %4) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__19allocatorIfEC2B8ne190107Ev(ptr noundef nonnull returned align 1 dereferenceable(1) %0) unnamed_addr #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZNSt3__116__non_trivial_ifILb1ENS_9allocatorIfEEEC2B8ne190107Ev(ptr noundef nonnull align 1 dereferenceable(1) %3) #13
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__116__non_trivial_ifILb1ENS_9allocatorIfEEEC2B8ne190107Ev(ptr noundef nonnull returned align 1 dereferenceable(1) %0) unnamed_addr #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEEC2B8ne190107Ev(ptr noundef nonnull returned align 8 dereferenceable(32) %0) unnamed_addr #1 personality ptr @__gxx_personality_v0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca %"struct.std::__1::integral_constant.7", align 1
  store ptr %0, ptr %2, align 8
  %5 = load ptr, ptr %2, align 8
  %6 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %5, i32 0, i32 0
  store ptr null, ptr %6, align 8
  %7 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %5, i32 0, i32 1
  store ptr null, ptr %7, align 8
  %8 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %5, i32 0, i32 2
  store ptr null, ptr %8, align 8
  %9 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %5, i32 0, i32 3
  store ptr null, ptr %3, align 8
  %10 = invoke noundef ptr @_ZNSt3__117__compressed_pairIPPfNS_9allocatorIS1_EEEC1B8ne190107IDnNS_18__default_init_tagEEEOT_OT0_(ptr noundef nonnull align 8 dereferenceable(8) %9, ptr noundef nonnull align 8 dereferenceable(8) %3, ptr noundef nonnull align 1 dereferenceable(1) %4)
          to label %11 unwind label %12

11:                                               ; preds = %1
  ret ptr %5

12:                                               ; preds = %1
  %13 = landingpad { ptr, i32 }
          catch ptr null
  %14 = extractvalue { ptr, i32 } %13, 0
  call void @__clang_call_terminate(ptr %14) #14
  unreachable
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__117__compressed_pairIPPfNS_9allocatorIS1_EEEC1B8ne190107IDnNS_18__default_init_tagEEEOT_OT0_(ptr noundef nonnull returned align 8 dereferenceable(8) %0, ptr noundef nonnull align 8 dereferenceable(8) %1, ptr noundef nonnull align 1 dereferenceable(1) %2) unnamed_addr #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = call noundef ptr @_ZNSt3__117__compressed_pairIPPfNS_9allocatorIS1_EEEC2B8ne190107IDnNS_18__default_init_tagEEEOT_OT0_(ptr noundef nonnull align 8 dereferenceable(8) %7, ptr noundef nonnull align 8 dereferenceable(8) %8, ptr noundef nonnull align 1 dereferenceable(1) %9)
  ret ptr %7
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__117__compressed_pairIPPfNS_9allocatorIS1_EEEC2B8ne190107IDnNS_18__default_init_tagEEEOT_OT0_(ptr noundef nonnull returned align 8 dereferenceable(8) %0, ptr noundef nonnull align 8 dereferenceable(8) %1, ptr noundef nonnull align 1 dereferenceable(1) %2) unnamed_addr #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca %"struct.std::__1::integral_constant.7", align 1
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %8 = load ptr, ptr %4, align 8
  %9 = load ptr, ptr %5, align 8
  %10 = call noundef ptr @_ZNSt3__122__compressed_pair_elemIPPfLi0ELb0EEC2B8ne190107IDnTnNS_9enable_ifIXntsr7is_sameIS3_u7__decayIT_EEE5valueEiE4typeELi0EEEOS6_(ptr noundef nonnull align 8 dereferenceable(8) %8, ptr noundef nonnull align 8 dereferenceable(8) %9)
  %11 = load ptr, ptr %6, align 8
  %12 = call noundef ptr @_ZNSt3__122__compressed_pair_elemINS_9allocatorIPfEELi1ELb1EEC2B8ne190107ENS_18__default_init_tagE(ptr noundef nonnull align 1 dereferenceable(1) %8)
  ret ptr %8
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__122__compressed_pair_elemIPPfLi0ELb0EEC2B8ne190107IDnTnNS_9enable_ifIXntsr7is_sameIS3_u7__decayIT_EEE5valueEiE4typeELi0EEEOS6_(ptr noundef nonnull returned align 8 dereferenceable(8) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) unnamed_addr #1 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %5, i32 0, i32 0
  %7 = load ptr, ptr %4, align 8
  store ptr null, ptr %6, align 8
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__122__compressed_pair_elemINS_9allocatorIPfEELi1ELb1EEC2B8ne190107ENS_18__default_init_tagE(ptr noundef nonnull returned align 1 dereferenceable(1) %0) unnamed_addr #1 {
  %2 = alloca %"struct.std::__1::integral_constant.7", align 1
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  %5 = call noundef ptr @_ZNSt3__19allocatorIPfEC2B8ne190107Ev(ptr noundef nonnull align 1 dereferenceable(1) %4) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__19allocatorIPfEC2B8ne190107Ev(ptr noundef nonnull returned align 1 dereferenceable(1) %0) unnamed_addr #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZNSt3__116__non_trivial_ifILb1ENS_9allocatorIPfEEEC2B8ne190107Ev(ptr noundef nonnull align 1 dereferenceable(1) %3) #13
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__116__non_trivial_ifILb1ENS_9allocatorIPfEEEC2B8ne190107Ev(ptr noundef nonnull returned align 1 dereferenceable(1) %0) unnamed_addr #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: alwaysinline mustprogress ssp uwtable(sync)
define void @__df_ctor_f32(ptr noundef %0) #4 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN10ac_channelIfEC1Ev(ptr noundef nonnull align 8 dereferenceable(60) %3)
  ret void
}

; Function Attrs: alwaysinline mustprogress nounwind ssp uwtable(sync)
define void @__df_dtor_f32(ptr noundef %0) #5 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN10ac_channelIfED1Ev(ptr noundef nonnull align 8 dereferenceable(60) %3) #13
  ret void
}

; Function Attrs: alwaysinline mustprogress ssp uwtable(sync)
define float @__df_read_f32(ptr noundef %0) #4 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca float, align 4
  %6 = alloca ptr, align 8
  store ptr %0, ptr %6, align 8
  %7 = load ptr, ptr %6, align 8
  store ptr %7, ptr %4, align 8
  %8 = load ptr, ptr %4, align 8
  store ptr %8, ptr %2, align 8
  store ptr %5, ptr %3, align 8
  %9 = load ptr, ptr %2, align 8
  %10 = call noundef float @_ZN10ac_channelIfE20_read_bambu_internalIfEEKT_v(ptr noundef nonnull align 8 dereferenceable(60) %9)
  %11 = load ptr, ptr %3, align 8
  store float %10, ptr %11, align 4
  %12 = load float, ptr %5, align 4
  ret float %12
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr noundef float @_ZN10ac_channelIfE20_read_bambu_internalIfEEKT_v(ptr noundef nonnull align 8 dereferenceable(60) %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca float, align 4
  store ptr %0, ptr %3, align 8
  %6 = load ptr, ptr %3, align 8
  %7 = getelementptr inbounds %class.ac_channel, ptr %6, i32 0, i32 0
  %8 = call noundef zeroext i1 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE5emptyB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %7) #13
  %9 = xor i1 %8, true
  store i32 1024, ptr %4, align 4
  call void @_ZN10ac_channelIfE9ac_assertEbPKciRKN20ac_channel_exception4codeE(i1 noundef zeroext %9, ptr noundef @.str, i32 noundef 794, ptr noundef nonnull align 4 dereferenceable(4) %4)
  %10 = getelementptr inbounds %class.ac_channel, ptr %6, i32 0, i32 0
  %11 = call noundef nonnull align 4 dereferenceable(4) ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEE5frontEv(ptr noundef nonnull align 8 dereferenceable(48) %10) #13
  store ptr %11, ptr %2, align 8
  %12 = load ptr, ptr %2, align 8
  %13 = load float, ptr %12, align 4
  store float %13, ptr %5, align 4
  %14 = getelementptr inbounds %class.ac_channel, ptr %6, i32 0, i32 0
  call void @_ZNSt3__15dequeIfNS_9allocatorIfEEE9pop_frontEv(ptr noundef nonnull align 8 dereferenceable(48) %14)
  %15 = load float, ptr %5, align 4
  ret float %15
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef zeroext i1 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE5emptyB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef i64 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE4sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %3) #13
  %5 = icmp eq i64 %4, 0
  ret i1 %5
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr void @_ZN10ac_channelIfE9ac_assertEbPKciRKN20ac_channel_exception4codeE(i1 noundef zeroext %0, ptr noundef %1, i32 noundef %2, ptr noundef nonnull align 4 dereferenceable(4) %3) #0 {
  %5 = alloca i8, align 1
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca %struct.ac_exception, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = zext i1 %0 to i8
  store i8 %12, ptr %5, align 1
  store ptr %1, ptr %6, align 8
  store i32 %2, ptr %7, align 4
  store ptr %3, ptr %8, align 8
  %13 = load i8, ptr %5, align 1
  %14 = trunc i8 %13 to i1
  br i1 %14, label %40, label %15

15:                                               ; preds = %4
  %16 = load ptr, ptr %6, align 8
  %17 = load i32, ptr %7, align 4
  store i32 %17, ptr %10, align 4
  %18 = load ptr, ptr %8, align 8
  %19 = load i32, ptr %18, align 4
  store i32 %19, ptr %11, align 4
  %20 = load ptr, ptr %8, align 8
  %21 = call noundef ptr @_ZN20ac_channel_exception3msgERKNS_4codeE(ptr noundef nonnull align 4 dereferenceable(4) %20)
  %22 = call noundef ptr @_ZN12ac_exceptionC1EPKcRKjRKiS1_(ptr noundef nonnull align 8 dereferenceable(24) %9, ptr noundef %16, ptr noundef nonnull align 4 dereferenceable(4) %10, ptr noundef nonnull align 4 dereferenceable(4) %11, ptr noundef %21)
  %23 = load ptr, ptr @__stderrp, align 8
  %24 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %23, ptr noundef @.str.1) #13
  %25 = getelementptr inbounds %struct.ac_exception, ptr %9, i32 0, i32 0
  %26 = load ptr, ptr %25, align 8
  %27 = icmp ne ptr %26, null
  br i1 %27, label %28, label %35

28:                                               ; preds = %15
  %29 = load ptr, ptr @__stderrp, align 8
  %30 = getelementptr inbounds %struct.ac_exception, ptr %9, i32 0, i32 0
  %31 = load ptr, ptr %30, align 8
  %32 = getelementptr inbounds %struct.ac_exception, ptr %9, i32 0, i32 1
  %33 = load i32, ptr %32, align 8
  %34 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %29, ptr noundef @.str.2, ptr noundef %31, i32 noundef %33) #13
  br label %35

35:                                               ; preds = %28, %15
  %36 = load ptr, ptr @__stderrp, align 8
  %37 = getelementptr inbounds %struct.ac_exception, ptr %9, i32 0, i32 3
  %38 = load ptr, ptr %37, align 8
  %39 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %36, ptr noundef @.str.3, ptr noundef %38) #13
  call void @__assert_rtn(ptr noundef @__func__._ZN10ac_channelIfE9ac_assertEbPKciRKN20ac_channel_exception4codeE, ptr noundef @.str.4, i32 noundef 444, ptr noundef @.str.5) #16
  unreachable

40:                                               ; preds = %4
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 4 dereferenceable(4) ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEE5frontEv(ptr noundef nonnull align 8 dereferenceable(48) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::deque", ptr %3, i32 0, i32 0
  %5 = call noundef ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE5beginB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %4) #13
  %6 = getelementptr inbounds %"class.std::__1::deque", ptr %3, i32 0, i32 1
  %7 = load i64, ptr %6, align 8
  %8 = udiv i64 %7, 1024
  %9 = getelementptr inbounds ptr, ptr %5, i64 %8
  %10 = load ptr, ptr %9, align 8
  %11 = getelementptr inbounds %"class.std::__1::deque", ptr %3, i32 0, i32 1
  %12 = load i64, ptr %11, align 8
  %13 = urem i64 %12, 1024
  %14 = getelementptr inbounds float, ptr %10, i64 %13
  ret ptr %14
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__15dequeIfNS_9allocatorIfEEE9pop_frontEv(ptr noundef nonnull align 8 dereferenceable(48) %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %6 = load ptr, ptr %2, align 8
  %7 = call noundef i64 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE4sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %6) #13
  store i64 %7, ptr %3, align 8
  %8 = getelementptr inbounds %"class.std::__1::deque", ptr %6, i32 0, i32 1
  %9 = load i64, ptr %8, align 8
  store i64 %9, ptr %4, align 8
  %10 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %6) #13
  store ptr %10, ptr %5, align 8
  %11 = load ptr, ptr %5, align 8
  %12 = getelementptr inbounds %"class.std::__1::deque", ptr %6, i32 0, i32 0
  %13 = call noundef ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE5beginB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %12) #13
  %14 = getelementptr inbounds %"class.std::__1::deque", ptr %6, i32 0, i32 1
  %15 = load i64, ptr %14, align 8
  %16 = udiv i64 %15, 1024
  %17 = getelementptr inbounds ptr, ptr %13, i64 %16
  %18 = load ptr, ptr %17, align 8
  %19 = getelementptr inbounds %"class.std::__1::deque", ptr %6, i32 0, i32 1
  %20 = load i64, ptr %19, align 8
  %21 = urem i64 %20, 1024
  %22 = getelementptr inbounds float, ptr %18, i64 %21
  %23 = call noundef ptr @_ZNSt3__112__to_addressB8ne190107IfEEPT_S2_(ptr noundef %22) #13
  call void @_ZNSt3__116allocator_traitsINS_9allocatorIfEEE7destroyB8ne190107IfTnNS_9enable_ifIXsr13__has_destroyIS2_PT_EE5valueEiE4typeELi0EEEvRS2_S7_(ptr noundef nonnull align 1 dereferenceable(1) %11, ptr noundef %23)
  %24 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEE6__sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %6) #13
  %25 = load i64, ptr %24, align 8
  %26 = add i64 %25, -1
  store i64 %26, ptr %24, align 8
  %27 = getelementptr inbounds %"class.std::__1::deque", ptr %6, i32 0, i32 1
  %28 = load i64, ptr %27, align 8
  %29 = add i64 %28, 1
  store i64 %29, ptr %27, align 8
  %30 = load i64, ptr %3, align 8
  %31 = load i64, ptr %4, align 8
  call void @_ZNKSt3__15dequeIfNS_9allocatorIfEEE23__annotate_shrink_frontB8ne190107Emm(ptr noundef nonnull align 8 dereferenceable(48) %6, i64 noundef %30, i64 noundef %31) #13
  %32 = call noundef zeroext i1 @_ZNSt3__15dequeIfNS_9allocatorIfEEE26__maybe_remove_front_spareB8ne190107Eb(ptr noundef nonnull align 8 dereferenceable(48) %6, i1 noundef zeroext true)
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__112__to_addressB8ne190107IfEEPT_S2_(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNKSt3__15dequeIfNS_9allocatorIfEEE23__annotate_shrink_frontB8ne190107Emm(ptr noundef nonnull align 8 dereferenceable(48) %0, i64 noundef %1, i64 noundef %2) #1 {
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  store i64 %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  ret void
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef zeroext i1 @_ZNSt3__15dequeIfNS_9allocatorIfEEE26__maybe_remove_front_spareB8ne190107Eb(ptr noundef nonnull align 8 dereferenceable(48) %0, i1 noundef zeroext %1) #0 {
  %3 = alloca i1, align 1
  %4 = alloca ptr, align 8
  %5 = alloca i8, align 1
  store ptr %0, ptr %4, align 8
  %6 = zext i1 %1 to i8
  store i8 %6, ptr %5, align 1
  %7 = load ptr, ptr %4, align 8
  %8 = call noundef i64 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE20__front_spare_blocksB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %7)
  %9 = icmp uge i64 %8, 2
  br i1 %9, label %16, label %10

10:                                               ; preds = %2
  %11 = load i8, ptr %5, align 1
  %12 = trunc i8 %11 to i1
  br i1 %12, label %25, label %13

13:                                               ; preds = %10
  %14 = call noundef i64 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE20__front_spare_blocksB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %7)
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %16, label %25

16:                                               ; preds = %13, %2
  call void @_ZNKSt3__15dequeIfNS_9allocatorIfEEE22__annotate_whole_blockB8ne190107EmNS3_22__asan_annotation_typeE(ptr noundef nonnull align 8 dereferenceable(48) %7, i64 noundef 0, i32 noundef 0) #13
  %17 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %7) #13
  %18 = getelementptr inbounds %"class.std::__1::deque", ptr %7, i32 0, i32 0
  %19 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE5frontB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %18)
  %20 = load ptr, ptr %19, align 8
  call void @_ZNSt3__116allocator_traitsINS_9allocatorIfEEE10deallocateB8ne190107ERS2_Pfm(ptr noundef nonnull align 1 dereferenceable(1) %17, ptr noundef %20, i64 noundef 1024) #13
  %21 = getelementptr inbounds %"class.std::__1::deque", ptr %7, i32 0, i32 0
  call void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9pop_frontB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %21)
  %22 = getelementptr inbounds %"class.std::__1::deque", ptr %7, i32 0, i32 1
  %23 = load i64, ptr %22, align 8
  %24 = sub i64 %23, 1024
  store i64 %24, ptr %22, align 8
  store i1 true, ptr %3, align 1
  br label %26

25:                                               ; preds = %13, %10
  store i1 false, ptr %3, align 1
  br label %26

26:                                               ; preds = %25, %16
  %27 = load i1, ptr %3, align 1
  ret i1 %27
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef i64 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE20__front_spare_blocksB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef i64 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE13__front_spareB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %3)
  %5 = udiv i64 %4, 1024
  ret i64 %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNKSt3__15dequeIfNS_9allocatorIfEEE22__annotate_whole_blockB8ne190107EmNS3_22__asan_annotation_typeE(ptr noundef nonnull align 8 dereferenceable(48) %0, i64 noundef %1, i32 noundef %2) #1 {
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  store i32 %2, ptr %6, align 4
  %7 = load ptr, ptr %4, align 8
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef i64 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE13__front_spareB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::deque", ptr %3, i32 0, i32 1
  %5 = load i64, ptr %4, align 8
  ret i64 %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN20ac_channel_exception3msgERKNS_4codeE(ptr noundef nonnull align 4 dereferenceable(4) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load i32, ptr %3, align 4
  %5 = sub nsw i32 %4, 1024
  %6 = sext i32 %5 to i64
  %7 = getelementptr inbounds [9 x ptr], ptr @_ZZN20ac_channel_exception3msgERKNS_4codeEE1s, i64 0, i64 %6
  %8 = load ptr, ptr %7, align 8
  ret ptr %8
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN12ac_exceptionC1EPKcRKjRKiS1_(ptr noundef nonnull returned align 8 dereferenceable(24) %0, ptr noundef %1, ptr noundef nonnull align 4 dereferenceable(4) %2, ptr noundef nonnull align 4 dereferenceable(4) %3, ptr noundef %4) unnamed_addr #0 {
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  store ptr %0, ptr %6, align 8
  store ptr %1, ptr %7, align 8
  store ptr %2, ptr %8, align 8
  store ptr %3, ptr %9, align 8
  store ptr %4, ptr %10, align 8
  %11 = load ptr, ptr %6, align 8
  %12 = load ptr, ptr %7, align 8
  %13 = load ptr, ptr %8, align 8
  %14 = load ptr, ptr %9, align 8
  %15 = load ptr, ptr %10, align 8
  %16 = call noundef ptr @_ZN12ac_exceptionC2EPKcRKjRKiS1_(ptr noundef nonnull align 8 dereferenceable(24) %11, ptr noundef %12, ptr noundef nonnull align 4 dereferenceable(4) %13, ptr noundef nonnull align 4 dereferenceable(4) %14, ptr noundef %15)
  ret ptr %11
}

; Function Attrs: nounwind
declare i32 @fprintf(ptr noundef, ptr noundef, ...) #6

; Function Attrs: cold noreturn
declare void @__assert_rtn(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #7

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN12ac_exceptionC2EPKcRKjRKiS1_(ptr noundef nonnull returned align 8 dereferenceable(24) %0, ptr noundef %1, ptr noundef nonnull align 4 dereferenceable(4) %2, ptr noundef nonnull align 4 dereferenceable(4) %3, ptr noundef %4) unnamed_addr #1 {
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  store ptr %0, ptr %6, align 8
  store ptr %1, ptr %7, align 8
  store ptr %2, ptr %8, align 8
  store ptr %3, ptr %9, align 8
  store ptr %4, ptr %10, align 8
  %11 = load ptr, ptr %6, align 8
  %12 = getelementptr inbounds %struct.ac_exception, ptr %11, i32 0, i32 0
  %13 = load ptr, ptr %7, align 8
  store ptr %13, ptr %12, align 8
  %14 = getelementptr inbounds %struct.ac_exception, ptr %11, i32 0, i32 1
  %15 = load ptr, ptr %8, align 8
  %16 = load i32, ptr %15, align 4
  store i32 %16, ptr %14, align 8
  %17 = getelementptr inbounds %struct.ac_exception, ptr %11, i32 0, i32 2
  %18 = load ptr, ptr %9, align 8
  %19 = load i32, ptr %18, align 4
  store i32 %19, ptr %17, align 4
  %20 = getelementptr inbounds %struct.ac_exception, ptr %11, i32 0, i32 3
  %21 = load ptr, ptr %10, align 8
  store ptr %21, ptr %20, align 8
  ret ptr %11
}

; Function Attrs: alwaysinline mustprogress ssp uwtable(sync)
define void @__df_write_f32(ptr noundef %0, float noundef %1) #4 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca float, align 4
  store ptr %0, ptr %7, align 8
  store float %1, ptr %8, align 4
  %9 = load ptr, ptr %7, align 8
  store ptr %9, ptr %5, align 8
  store ptr %8, ptr %6, align 8
  %10 = load ptr, ptr %5, align 8
  %11 = load ptr, ptr %6, align 8
  store ptr %10, ptr %3, align 8
  store ptr %11, ptr %4, align 8
  %12 = load ptr, ptr %3, align 8
  %13 = load ptr, ptr %4, align 8
  %14 = load float, ptr %13, align 4
  %15 = call noundef zeroext i1 @_ZN10ac_channelIfE21_write_bambu_internalIfEEbT_(ptr noundef nonnull align 8 dereferenceable(60) %12, float noundef %14)
  ret void
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr noundef zeroext i1 @_ZN10ac_channelIfE21_write_bambu_internalIfEEbT_(ptr noundef nonnull align 8 dereferenceable(60) %0, float noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca float, align 4
  %8 = alloca i32, align 4
  %9 = alloca float, align 4
  store ptr %0, ptr %6, align 8
  store float %1, ptr %7, align 4
  %10 = load ptr, ptr %6, align 8
  store ptr %10, ptr %5, align 8
  %11 = load ptr, ptr %5, align 8
  %12 = call noundef i64 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE8max_sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %11) #13
  %13 = call noundef i64 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE4sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %11) #13
  %14 = sub i64 %12, %13
  %15 = trunc i64 %14 to i32
  %16 = icmp ne i32 %15, 0
  store i32 1032, ptr %8, align 4
  call void @_ZN10ac_channelIfE9ac_assertEbPKciRKN20ac_channel_exception4codeE(i1 noundef zeroext %16, ptr noundef @.str, i32 noundef 883, ptr noundef nonnull align 4 dereferenceable(4) %8)
  store ptr %9, ptr %3, align 8
  store ptr %7, ptr %4, align 8
  %17 = load ptr, ptr %4, align 8
  %18 = load float, ptr %17, align 4
  %19 = load ptr, ptr %3, align 8
  store float %18, ptr %19, align 4
  %20 = getelementptr inbounds %class.ac_channel, ptr %10, i32 0, i32 0
  call void @_ZNSt3__15dequeIfNS_9allocatorIfEEE9push_backERKf(ptr noundef nonnull align 8 dereferenceable(48) %20, ptr noundef nonnull align 4 dereferenceable(4) %9)
  ret i1 true
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef i64 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE8max_sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %0) #1 personality ptr @__gxx_personality_v0 {
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store ptr %0, ptr %2, align 8
  %5 = load ptr, ptr %2, align 8
  %6 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNKSt3__15dequeIfNS_9allocatorIfEEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %5) #13
  %7 = call noundef i64 @_ZNSt3__116allocator_traitsINS_9allocatorIfEEE8max_sizeB8ne190107IS2_TnNS_9enable_ifIXsr14__has_max_sizeIKT_EE5valueEiE4typeELi0EEEmRKS2_(ptr noundef nonnull align 1 dereferenceable(1) %6) #13
  store i64 %7, ptr %3, align 8
  %8 = call noundef i64 @_ZNSt3__114numeric_limitsIlE3maxB8ne190107Ev() #13
  store i64 %8, ptr %4, align 8
  %9 = invoke noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__13minB8ne190107ImEERKT_S3_S3_(ptr noundef nonnull align 8 dereferenceable(8) %3, ptr noundef nonnull align 8 dereferenceable(8) %4)
          to label %10 unwind label %12

10:                                               ; preds = %1
  %11 = load i64, ptr %9, align 8
  ret i64 %11

12:                                               ; preds = %1
  %13 = landingpad { ptr, i32 }
          catch ptr null
  %14 = extractvalue { ptr, i32 } %13, 0
  call void @__clang_call_terminate(ptr %14) #14
  unreachable
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__15dequeIfNS_9allocatorIfEEE9push_backERKf(ptr noundef nonnull align 8 dereferenceable(48) %0, ptr noundef nonnull align 4 dereferenceable(4) %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca %"class.std::__1::__deque_iterator", align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %7 = load ptr, ptr %3, align 8
  %8 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %7) #13
  store ptr %8, ptr %5, align 8
  %9 = call noundef i64 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE12__back_spareB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %7)
  %10 = icmp eq i64 %9, 0
  br i1 %10, label %11, label %12

11:                                               ; preds = %2
  call void @_ZNSt3__15dequeIfNS_9allocatorIfEEE19__add_back_capacityEv(ptr noundef nonnull align 8 dereferenceable(48) %7)
  br label %12

12:                                               ; preds = %11, %2
  call void @_ZNKSt3__15dequeIfNS_9allocatorIfEEE24__annotate_increase_backB8ne190107Em(ptr noundef nonnull align 8 dereferenceable(48) %7, i64 noundef 1) #13
  %13 = load ptr, ptr %5, align 8
  %14 = call [2 x i64] @_ZNSt3__15dequeIfNS_9allocatorIfEEE3endB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %7) #13
  store [2 x i64] %14, ptr %6, align 8
  %15 = call noundef nonnull align 4 dereferenceable(4) ptr @_ZNKSt3__116__deque_iteratorIfPfRfPS1_lLl1024EEdeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(16) %6)
  %16 = load ptr, ptr %4, align 8
  call void @_ZNSt3__116allocator_traitsINS_9allocatorIfEEE9constructB8ne190107IfJRKfETnNS_9enable_ifIXsr15__has_constructIS2_PT_DpT0_EE5valueEiE4typeELi0EEEvRS2_S9_DpOSA_(ptr noundef nonnull align 1 dereferenceable(1) %13, ptr noundef %15, ptr noundef nonnull align 4 dereferenceable(4) %16)
  %17 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEE6__sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %7) #13
  %18 = load i64, ptr %17, align 8
  %19 = add i64 %18, 1
  store i64 %19, ptr %17, align 8
  ret void
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef i64 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE12__back_spareB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef i64 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE10__capacityB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %3)
  %5 = getelementptr inbounds %"class.std::__1::deque", ptr %3, i32 0, i32 1
  %6 = load i64, ptr %5, align 8
  %7 = call noundef i64 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE4sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %3) #13
  %8 = add i64 %6, %7
  %9 = sub i64 %4, %8
  ret i64 %9
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__15dequeIfNS_9allocatorIfEEE19__add_back_capacityEv(ptr noundef nonnull align 8 dereferenceable(48) %0) #0 personality ptr @__gxx_personality_v0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca %"struct.std::__1::__split_buffer.8", align 8
  %9 = alloca i64, align 8
  %10 = alloca i64, align 8
  %11 = alloca %"class.std::__1::unique_ptr", align 8
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  %14 = alloca %"class.std::__1::__allocator_destructor", align 8
  %15 = alloca ptr, align 8
  %16 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %17 = load ptr, ptr %2, align 8
  %18 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__15dequeIfNS_9allocatorIfEEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %17) #13
  store ptr %18, ptr %3, align 8
  %19 = call noundef i64 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE13__front_spareB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %17)
  %20 = icmp uge i64 %19, 1024
  br i1 %20, label %21, label %30

21:                                               ; preds = %1
  %22 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 1
  %23 = load i64, ptr %22, align 8
  %24 = sub i64 %23, 1024
  store i64 %24, ptr %22, align 8
  %25 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  %26 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE5frontB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %25)
  %27 = load ptr, ptr %26, align 8
  store ptr %27, ptr %4, align 8
  %28 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  call void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9pop_frontB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %28)
  %29 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  call void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9push_backB8ne190107ERKS1_(ptr noundef nonnull align 8 dereferenceable(32) %29, ptr noundef nonnull align 8 dereferenceable(8) %4)
  br label %118

30:                                               ; preds = %1
  %31 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  %32 = call noundef i64 @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE4sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %31)
  %33 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  %34 = call noundef i64 @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE8capacityB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %33)
  %35 = icmp ult i64 %32, %34
  br i1 %35, label %36, label %57

36:                                               ; preds = %30
  %37 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  %38 = call noundef i64 @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE12__back_spareB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %37)
  %39 = icmp ne i64 %38, 0
  br i1 %39, label %40, label %44

40:                                               ; preds = %36
  %41 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  %42 = load ptr, ptr %3, align 8
  %43 = call noundef ptr @_ZNSt3__116allocator_traitsINS_9allocatorIfEEE8allocateB8ne190107ERS2_m(ptr noundef nonnull align 1 dereferenceable(1) %42, i64 noundef 1024)
  store ptr %43, ptr %5, align 8
  call void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9push_backEOS1_(ptr noundef nonnull align 8 dereferenceable(32) %41, ptr noundef nonnull align 8 dereferenceable(8) %5)
  br label %53

44:                                               ; preds = %36
  %45 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  %46 = load ptr, ptr %3, align 8
  %47 = call noundef ptr @_ZNSt3__116allocator_traitsINS_9allocatorIfEEE8allocateB8ne190107ERS2_m(ptr noundef nonnull align 1 dereferenceable(1) %46, i64 noundef 1024)
  store ptr %47, ptr %6, align 8
  call void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE10push_frontEOS1_(ptr noundef nonnull align 8 dereferenceable(32) %45, ptr noundef nonnull align 8 dereferenceable(8) %6)
  %48 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  %49 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE5frontB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %48)
  %50 = load ptr, ptr %49, align 8
  store ptr %50, ptr %7, align 8
  %51 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  call void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9pop_frontB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %51)
  %52 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  call void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9push_backB8ne190107ERKS1_(ptr noundef nonnull align 8 dereferenceable(32) %52, ptr noundef nonnull align 8 dereferenceable(8) %7)
  br label %53

53:                                               ; preds = %44, %40
  %54 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  %55 = call noundef i64 @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE4sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %54)
  %56 = sub i64 %55, 1
  call void @_ZNKSt3__15dequeIfNS_9allocatorIfEEE22__annotate_whole_blockB8ne190107EmNS3_22__asan_annotation_typeE(ptr noundef nonnull align 8 dereferenceable(48) %17, i64 noundef %56, i32 noundef 1) #13
  br label %117

57:                                               ; preds = %30
  %58 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  %59 = call noundef i64 @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE8capacityB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %58)
  %60 = mul i64 2, %59
  store i64 %60, ptr %9, align 8
  store i64 1, ptr %10, align 8
  %61 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__13maxB8ne190107ImEERKT_S3_S3_(ptr noundef nonnull align 8 dereferenceable(8) %9, ptr noundef nonnull align 8 dereferenceable(8) %10)
  %62 = load i64, ptr %61, align 8
  %63 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  %64 = call noundef i64 @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE4sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %63)
  %65 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  %66 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %65) #13
  %67 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEEC1EmmS4_(ptr noundef nonnull align 8 dereferenceable(40) %8, i64 noundef %62, i64 noundef %64, ptr noundef nonnull align 1 dereferenceable(1) %66)
  %68 = load ptr, ptr %3, align 8
  %69 = invoke noundef ptr @_ZNSt3__116allocator_traitsINS_9allocatorIfEEE8allocateB8ne190107ERS2_m(ptr noundef nonnull align 1 dereferenceable(1) %68, i64 noundef 1024)
          to label %70 unwind label %88

70:                                               ; preds = %57
  %71 = load ptr, ptr %3, align 8
  %72 = call noundef ptr @_ZNSt3__122__allocator_destructorINS_9allocatorIfEEEC1B8ne190107ERS2_m(ptr noundef nonnull align 8 dereferenceable(16) %14, ptr noundef nonnull align 1 dereferenceable(1) %71, i64 noundef 1024) #13
  %73 = call noundef ptr @_ZNSt3__110unique_ptrIPfNS_22__allocator_destructorINS_9allocatorIfEEEEEC1B8ne190107ILb1EvEES1_NS_16__dependent_typeINS_27__unique_ptr_deleter_sfinaeIS5_EEXT_EE20__good_rval_ref_typeE(ptr noundef nonnull align 8 dereferenceable(24) %11, ptr noundef %69, ptr noundef nonnull align 8 dereferenceable(16) %14) #13
  %74 = call noundef ptr @_ZNKSt3__110unique_ptrIPfNS_22__allocator_destructorINS_9allocatorIfEEEEE3getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %11) #13
  store ptr %74, ptr %15, align 8
  invoke void @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9push_backEOS1_(ptr noundef nonnull align 8 dereferenceable(40) %8, ptr noundef nonnull align 8 dereferenceable(8) %15)
          to label %75 unwind label %92

75:                                               ; preds = %70
  %76 = call noundef ptr @_ZNSt3__110unique_ptrIPfNS_22__allocator_destructorINS_9allocatorIfEEEEE7releaseB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %11) #13
  %77 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  %78 = call noundef ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE3endB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %77) #13
  store ptr %78, ptr %16, align 8
  br label %79

79:                                               ; preds = %87, %75
  %80 = load ptr, ptr %16, align 8
  %81 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  %82 = call noundef ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE5beginB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %81) #13
  %83 = icmp ne ptr %80, %82
  br i1 %83, label %84, label %97

84:                                               ; preds = %79
  %85 = load ptr, ptr %16, align 8
  %86 = getelementptr inbounds ptr, ptr %85, i32 -1
  store ptr %86, ptr %16, align 8
  invoke void @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE10push_frontERKS1_(ptr noundef nonnull align 8 dereferenceable(40) %8, ptr noundef nonnull align 8 dereferenceable(8) %86)
          to label %87 unwind label %92

87:                                               ; preds = %84
  br label %79, !llvm.loop !12

88:                                               ; preds = %57
  %89 = landingpad { ptr, i32 }
          cleanup
  %90 = extractvalue { ptr, i32 } %89, 0
  store ptr %90, ptr %12, align 8
  %91 = extractvalue { ptr, i32 } %89, 1
  store i32 %91, ptr %13, align 4
  br label %115

92:                                               ; preds = %84, %70
  %93 = landingpad { ptr, i32 }
          cleanup
  %94 = extractvalue { ptr, i32 } %93, 0
  store ptr %94, ptr %12, align 8
  %95 = extractvalue { ptr, i32 } %93, 1
  store i32 %95, ptr %13, align 4
  %96 = call noundef ptr @_ZNSt3__110unique_ptrIPfNS_22__allocator_destructorINS_9allocatorIfEEEEED1B8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %11) #13
  br label %115

97:                                               ; preds = %79
  %98 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  %99 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %98, i32 0, i32 0
  %100 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %8, i32 0, i32 0
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %99, ptr noundef nonnull align 8 dereferenceable(8) %100) #13
  %101 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  %102 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %101, i32 0, i32 1
  %103 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %8, i32 0, i32 1
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %102, ptr noundef nonnull align 8 dereferenceable(8) %103) #13
  %104 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  %105 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %104, i32 0, i32 2
  %106 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %8, i32 0, i32 2
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %105, ptr noundef nonnull align 8 dereferenceable(8) %106) #13
  %107 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  %108 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %107) #13
  %109 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %8) #13
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %108, ptr noundef nonnull align 8 dereferenceable(8) %109) #13
  %110 = getelementptr inbounds %"class.std::__1::deque", ptr %17, i32 0, i32 0
  %111 = call noundef i64 @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE4sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %110)
  %112 = sub i64 %111, 1
  call void @_ZNKSt3__15dequeIfNS_9allocatorIfEEE22__annotate_whole_blockB8ne190107EmNS3_22__asan_annotation_typeE(ptr noundef nonnull align 8 dereferenceable(48) %17, i64 noundef %112, i32 noundef 1) #13
  %113 = call noundef ptr @_ZNSt3__110unique_ptrIPfNS_22__allocator_destructorINS_9allocatorIfEEEEED1B8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %11) #13
  %114 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEED1Ev(ptr noundef nonnull align 8 dereferenceable(40) %8) #13
  br label %117

115:                                              ; preds = %92, %88
  %116 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEED1Ev(ptr noundef nonnull align 8 dereferenceable(40) %8) #13
  br label %119

117:                                              ; preds = %97, %53
  br label %118

118:                                              ; preds = %117, %21
  ret void

119:                                              ; preds = %115
  %120 = load ptr, ptr %12, align 8
  %121 = load i32, ptr %13, align 4
  %122 = insertvalue { ptr, i32 } poison, ptr %120, 0
  %123 = insertvalue { ptr, i32 } %122, i32 %121, 1
  resume { ptr, i32 } %123
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNKSt3__15dequeIfNS_9allocatorIfEEE24__annotate_increase_backB8ne190107Em(ptr noundef nonnull align 8 dereferenceable(48) %0, i64 noundef %1) #1 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  ret void
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr void @_ZNSt3__116allocator_traitsINS_9allocatorIfEEE9constructB8ne190107IfJRKfETnNS_9enable_ifIXsr15__has_constructIS2_PT_DpT0_EE5valueEiE4typeELi0EEEvRS2_S9_DpOSA_(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1, ptr noundef nonnull align 4 dereferenceable(4) %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  call void @_ZNSt3__19allocatorIfE9constructB8ne190107IfJRKfEEEvPT_DpOT0_(ptr noundef nonnull align 1 dereferenceable(1) %7, ptr noundef %8, ptr noundef nonnull align 4 dereferenceable(4) %9)
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr void @_ZNSt3__19allocatorIfE9constructB8ne190107IfJRKfEEEvPT_DpOT0_(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1, ptr noundef nonnull align 4 dereferenceable(4) %2) #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = load float, ptr %9, align 4
  store float %10, ptr %8, align 4
  ret void
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9push_backB8ne190107ERKS1_(ptr noundef nonnull align 8 dereferenceable(32) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) #0 personality ptr @__gxx_personality_v0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca %"struct.std::__1::__split_buffer.8", align 8
  %10 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  %13 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %14 = load ptr, ptr %3, align 8
  %15 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %16 = load ptr, ptr %15, align 8
  %17 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %14) #13
  %18 = load ptr, ptr %17, align 8
  %19 = icmp eq ptr %16, %18
  br i1 %19, label %20, label %101

20:                                               ; preds = %2
  %21 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %22 = load ptr, ptr %21, align 8
  %23 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 0
  %24 = load ptr, ptr %23, align 8
  %25 = icmp ugt ptr %22, %24
  br i1 %25, label %26, label %54

26:                                               ; preds = %20
  %27 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %28 = load ptr, ptr %27, align 8
  %29 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 0
  %30 = load ptr, ptr %29, align 8
  %31 = ptrtoint ptr %28 to i64
  %32 = ptrtoint ptr %30 to i64
  %33 = sub i64 %31, %32
  %34 = sdiv exact i64 %33, 8
  store i64 %34, ptr %5, align 8
  %35 = load i64, ptr %5, align 8
  %36 = add nsw i64 %35, 1
  %37 = sdiv i64 %36, 2
  store i64 %37, ptr %5, align 8
  %38 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %39 = load ptr, ptr %38, align 8
  %40 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %41 = load ptr, ptr %40, align 8
  %42 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %43 = load ptr, ptr %42, align 8
  %44 = load i64, ptr %5, align 8
  %45 = sub i64 0, %44
  %46 = getelementptr inbounds ptr, ptr %43, i64 %45
  %47 = call noundef ptr @_ZNSt3__14moveB8ne190107IPPfS2_EET0_T_S4_S3_(ptr noundef %39, ptr noundef %41, ptr noundef %46)
  %48 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  store ptr %47, ptr %48, align 8
  %49 = load i64, ptr %5, align 8
  %50 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %51 = load ptr, ptr %50, align 8
  %52 = sub i64 0, %49
  %53 = getelementptr inbounds ptr, ptr %51, i64 %52
  store ptr %53, ptr %50, align 8
  br label %100

54:                                               ; preds = %20
  %55 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %14) #13
  %56 = load ptr, ptr %55, align 8
  %57 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 0
  %58 = load ptr, ptr %57, align 8
  %59 = ptrtoint ptr %56 to i64
  %60 = ptrtoint ptr %58 to i64
  %61 = sub i64 %59, %60
  %62 = sdiv exact i64 %61, 8
  %63 = mul i64 2, %62
  store i64 %63, ptr %7, align 8
  store i64 1, ptr %8, align 8
  %64 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__13maxB8ne190107ImEERKT_S3_S3_(ptr noundef nonnull align 8 dereferenceable(8) %7, ptr noundef nonnull align 8 dereferenceable(8) %8)
  %65 = load i64, ptr %64, align 8
  store i64 %65, ptr %6, align 8
  %66 = load i64, ptr %6, align 8
  %67 = load i64, ptr %6, align 8
  %68 = udiv i64 %67, 4
  %69 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %14) #13
  %70 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEEC1EmmS4_(ptr noundef nonnull align 8 dereferenceable(40) %9, i64 noundef %66, i64 noundef %68, ptr noundef nonnull align 1 dereferenceable(1) %69)
  %71 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %72 = load ptr, ptr %71, align 8
  %73 = invoke noundef ptr @_ZNSt3__113move_iteratorIPPfEC1B8ne190107ES2_(ptr noundef nonnull align 8 dereferenceable(8) %10, ptr noundef %72)
          to label %74 unwind label %95

74:                                               ; preds = %54
  %75 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %76 = load ptr, ptr %75, align 8
  %77 = invoke noundef ptr @_ZNSt3__113move_iteratorIPPfEC1B8ne190107ES2_(ptr noundef nonnull align 8 dereferenceable(8) %13, ptr noundef %76)
          to label %78 unwind label %95

78:                                               ; preds = %74
  %79 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %10, i32 0, i32 0
  %80 = load ptr, ptr %79, align 8
  %81 = ptrtoint ptr %80 to i64
  %82 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %13, i32 0, i32 0
  %83 = load ptr, ptr %82, align 8
  %84 = ptrtoint ptr %83 to i64
  invoke void @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE18__construct_at_endINS_13move_iteratorIPS1_EETnNS_9enable_ifIXsr31__has_forward_iterator_categoryIT_EE5valueEiE4typeELi0EEEvSB_SB_(ptr noundef nonnull align 8 dereferenceable(40) %9, i64 %81, i64 %84)
          to label %85 unwind label %95

85:                                               ; preds = %78
  %86 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 0
  %87 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %9, i32 0, i32 0
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %86, ptr noundef nonnull align 8 dereferenceable(8) %87) #13
  %88 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %89 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %9, i32 0, i32 1
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %88, ptr noundef nonnull align 8 dereferenceable(8) %89) #13
  %90 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %91 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %9, i32 0, i32 2
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %90, ptr noundef nonnull align 8 dereferenceable(8) %91) #13
  %92 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %14) #13
  %93 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %9) #13
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %92, ptr noundef nonnull align 8 dereferenceable(8) %93) #13
  %94 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEED1Ev(ptr noundef nonnull align 8 dereferenceable(40) %9) #13
  br label %100

95:                                               ; preds = %78, %74, %54
  %96 = landingpad { ptr, i32 }
          cleanup
  %97 = extractvalue { ptr, i32 } %96, 0
  store ptr %97, ptr %11, align 8
  %98 = extractvalue { ptr, i32 } %96, 1
  store i32 %98, ptr %12, align 4
  %99 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEED1Ev(ptr noundef nonnull align 8 dereferenceable(40) %9) #13
  br label %110

100:                                              ; preds = %85, %26
  br label %101

101:                                              ; preds = %100, %2
  %102 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %14) #13
  %103 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %104 = load ptr, ptr %103, align 8
  %105 = call noundef ptr @_ZNSt3__112__to_addressB8ne190107IPfEEPT_S3_(ptr noundef %104) #13
  %106 = load ptr, ptr %4, align 8
  call void @_ZNSt3__116allocator_traitsINS_9allocatorIPfEEE9constructB8ne190107IS2_JRKS2_ETnNS_9enable_ifIXsr15__has_constructIS3_PT_DpT0_EE5valueEiE4typeELi0EEEvRS3_SA_DpOSB_(ptr noundef nonnull align 1 dereferenceable(1) %102, ptr noundef %105, ptr noundef nonnull align 8 dereferenceable(8) %106)
  %107 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %108 = load ptr, ptr %107, align 8
  %109 = getelementptr inbounds ptr, ptr %108, i32 1
  store ptr %109, ptr %107, align 8
  ret void

110:                                              ; preds = %95
  %111 = load ptr, ptr %11, align 8
  %112 = load i32, ptr %12, align 4
  %113 = insertvalue { ptr, i32 } poison, ptr %111, 0
  %114 = insertvalue { ptr, i32 } %113, i32 %112, 1
  resume { ptr, i32 } %114
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef i64 @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE12__back_spareB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %3) #13
  %5 = load ptr, ptr %4, align 8
  %6 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %3, i32 0, i32 2
  %7 = load ptr, ptr %6, align 8
  %8 = ptrtoint ptr %5 to i64
  %9 = ptrtoint ptr %7 to i64
  %10 = sub i64 %8, %9
  %11 = sdiv exact i64 %10, 8
  ret i64 %11
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__116allocator_traitsINS_9allocatorIfEEE8allocateB8ne190107ERS2_m(ptr noundef nonnull align 1 dereferenceable(1) %0, i64 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load i64, ptr %4, align 8
  %7 = call noundef ptr @_ZNSt3__19allocatorIfE8allocateB8ne190107Em(ptr noundef nonnull align 1 dereferenceable(1) %5, i64 noundef %6)
  ret ptr %7
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9push_backEOS1_(ptr noundef nonnull align 8 dereferenceable(32) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) #0 personality ptr @__gxx_personality_v0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca %"struct.std::__1::__split_buffer.8", align 8
  %10 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  %13 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %14 = load ptr, ptr %3, align 8
  %15 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %16 = load ptr, ptr %15, align 8
  %17 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %14) #13
  %18 = load ptr, ptr %17, align 8
  %19 = icmp eq ptr %16, %18
  br i1 %19, label %20, label %101

20:                                               ; preds = %2
  %21 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %22 = load ptr, ptr %21, align 8
  %23 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 0
  %24 = load ptr, ptr %23, align 8
  %25 = icmp ugt ptr %22, %24
  br i1 %25, label %26, label %54

26:                                               ; preds = %20
  %27 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %28 = load ptr, ptr %27, align 8
  %29 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 0
  %30 = load ptr, ptr %29, align 8
  %31 = ptrtoint ptr %28 to i64
  %32 = ptrtoint ptr %30 to i64
  %33 = sub i64 %31, %32
  %34 = sdiv exact i64 %33, 8
  store i64 %34, ptr %5, align 8
  %35 = load i64, ptr %5, align 8
  %36 = add nsw i64 %35, 1
  %37 = sdiv i64 %36, 2
  store i64 %37, ptr %5, align 8
  %38 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %39 = load ptr, ptr %38, align 8
  %40 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %41 = load ptr, ptr %40, align 8
  %42 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %43 = load ptr, ptr %42, align 8
  %44 = load i64, ptr %5, align 8
  %45 = sub i64 0, %44
  %46 = getelementptr inbounds ptr, ptr %43, i64 %45
  %47 = call noundef ptr @_ZNSt3__14moveB8ne190107IPPfS2_EET0_T_S4_S3_(ptr noundef %39, ptr noundef %41, ptr noundef %46)
  %48 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  store ptr %47, ptr %48, align 8
  %49 = load i64, ptr %5, align 8
  %50 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %51 = load ptr, ptr %50, align 8
  %52 = sub i64 0, %49
  %53 = getelementptr inbounds ptr, ptr %51, i64 %52
  store ptr %53, ptr %50, align 8
  br label %100

54:                                               ; preds = %20
  %55 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %14) #13
  %56 = load ptr, ptr %55, align 8
  %57 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 0
  %58 = load ptr, ptr %57, align 8
  %59 = ptrtoint ptr %56 to i64
  %60 = ptrtoint ptr %58 to i64
  %61 = sub i64 %59, %60
  %62 = sdiv exact i64 %61, 8
  %63 = mul i64 2, %62
  store i64 %63, ptr %7, align 8
  store i64 1, ptr %8, align 8
  %64 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__13maxB8ne190107ImEERKT_S3_S3_(ptr noundef nonnull align 8 dereferenceable(8) %7, ptr noundef nonnull align 8 dereferenceable(8) %8)
  %65 = load i64, ptr %64, align 8
  store i64 %65, ptr %6, align 8
  %66 = load i64, ptr %6, align 8
  %67 = load i64, ptr %6, align 8
  %68 = udiv i64 %67, 4
  %69 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %14) #13
  %70 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEEC1EmmS4_(ptr noundef nonnull align 8 dereferenceable(40) %9, i64 noundef %66, i64 noundef %68, ptr noundef nonnull align 1 dereferenceable(1) %69)
  %71 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %72 = load ptr, ptr %71, align 8
  %73 = invoke noundef ptr @_ZNSt3__113move_iteratorIPPfEC1B8ne190107ES2_(ptr noundef nonnull align 8 dereferenceable(8) %10, ptr noundef %72)
          to label %74 unwind label %95

74:                                               ; preds = %54
  %75 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %76 = load ptr, ptr %75, align 8
  %77 = invoke noundef ptr @_ZNSt3__113move_iteratorIPPfEC1B8ne190107ES2_(ptr noundef nonnull align 8 dereferenceable(8) %13, ptr noundef %76)
          to label %78 unwind label %95

78:                                               ; preds = %74
  %79 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %10, i32 0, i32 0
  %80 = load ptr, ptr %79, align 8
  %81 = ptrtoint ptr %80 to i64
  %82 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %13, i32 0, i32 0
  %83 = load ptr, ptr %82, align 8
  %84 = ptrtoint ptr %83 to i64
  invoke void @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE18__construct_at_endINS_13move_iteratorIPS1_EETnNS_9enable_ifIXsr31__has_forward_iterator_categoryIT_EE5valueEiE4typeELi0EEEvSB_SB_(ptr noundef nonnull align 8 dereferenceable(40) %9, i64 %81, i64 %84)
          to label %85 unwind label %95

85:                                               ; preds = %78
  %86 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 0
  %87 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %9, i32 0, i32 0
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %86, ptr noundef nonnull align 8 dereferenceable(8) %87) #13
  %88 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %89 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %9, i32 0, i32 1
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %88, ptr noundef nonnull align 8 dereferenceable(8) %89) #13
  %90 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %91 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %9, i32 0, i32 2
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %90, ptr noundef nonnull align 8 dereferenceable(8) %91) #13
  %92 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %14) #13
  %93 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %9) #13
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %92, ptr noundef nonnull align 8 dereferenceable(8) %93) #13
  %94 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEED1Ev(ptr noundef nonnull align 8 dereferenceable(40) %9) #13
  br label %100

95:                                               ; preds = %78, %74, %54
  %96 = landingpad { ptr, i32 }
          cleanup
  %97 = extractvalue { ptr, i32 } %96, 0
  store ptr %97, ptr %11, align 8
  %98 = extractvalue { ptr, i32 } %96, 1
  store i32 %98, ptr %12, align 4
  %99 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEED1Ev(ptr noundef nonnull align 8 dereferenceable(40) %9) #13
  br label %110

100:                                              ; preds = %85, %26
  br label %101

101:                                              ; preds = %100, %2
  %102 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %14) #13
  %103 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %104 = load ptr, ptr %103, align 8
  %105 = call noundef ptr @_ZNSt3__112__to_addressB8ne190107IPfEEPT_S3_(ptr noundef %104) #13
  %106 = load ptr, ptr %4, align 8
  call void @_ZNSt3__116allocator_traitsINS_9allocatorIPfEEE9constructB8ne190107IS2_JS2_ETnNS_9enable_ifIXsr15__has_constructIS3_PT_DpT0_EE5valueEiE4typeELi0EEEvRS3_S8_DpOS9_(ptr noundef nonnull align 1 dereferenceable(1) %102, ptr noundef %105, ptr noundef nonnull align 8 dereferenceable(8) %106)
  %107 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %108 = load ptr, ptr %107, align 8
  %109 = getelementptr inbounds ptr, ptr %108, i32 1
  store ptr %109, ptr %107, align 8
  ret void

110:                                              ; preds = %95
  %111 = load ptr, ptr %11, align 8
  %112 = load i32, ptr %12, align 4
  %113 = insertvalue { ptr, i32 } poison, ptr %111, 0
  %114 = insertvalue { ptr, i32 } %113, i32 %112, 1
  resume { ptr, i32 } %114
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE10push_frontEOS1_(ptr noundef nonnull align 8 dereferenceable(32) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) #0 personality ptr @__gxx_personality_v0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca %"struct.std::__1::__split_buffer.8", align 8
  %10 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  %13 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %14 = load ptr, ptr %3, align 8
  %15 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %16 = load ptr, ptr %15, align 8
  %17 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 0
  %18 = load ptr, ptr %17, align 8
  %19 = icmp eq ptr %16, %18
  br i1 %19, label %20, label %100

20:                                               ; preds = %2
  %21 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %22 = load ptr, ptr %21, align 8
  %23 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %14) #13
  %24 = load ptr, ptr %23, align 8
  %25 = icmp ult ptr %22, %24
  br i1 %25, label %26, label %52

26:                                               ; preds = %20
  %27 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %14) #13
  %28 = load ptr, ptr %27, align 8
  %29 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %30 = load ptr, ptr %29, align 8
  %31 = ptrtoint ptr %28 to i64
  %32 = ptrtoint ptr %30 to i64
  %33 = sub i64 %31, %32
  %34 = sdiv exact i64 %33, 8
  store i64 %34, ptr %5, align 8
  %35 = load i64, ptr %5, align 8
  %36 = add nsw i64 %35, 1
  %37 = sdiv i64 %36, 2
  store i64 %37, ptr %5, align 8
  %38 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %39 = load ptr, ptr %38, align 8
  %40 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %41 = load ptr, ptr %40, align 8
  %42 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %43 = load ptr, ptr %42, align 8
  %44 = load i64, ptr %5, align 8
  %45 = getelementptr inbounds ptr, ptr %43, i64 %44
  %46 = call noundef ptr @_ZNSt3__113move_backwardB8ne190107IPPfS2_EET0_T_S4_S3_(ptr noundef %39, ptr noundef %41, ptr noundef %45)
  %47 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  store ptr %46, ptr %47, align 8
  %48 = load i64, ptr %5, align 8
  %49 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %50 = load ptr, ptr %49, align 8
  %51 = getelementptr inbounds ptr, ptr %50, i64 %48
  store ptr %51, ptr %49, align 8
  br label %99

52:                                               ; preds = %20
  %53 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %14) #13
  %54 = load ptr, ptr %53, align 8
  %55 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 0
  %56 = load ptr, ptr %55, align 8
  %57 = ptrtoint ptr %54 to i64
  %58 = ptrtoint ptr %56 to i64
  %59 = sub i64 %57, %58
  %60 = sdiv exact i64 %59, 8
  %61 = mul i64 2, %60
  store i64 %61, ptr %7, align 8
  store i64 1, ptr %8, align 8
  %62 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__13maxB8ne190107ImEERKT_S3_S3_(ptr noundef nonnull align 8 dereferenceable(8) %7, ptr noundef nonnull align 8 dereferenceable(8) %8)
  %63 = load i64, ptr %62, align 8
  store i64 %63, ptr %6, align 8
  %64 = load i64, ptr %6, align 8
  %65 = load i64, ptr %6, align 8
  %66 = add i64 %65, 3
  %67 = udiv i64 %66, 4
  %68 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %14) #13
  %69 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEEC1EmmS4_(ptr noundef nonnull align 8 dereferenceable(40) %9, i64 noundef %64, i64 noundef %67, ptr noundef nonnull align 1 dereferenceable(1) %68)
  %70 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %71 = load ptr, ptr %70, align 8
  %72 = invoke noundef ptr @_ZNSt3__113move_iteratorIPPfEC1B8ne190107ES2_(ptr noundef nonnull align 8 dereferenceable(8) %10, ptr noundef %71)
          to label %73 unwind label %94

73:                                               ; preds = %52
  %74 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %75 = load ptr, ptr %74, align 8
  %76 = invoke noundef ptr @_ZNSt3__113move_iteratorIPPfEC1B8ne190107ES2_(ptr noundef nonnull align 8 dereferenceable(8) %13, ptr noundef %75)
          to label %77 unwind label %94

77:                                               ; preds = %73
  %78 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %10, i32 0, i32 0
  %79 = load ptr, ptr %78, align 8
  %80 = ptrtoint ptr %79 to i64
  %81 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %13, i32 0, i32 0
  %82 = load ptr, ptr %81, align 8
  %83 = ptrtoint ptr %82 to i64
  invoke void @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE18__construct_at_endINS_13move_iteratorIPS1_EETnNS_9enable_ifIXsr31__has_forward_iterator_categoryIT_EE5valueEiE4typeELi0EEEvSB_SB_(ptr noundef nonnull align 8 dereferenceable(40) %9, i64 %80, i64 %83)
          to label %84 unwind label %94

84:                                               ; preds = %77
  %85 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 0
  %86 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %9, i32 0, i32 0
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %85, ptr noundef nonnull align 8 dereferenceable(8) %86) #13
  %87 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %88 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %9, i32 0, i32 1
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %87, ptr noundef nonnull align 8 dereferenceable(8) %88) #13
  %89 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 2
  %90 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %9, i32 0, i32 2
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %89, ptr noundef nonnull align 8 dereferenceable(8) %90) #13
  %91 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %14) #13
  %92 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %9) #13
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %91, ptr noundef nonnull align 8 dereferenceable(8) %92) #13
  %93 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEED1Ev(ptr noundef nonnull align 8 dereferenceable(40) %9) #13
  br label %99

94:                                               ; preds = %77, %73, %52
  %95 = landingpad { ptr, i32 }
          cleanup
  %96 = extractvalue { ptr, i32 } %95, 0
  store ptr %96, ptr %11, align 8
  %97 = extractvalue { ptr, i32 } %95, 1
  store i32 %97, ptr %12, align 4
  %98 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEED1Ev(ptr noundef nonnull align 8 dereferenceable(40) %9) #13
  br label %110

99:                                               ; preds = %84, %26
  br label %100

100:                                              ; preds = %99, %2
  %101 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %14) #13
  %102 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %103 = load ptr, ptr %102, align 8
  %104 = getelementptr inbounds ptr, ptr %103, i64 -1
  %105 = call noundef ptr @_ZNSt3__112__to_addressB8ne190107IPfEEPT_S3_(ptr noundef %104) #13
  %106 = load ptr, ptr %4, align 8
  call void @_ZNSt3__116allocator_traitsINS_9allocatorIPfEEE9constructB8ne190107IS2_JS2_ETnNS_9enable_ifIXsr15__has_constructIS3_PT_DpT0_EE5valueEiE4typeELi0EEEvRS3_S8_DpOS9_(ptr noundef nonnull align 1 dereferenceable(1) %101, ptr noundef %105, ptr noundef nonnull align 8 dereferenceable(8) %106)
  %107 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %14, i32 0, i32 1
  %108 = load ptr, ptr %107, align 8
  %109 = getelementptr inbounds ptr, ptr %108, i32 -1
  store ptr %109, ptr %107, align 8
  ret void

110:                                              ; preds = %94
  %111 = load ptr, ptr %11, align 8
  %112 = load i32, ptr %12, align 4
  %113 = insertvalue { ptr, i32 } poison, ptr %111, 0
  %114 = insertvalue { ptr, i32 } %113, i32 %112, 1
  resume { ptr, i32 } %114
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__13maxB8ne190107ImEERKT_S3_S3_(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca %"struct.std::__1::integral_constant.7", align 1
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %6 = load ptr, ptr %3, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__13maxB8ne190107ImNS_6__lessIvvEEEERKT_S5_S5_T0_(ptr noundef nonnull align 8 dereferenceable(8) %6, ptr noundef nonnull align 8 dereferenceable(8) %7)
  ret ptr %8
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEEC1EmmS4_(ptr noundef nonnull returned align 8 dereferenceable(40) %0, i64 noundef %1, i64 noundef %2, ptr noundef nonnull align 1 dereferenceable(1) %3) unnamed_addr #0 {
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca ptr, align 8
  store ptr %0, ptr %5, align 8
  store i64 %1, ptr %6, align 8
  store i64 %2, ptr %7, align 8
  store ptr %3, ptr %8, align 8
  %9 = load ptr, ptr %5, align 8
  %10 = load i64, ptr %6, align 8
  %11 = load i64, ptr %7, align 8
  %12 = load ptr, ptr %8, align 8
  %13 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEEC2EmmS4_(ptr noundef nonnull align 8 dereferenceable(40) %9, i64 noundef %10, i64 noundef %11, ptr noundef nonnull align 1 dereferenceable(1) %12)
  ret ptr %9
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__122__allocator_destructorINS_9allocatorIfEEEC1B8ne190107ERS2_m(ptr noundef nonnull returned align 8 dereferenceable(16) %0, ptr noundef nonnull align 1 dereferenceable(1) %1, i64 noundef %2) unnamed_addr #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i64 %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load i64, ptr %6, align 8
  %10 = call noundef ptr @_ZNSt3__122__allocator_destructorINS_9allocatorIfEEEC2B8ne190107ERS2_m(ptr noundef nonnull align 8 dereferenceable(16) %7, ptr noundef nonnull align 1 dereferenceable(1) %8, i64 noundef %9) #13
  ret ptr %7
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__110unique_ptrIPfNS_22__allocator_destructorINS_9allocatorIfEEEEEC1B8ne190107ILb1EvEES1_NS_16__dependent_typeINS_27__unique_ptr_deleter_sfinaeIS5_EEXT_EE20__good_rval_ref_typeE(ptr noundef nonnull returned align 8 dereferenceable(24) %0, ptr noundef %1, ptr noundef nonnull align 8 dereferenceable(16) %2) unnamed_addr #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = call noundef ptr @_ZNSt3__110unique_ptrIPfNS_22__allocator_destructorINS_9allocatorIfEEEEEC2B8ne190107ILb1EvEES1_NS_16__dependent_typeINS_27__unique_ptr_deleter_sfinaeIS5_EEXT_EE20__good_rval_ref_typeE(ptr noundef nonnull align 8 dereferenceable(24) %7, ptr noundef %8, ptr noundef nonnull align 8 dereferenceable(16) %9) #13
  ret ptr %7
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNKSt3__110unique_ptrIPfNS_22__allocator_destructorINS_9allocatorIfEEEEE3getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::unique_ptr", ptr %3, i32 0, i32 0
  %5 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__117__compressed_pairIPfNS_22__allocator_destructorINS_9allocatorIfEEEEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %4) #13
  %6 = load ptr, ptr %5, align 8
  ret ptr %6
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9push_backEOS1_(ptr noundef nonnull align 8 dereferenceable(40) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) #0 personality ptr @__gxx_personality_v0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca %"struct.std::__1::__split_buffer.8", align 8
  %10 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  %13 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %14 = load ptr, ptr %3, align 8
  %15 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 2
  %16 = load ptr, ptr %15, align 8
  %17 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %14) #13
  %18 = load ptr, ptr %17, align 8
  %19 = icmp eq ptr %16, %18
  br i1 %19, label %20, label %101

20:                                               ; preds = %2
  %21 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 1
  %22 = load ptr, ptr %21, align 8
  %23 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 0
  %24 = load ptr, ptr %23, align 8
  %25 = icmp ugt ptr %22, %24
  br i1 %25, label %26, label %54

26:                                               ; preds = %20
  %27 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 1
  %28 = load ptr, ptr %27, align 8
  %29 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 0
  %30 = load ptr, ptr %29, align 8
  %31 = ptrtoint ptr %28 to i64
  %32 = ptrtoint ptr %30 to i64
  %33 = sub i64 %31, %32
  %34 = sdiv exact i64 %33, 8
  store i64 %34, ptr %5, align 8
  %35 = load i64, ptr %5, align 8
  %36 = add nsw i64 %35, 1
  %37 = sdiv i64 %36, 2
  store i64 %37, ptr %5, align 8
  %38 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 1
  %39 = load ptr, ptr %38, align 8
  %40 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 2
  %41 = load ptr, ptr %40, align 8
  %42 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 1
  %43 = load ptr, ptr %42, align 8
  %44 = load i64, ptr %5, align 8
  %45 = sub i64 0, %44
  %46 = getelementptr inbounds ptr, ptr %43, i64 %45
  %47 = call noundef ptr @_ZNSt3__14moveB8ne190107IPPfS2_EET0_T_S4_S3_(ptr noundef %39, ptr noundef %41, ptr noundef %46)
  %48 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 2
  store ptr %47, ptr %48, align 8
  %49 = load i64, ptr %5, align 8
  %50 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 1
  %51 = load ptr, ptr %50, align 8
  %52 = sub i64 0, %49
  %53 = getelementptr inbounds ptr, ptr %51, i64 %52
  store ptr %53, ptr %50, align 8
  br label %100

54:                                               ; preds = %20
  %55 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %14) #13
  %56 = load ptr, ptr %55, align 8
  %57 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 0
  %58 = load ptr, ptr %57, align 8
  %59 = ptrtoint ptr %56 to i64
  %60 = ptrtoint ptr %58 to i64
  %61 = sub i64 %59, %60
  %62 = sdiv exact i64 %61, 8
  %63 = mul i64 2, %62
  store i64 %63, ptr %7, align 8
  store i64 1, ptr %8, align 8
  %64 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__13maxB8ne190107ImEERKT_S3_S3_(ptr noundef nonnull align 8 dereferenceable(8) %7, ptr noundef nonnull align 8 dereferenceable(8) %8)
  %65 = load i64, ptr %64, align 8
  store i64 %65, ptr %6, align 8
  %66 = load i64, ptr %6, align 8
  %67 = load i64, ptr %6, align 8
  %68 = udiv i64 %67, 4
  %69 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %14) #13
  %70 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEEC1EmmS4_(ptr noundef nonnull align 8 dereferenceable(40) %9, i64 noundef %66, i64 noundef %68, ptr noundef nonnull align 1 dereferenceable(1) %69)
  %71 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 1
  %72 = load ptr, ptr %71, align 8
  %73 = invoke noundef ptr @_ZNSt3__113move_iteratorIPPfEC1B8ne190107ES2_(ptr noundef nonnull align 8 dereferenceable(8) %10, ptr noundef %72)
          to label %74 unwind label %95

74:                                               ; preds = %54
  %75 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 2
  %76 = load ptr, ptr %75, align 8
  %77 = invoke noundef ptr @_ZNSt3__113move_iteratorIPPfEC1B8ne190107ES2_(ptr noundef nonnull align 8 dereferenceable(8) %13, ptr noundef %76)
          to label %78 unwind label %95

78:                                               ; preds = %74
  %79 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %10, i32 0, i32 0
  %80 = load ptr, ptr %79, align 8
  %81 = ptrtoint ptr %80 to i64
  %82 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %13, i32 0, i32 0
  %83 = load ptr, ptr %82, align 8
  %84 = ptrtoint ptr %83 to i64
  invoke void @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE18__construct_at_endINS_13move_iteratorIPS1_EETnNS_9enable_ifIXsr31__has_forward_iterator_categoryIT_EE5valueEiE4typeELi0EEEvSB_SB_(ptr noundef nonnull align 8 dereferenceable(40) %9, i64 %81, i64 %84)
          to label %85 unwind label %95

85:                                               ; preds = %78
  %86 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 0
  %87 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %9, i32 0, i32 0
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %86, ptr noundef nonnull align 8 dereferenceable(8) %87) #13
  %88 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 1
  %89 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %9, i32 0, i32 1
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %88, ptr noundef nonnull align 8 dereferenceable(8) %89) #13
  %90 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 2
  %91 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %9, i32 0, i32 2
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %90, ptr noundef nonnull align 8 dereferenceable(8) %91) #13
  %92 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %14) #13
  %93 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %9) #13
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %92, ptr noundef nonnull align 8 dereferenceable(8) %93) #13
  %94 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEED1Ev(ptr noundef nonnull align 8 dereferenceable(40) %9) #13
  br label %100

95:                                               ; preds = %78, %74, %54
  %96 = landingpad { ptr, i32 }
          cleanup
  %97 = extractvalue { ptr, i32 } %96, 0
  store ptr %97, ptr %11, align 8
  %98 = extractvalue { ptr, i32 } %96, 1
  store i32 %98, ptr %12, align 4
  %99 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEED1Ev(ptr noundef nonnull align 8 dereferenceable(40) %9) #13
  br label %110

100:                                              ; preds = %85, %26
  br label %101

101:                                              ; preds = %100, %2
  %102 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %14) #13
  %103 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 2
  %104 = load ptr, ptr %103, align 8
  %105 = call noundef ptr @_ZNSt3__112__to_addressB8ne190107IPfEEPT_S3_(ptr noundef %104) #13
  %106 = load ptr, ptr %4, align 8
  call void @_ZNSt3__116allocator_traitsINS_9allocatorIPfEEE9constructB8ne190107IS2_JS2_ETnNS_9enable_ifIXsr15__has_constructIS3_PT_DpT0_EE5valueEiE4typeELi0EEEvRS3_S8_DpOS9_(ptr noundef nonnull align 1 dereferenceable(1) %102, ptr noundef %105, ptr noundef nonnull align 8 dereferenceable(8) %106)
  %107 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 2
  %108 = load ptr, ptr %107, align 8
  %109 = getelementptr inbounds ptr, ptr %108, i32 1
  store ptr %109, ptr %107, align 8
  ret void

110:                                              ; preds = %95
  %111 = load ptr, ptr %11, align 8
  %112 = load i32, ptr %12, align 4
  %113 = insertvalue { ptr, i32 } poison, ptr %111, 0
  %114 = insertvalue { ptr, i32 } %113, i32 %112, 1
  resume { ptr, i32 } %114
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__110unique_ptrIPfNS_22__allocator_destructorINS_9allocatorIfEEEEE7releaseB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %0) #1 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  %5 = getelementptr inbounds %"class.std::__1::unique_ptr", ptr %4, i32 0, i32 0
  %6 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__117__compressed_pairIPfNS_22__allocator_destructorINS_9allocatorIfEEEEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %5) #13
  %7 = load ptr, ptr %6, align 8
  store ptr %7, ptr %3, align 8
  %8 = getelementptr inbounds %"class.std::__1::unique_ptr", ptr %4, i32 0, i32 0
  %9 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__117__compressed_pairIPfNS_22__allocator_destructorINS_9allocatorIfEEEEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %8) #13
  store ptr null, ptr %9, align 8
  %10 = load ptr, ptr %3, align 8
  ret ptr %10
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE10push_frontERKS1_(ptr noundef nonnull align 8 dereferenceable(40) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) #0 personality ptr @__gxx_personality_v0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca %"struct.std::__1::__split_buffer.8", align 8
  %10 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  %13 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %14 = load ptr, ptr %3, align 8
  %15 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 1
  %16 = load ptr, ptr %15, align 8
  %17 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 0
  %18 = load ptr, ptr %17, align 8
  %19 = icmp eq ptr %16, %18
  br i1 %19, label %20, label %100

20:                                               ; preds = %2
  %21 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 2
  %22 = load ptr, ptr %21, align 8
  %23 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %14) #13
  %24 = load ptr, ptr %23, align 8
  %25 = icmp ult ptr %22, %24
  br i1 %25, label %26, label %52

26:                                               ; preds = %20
  %27 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %14) #13
  %28 = load ptr, ptr %27, align 8
  %29 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 2
  %30 = load ptr, ptr %29, align 8
  %31 = ptrtoint ptr %28 to i64
  %32 = ptrtoint ptr %30 to i64
  %33 = sub i64 %31, %32
  %34 = sdiv exact i64 %33, 8
  store i64 %34, ptr %5, align 8
  %35 = load i64, ptr %5, align 8
  %36 = add nsw i64 %35, 1
  %37 = sdiv i64 %36, 2
  store i64 %37, ptr %5, align 8
  %38 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 1
  %39 = load ptr, ptr %38, align 8
  %40 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 2
  %41 = load ptr, ptr %40, align 8
  %42 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 2
  %43 = load ptr, ptr %42, align 8
  %44 = load i64, ptr %5, align 8
  %45 = getelementptr inbounds ptr, ptr %43, i64 %44
  %46 = call noundef ptr @_ZNSt3__113move_backwardB8ne190107IPPfS2_EET0_T_S4_S3_(ptr noundef %39, ptr noundef %41, ptr noundef %45)
  %47 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 1
  store ptr %46, ptr %47, align 8
  %48 = load i64, ptr %5, align 8
  %49 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 2
  %50 = load ptr, ptr %49, align 8
  %51 = getelementptr inbounds ptr, ptr %50, i64 %48
  store ptr %51, ptr %49, align 8
  br label %99

52:                                               ; preds = %20
  %53 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %14) #13
  %54 = load ptr, ptr %53, align 8
  %55 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 0
  %56 = load ptr, ptr %55, align 8
  %57 = ptrtoint ptr %54 to i64
  %58 = ptrtoint ptr %56 to i64
  %59 = sub i64 %57, %58
  %60 = sdiv exact i64 %59, 8
  %61 = mul i64 2, %60
  store i64 %61, ptr %7, align 8
  store i64 1, ptr %8, align 8
  %62 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__13maxB8ne190107ImEERKT_S3_S3_(ptr noundef nonnull align 8 dereferenceable(8) %7, ptr noundef nonnull align 8 dereferenceable(8) %8)
  %63 = load i64, ptr %62, align 8
  store i64 %63, ptr %6, align 8
  %64 = load i64, ptr %6, align 8
  %65 = load i64, ptr %6, align 8
  %66 = add i64 %65, 3
  %67 = udiv i64 %66, 4
  %68 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %14) #13
  %69 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEEC1EmmS4_(ptr noundef nonnull align 8 dereferenceable(40) %9, i64 noundef %64, i64 noundef %67, ptr noundef nonnull align 1 dereferenceable(1) %68)
  %70 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 1
  %71 = load ptr, ptr %70, align 8
  %72 = invoke noundef ptr @_ZNSt3__113move_iteratorIPPfEC1B8ne190107ES2_(ptr noundef nonnull align 8 dereferenceable(8) %10, ptr noundef %71)
          to label %73 unwind label %94

73:                                               ; preds = %52
  %74 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 2
  %75 = load ptr, ptr %74, align 8
  %76 = invoke noundef ptr @_ZNSt3__113move_iteratorIPPfEC1B8ne190107ES2_(ptr noundef nonnull align 8 dereferenceable(8) %13, ptr noundef %75)
          to label %77 unwind label %94

77:                                               ; preds = %73
  %78 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %10, i32 0, i32 0
  %79 = load ptr, ptr %78, align 8
  %80 = ptrtoint ptr %79 to i64
  %81 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %13, i32 0, i32 0
  %82 = load ptr, ptr %81, align 8
  %83 = ptrtoint ptr %82 to i64
  invoke void @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE18__construct_at_endINS_13move_iteratorIPS1_EETnNS_9enable_ifIXsr31__has_forward_iterator_categoryIT_EE5valueEiE4typeELi0EEEvSB_SB_(ptr noundef nonnull align 8 dereferenceable(40) %9, i64 %80, i64 %83)
          to label %84 unwind label %94

84:                                               ; preds = %77
  %85 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 0
  %86 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %9, i32 0, i32 0
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %85, ptr noundef nonnull align 8 dereferenceable(8) %86) #13
  %87 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 1
  %88 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %9, i32 0, i32 1
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %87, ptr noundef nonnull align 8 dereferenceable(8) %88) #13
  %89 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 2
  %90 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %9, i32 0, i32 2
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %89, ptr noundef nonnull align 8 dereferenceable(8) %90) #13
  %91 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %14) #13
  %92 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %9) #13
  call void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %91, ptr noundef nonnull align 8 dereferenceable(8) %92) #13
  %93 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEED1Ev(ptr noundef nonnull align 8 dereferenceable(40) %9) #13
  br label %99

94:                                               ; preds = %77, %73, %52
  %95 = landingpad { ptr, i32 }
          cleanup
  %96 = extractvalue { ptr, i32 } %95, 0
  store ptr %96, ptr %11, align 8
  %97 = extractvalue { ptr, i32 } %95, 1
  store i32 %97, ptr %12, align 4
  %98 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEED1Ev(ptr noundef nonnull align 8 dereferenceable(40) %9) #13
  br label %110

99:                                               ; preds = %84, %26
  br label %100

100:                                              ; preds = %99, %2
  %101 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %14) #13
  %102 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 1
  %103 = load ptr, ptr %102, align 8
  %104 = getelementptr inbounds ptr, ptr %103, i64 -1
  %105 = call noundef ptr @_ZNSt3__112__to_addressB8ne190107IPfEEPT_S3_(ptr noundef %104) #13
  %106 = load ptr, ptr %4, align 8
  call void @_ZNSt3__116allocator_traitsINS_9allocatorIPfEEE9constructB8ne190107IS2_JRKS2_ETnNS_9enable_ifIXsr15__has_constructIS3_PT_DpT0_EE5valueEiE4typeELi0EEEvRS3_SA_DpOSB_(ptr noundef nonnull align 1 dereferenceable(1) %101, ptr noundef %105, ptr noundef nonnull align 8 dereferenceable(8) %106)
  %107 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %14, i32 0, i32 1
  %108 = load ptr, ptr %107, align 8
  %109 = getelementptr inbounds ptr, ptr %108, i32 -1
  store ptr %109, ptr %107, align 8
  ret void

110:                                              ; preds = %94
  %111 = load ptr, ptr %11, align 8
  %112 = load i32, ptr %12, align 4
  %113 = insertvalue { ptr, i32 } poison, ptr %111, 0
  %114 = insertvalue { ptr, i32 } %113, i32 %112, 1
  resume { ptr, i32 } %114
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__110unique_ptrIPfNS_22__allocator_destructorINS_9allocatorIfEEEEED1B8ne190107Ev(ptr noundef nonnull returned align 8 dereferenceable(24) %0) unnamed_addr #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZNSt3__110unique_ptrIPfNS_22__allocator_destructorINS_9allocatorIfEEEEED2B8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %3) #13
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__14swapB8ne190107IPPfEENS_9enable_ifIXaasr21is_move_constructibleIT_EE5valuesr18is_move_assignableIS4_EE5valueEvE4typeERS4_S7_(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) #1 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %6 = load ptr, ptr %3, align 8
  %7 = load ptr, ptr %6, align 8
  store ptr %7, ptr %5, align 8
  %8 = load ptr, ptr %4, align 8
  %9 = load ptr, ptr %8, align 8
  %10 = load ptr, ptr %3, align 8
  store ptr %9, ptr %10, align 8
  %11 = load ptr, ptr %5, align 8
  %12 = load ptr, ptr %4, align 8
  store ptr %11, ptr %12, align 8
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__split_buffer", ptr %3, i32 0, i32 3
  %5 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__117__compressed_pairIPPfNS_9allocatorIS1_EEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #13
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %3, i32 0, i32 3
  %5 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__117__compressed_pairIPPfRNS_9allocatorIS1_EEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(16) %4) #13
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEED1Ev(ptr noundef nonnull returned align 8 dereferenceable(40) %0) unnamed_addr #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEED2Ev(ptr noundef nonnull align 8 dereferenceable(40) %3) #13
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEED2Ev(ptr noundef nonnull returned align 8 dereferenceable(40) %0) unnamed_addr #1 personality ptr @__gxx_personality_v0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  store ptr %4, ptr %2, align 8
  call void @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE5clearB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %4) #13
  %5 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %4, i32 0, i32 0
  %6 = load ptr, ptr %5, align 8
  %7 = icmp ne ptr %6, null
  br i1 %7, label %8, label %14

8:                                                ; preds = %1
  %9 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %4) #13
  %10 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %4, i32 0, i32 0
  %11 = load ptr, ptr %10, align 8
  %12 = invoke noundef i64 @_ZNKSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE8capacityB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %4)
          to label %13 unwind label %16

13:                                               ; preds = %8
  call void @_ZNSt3__116allocator_traitsINS_9allocatorIPfEEE10deallocateB8ne190107ERS3_PS2_m(ptr noundef nonnull align 1 dereferenceable(1) %9, ptr noundef %11, i64 noundef %12) #13
  br label %14

14:                                               ; preds = %13, %1
  %15 = load ptr, ptr %2, align 8
  ret ptr %15

16:                                               ; preds = %8
  %17 = landingpad { ptr, i32 }
          catch ptr null
  %18 = extractvalue { ptr, i32 } %17, 0
  call void @__clang_call_terminate(ptr %18) #14
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE5clearB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %3, i32 0, i32 1
  %5 = load ptr, ptr %4, align 8
  call void @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE17__destruct_at_endB8ne190107EPS1_(ptr noundef nonnull align 8 dereferenceable(40) %3, ptr noundef %5) #13
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %3, i32 0, i32 3
  %5 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__117__compressed_pairIPPfRNS_9allocatorIS1_EEE6secondB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(16) %4) #13
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef i64 @_ZNKSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE8capacityB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %3) #13
  %5 = load ptr, ptr %4, align 8
  %6 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %3, i32 0, i32 0
  %7 = load ptr, ptr %6, align 8
  %8 = ptrtoint ptr %5 to i64
  %9 = ptrtoint ptr %7 to i64
  %10 = sub i64 %8, %9
  %11 = sdiv exact i64 %10, 8
  ret i64 %11
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %3, i32 0, i32 3
  %5 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__117__compressed_pairIPPfRNS_9allocatorIS1_EEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(16) %4) #13
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__117__compressed_pairIPPfRNS_9allocatorIS1_EEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(16) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__122__compressed_pair_elemIPPfLi0ELb0EE5__getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__117__compressed_pairIPPfRNS_9allocatorIS1_EEE6secondB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(16) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds i8, ptr %3, i64 8
  %5 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__122__compressed_pair_elemIRNS_9allocatorIPfEELi1ELb0EE5__getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #13
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__122__compressed_pair_elemIRNS_9allocatorIPfEELi1ELb0EE5__getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %3, i32 0, i32 0
  %5 = load ptr, ptr %4, align 8
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE17__destruct_at_endB8ne190107EPS1_(ptr noundef nonnull align 8 dereferenceable(40) %0, ptr noundef %1) #1 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca %"struct.std::__1::integral_constant.7", align 1
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %6 = load ptr, ptr %3, align 8
  %7 = load ptr, ptr %4, align 8
  call void @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE17__destruct_at_endB8ne190107EPS1_NS_17integral_constantIbLb0EEE(ptr noundef nonnull align 8 dereferenceable(40) %6, ptr noundef %7) #13
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE17__destruct_at_endB8ne190107EPS1_NS_17integral_constantIbLb0EEE(ptr noundef nonnull align 8 dereferenceable(40) %0, ptr noundef %1) #1 personality ptr @__gxx_personality_v0 {
  %3 = alloca %"struct.std::__1::integral_constant.7", align 1
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %6 = load ptr, ptr %4, align 8
  br label %7

7:                                                ; preds = %18, %2
  %8 = load ptr, ptr %5, align 8
  %9 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %6, i32 0, i32 2
  %10 = load ptr, ptr %9, align 8
  %11 = icmp ne ptr %8, %10
  br i1 %11, label %12, label %19

12:                                               ; preds = %7
  %13 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %6) #13
  %14 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %6, i32 0, i32 2
  %15 = load ptr, ptr %14, align 8
  %16 = getelementptr inbounds ptr, ptr %15, i32 -1
  store ptr %16, ptr %14, align 8
  %17 = call noundef ptr @_ZNSt3__112__to_addressB8ne190107IPfEEPT_S3_(ptr noundef %16) #13
  invoke void @_ZNSt3__116allocator_traitsINS_9allocatorIPfEEE7destroyB8ne190107IS2_TnNS_9enable_ifIXsr13__has_destroyIS3_PT_EE5valueEiE4typeELi0EEEvRS3_S8_(ptr noundef nonnull align 1 dereferenceable(1) %13, ptr noundef %17)
          to label %18 unwind label %20

18:                                               ; preds = %12
  br label %7, !llvm.loop !13

19:                                               ; preds = %7
  ret void

20:                                               ; preds = %12
  %21 = landingpad { ptr, i32 }
          catch ptr null
  %22 = extractvalue { ptr, i32 } %21, 0
  call void @__clang_call_terminate(ptr %22) #14
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__117__compressed_pairIPPfRNS_9allocatorIS1_EEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(16) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__122__compressed_pair_elemIPPfLi0ELb0EE5__getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__122__compressed_pair_elemIPPfLi0ELb0EE5__getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %3, i32 0, i32 0
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__117__compressed_pairIPPfNS_9allocatorIS1_EEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__122__compressed_pair_elemIPPfLi0ELb0EE5__getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__110unique_ptrIPfNS_22__allocator_destructorINS_9allocatorIfEEEEED2B8ne190107Ev(ptr noundef nonnull returned align 8 dereferenceable(24) %0) unnamed_addr #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  call void @_ZNSt3__110unique_ptrIPfNS_22__allocator_destructorINS_9allocatorIfEEEEE5resetB8ne190107ES1_(ptr noundef nonnull align 8 dereferenceable(24) %3, ptr noundef null) #13
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__110unique_ptrIPfNS_22__allocator_destructorINS_9allocatorIfEEEEE5resetB8ne190107ES1_(ptr noundef nonnull align 8 dereferenceable(24) %0, ptr noundef %1) #1 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %6 = load ptr, ptr %3, align 8
  %7 = getelementptr inbounds %"class.std::__1::unique_ptr", ptr %6, i32 0, i32 0
  %8 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__117__compressed_pairIPfNS_22__allocator_destructorINS_9allocatorIfEEEEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %7) #13
  %9 = load ptr, ptr %8, align 8
  store ptr %9, ptr %5, align 8
  %10 = load ptr, ptr %4, align 8
  %11 = getelementptr inbounds %"class.std::__1::unique_ptr", ptr %6, i32 0, i32 0
  %12 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__117__compressed_pairIPfNS_22__allocator_destructorINS_9allocatorIfEEEEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %11) #13
  store ptr %10, ptr %12, align 8
  %13 = load ptr, ptr %5, align 8
  %14 = icmp ne ptr %13, null
  br i1 %14, label %15, label %19

15:                                               ; preds = %2
  %16 = getelementptr inbounds %"class.std::__1::unique_ptr", ptr %6, i32 0, i32 0
  %17 = call noundef nonnull align 8 dereferenceable(16) ptr @_ZNSt3__117__compressed_pairIPfNS_22__allocator_destructorINS_9allocatorIfEEEEE6secondB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %16) #13
  %18 = load ptr, ptr %5, align 8
  call void @_ZNSt3__122__allocator_destructorINS_9allocatorIfEEEclB8ne190107EPf(ptr noundef nonnull align 8 dereferenceable(16) %17, ptr noundef %18) #13
  br label %19

19:                                               ; preds = %15, %2
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__117__compressed_pairIPfNS_22__allocator_destructorINS_9allocatorIfEEEEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__122__compressed_pair_elemIPfLi0ELb0EE5__getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(16) ptr @_ZNSt3__117__compressed_pairIPfNS_22__allocator_destructorINS_9allocatorIfEEEEE6secondB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds i8, ptr %3, i64 8
  %5 = call noundef nonnull align 8 dereferenceable(16) ptr @_ZNSt3__122__compressed_pair_elemINS_22__allocator_destructorINS_9allocatorIfEEEELi1ELb0EE5__getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(16) %4) #13
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__122__allocator_destructorINS_9allocatorIfEEEclB8ne190107EPf(ptr noundef nonnull align 8 dereferenceable(16) %0, ptr noundef %1) #1 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %"class.std::__1::__allocator_destructor", ptr %5, i32 0, i32 0
  %7 = load ptr, ptr %6, align 8
  %8 = load ptr, ptr %4, align 8
  %9 = getelementptr inbounds %"class.std::__1::__allocator_destructor", ptr %5, i32 0, i32 1
  %10 = load i64, ptr %9, align 8
  call void @_ZNSt3__116allocator_traitsINS_9allocatorIfEEE10deallocateB8ne190107ERS2_Pfm(ptr noundef nonnull align 1 dereferenceable(1) %7, ptr noundef %8, i64 noundef %10) #13
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(16) ptr @_ZNSt3__122__compressed_pair_elemINS_22__allocator_destructorINS_9allocatorIfEEEELi1ELb0EE5__getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(16) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem.13", ptr %3, i32 0, i32 0
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__122__compressed_pair_elemIPfLi0ELb0EE5__getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %3, i32 0, i32 0
  ret ptr %4
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__113move_backwardB8ne190107IPPfS2_EET0_T_S4_S3_(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca %"class.std::__1::__deque_iterator", align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %8 = load ptr, ptr %4, align 8
  %9 = load ptr, ptr %5, align 8
  %10 = load ptr, ptr %6, align 8
  %11 = call [2 x i64] @_ZNSt3__115__move_backwardB8ne190107INS_17_ClassicAlgPolicyEPPfS3_S3_EENS_4pairIT0_T2_EES5_T1_S6_(ptr noundef %8, ptr noundef %9, ptr noundef %10)
  store [2 x i64] %11, ptr %7, align 8
  %12 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %7, i32 0, i32 1
  %13 = load ptr, ptr %12, align 8
  ret ptr %13
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__113move_iteratorIPPfEC1B8ne190107ES2_(ptr noundef nonnull returned align 8 dereferenceable(8) %0, ptr noundef %1) unnamed_addr #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = call noundef ptr @_ZNSt3__113move_iteratorIPPfEC2B8ne190107ES2_(ptr noundef nonnull align 8 dereferenceable(8) %5, ptr noundef %6)
  ret ptr %5
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr void @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE18__construct_at_endINS_13move_iteratorIPS1_EETnNS_9enable_ifIXsr31__has_forward_iterator_categoryIT_EE5valueEiE4typeELi0EEEvSB_SB_(ptr noundef nonnull align 8 dereferenceable(40) %0, i64 %1, i64 %2) #0 {
  %4 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  %5 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  %6 = alloca ptr, align 8
  %7 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  %8 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  %9 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  %10 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %4, i32 0, i32 0
  %11 = inttoptr i64 %1 to ptr
  store ptr %11, ptr %10, align 8
  %12 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %5, i32 0, i32 0
  %13 = inttoptr i64 %2 to ptr
  store ptr %13, ptr %12, align 8
  store ptr %0, ptr %6, align 8
  %14 = load ptr, ptr %6, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %7, ptr align 8 %4, i64 8, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %8, ptr align 8 %4, i64 8, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %9, ptr align 8 %5, i64 8, i1 false)
  %15 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %8, i32 0, i32 0
  %16 = load ptr, ptr %15, align 8
  %17 = ptrtoint ptr %16 to i64
  %18 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %9, i32 0, i32 0
  %19 = load ptr, ptr %18, align 8
  %20 = ptrtoint ptr %19 to i64
  %21 = call noundef i64 @_ZNSt3__18distanceB8ne190107INS_13move_iteratorIPPfEEEENS_15iterator_traitsIT_E15difference_typeES6_S6_(i64 %17, i64 %20)
  %22 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %7, i32 0, i32 0
  %23 = load ptr, ptr %22, align 8
  %24 = ptrtoint ptr %23 to i64
  call void @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE28__construct_at_end_with_sizeINS_13move_iteratorIPS1_EEEEvT_m(ptr noundef nonnull align 8 dereferenceable(40) %14, i64 %24, i64 noundef %21)
  ret void
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr void @_ZNSt3__116allocator_traitsINS_9allocatorIPfEEE9constructB8ne190107IS2_JRKS2_ETnNS_9enable_ifIXsr15__has_constructIS3_PT_DpT0_EE5valueEiE4typeELi0EEEvRS3_SA_DpOSB_(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1, ptr noundef nonnull align 8 dereferenceable(8) %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  call void @_ZNSt3__19allocatorIPfE9constructB8ne190107IS1_JRKS1_EEEvPT_DpOT0_(ptr noundef nonnull align 1 dereferenceable(1) %7, ptr noundef %8, ptr noundef nonnull align 8 dereferenceable(8) %9)
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr void @_ZNSt3__19allocatorIPfE9constructB8ne190107IS1_JRKS1_EEEvPT_DpOT0_(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1, ptr noundef nonnull align 8 dereferenceable(8) %2) #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = load ptr, ptr %9, align 8
  store ptr %10, ptr %8, align 8
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #8

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef i64 @_ZNSt3__18distanceB8ne190107INS_13move_iteratorIPPfEEEENS_15iterator_traitsIT_E15difference_typeES6_S6_(i64 %0, i64 %1) #0 {
  %3 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  %4 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  %5 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  %6 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  %7 = alloca %"struct.std::__1::integral_constant.7", align 1
  %8 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %3, i32 0, i32 0
  %9 = inttoptr i64 %0 to ptr
  store ptr %9, ptr %8, align 8
  %10 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %4, i32 0, i32 0
  %11 = inttoptr i64 %1 to ptr
  store ptr %11, ptr %10, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %5, ptr align 8 %3, i64 8, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %6, ptr align 8 %4, i64 8, i1 false)
  %12 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %5, i32 0, i32 0
  %13 = load ptr, ptr %12, align 8
  %14 = ptrtoint ptr %13 to i64
  %15 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %6, i32 0, i32 0
  %16 = load ptr, ptr %15, align 8
  %17 = ptrtoint ptr %16 to i64
  %18 = call noundef i64 @_ZNSt3__110__distanceB8ne190107INS_13move_iteratorIPPfEEEENS_15iterator_traitsIT_E15difference_typeES6_S6_NS_26random_access_iterator_tagE(i64 %14, i64 %17)
  ret i64 %18
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr void @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE28__construct_at_end_with_sizeINS_13move_iteratorIPS1_EEEEvT_m(ptr noundef nonnull align 8 dereferenceable(40) %0, i64 %1, i64 noundef %2) #0 personality ptr @__gxx_personality_v0 {
  %4 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  %7 = alloca %"struct.std::__1::__split_buffer<float *, std::__1::allocator<float *> &>::_ConstructTransaction", align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %4, i32 0, i32 0
  %11 = inttoptr i64 %1 to ptr
  store ptr %11, ptr %10, align 8
  store ptr %0, ptr %5, align 8
  store i64 %2, ptr %6, align 8
  %12 = load ptr, ptr %5, align 8
  %13 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %12, i32 0, i32 2
  %14 = load i64, ptr %6, align 8
  %15 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE21_ConstructTransactionC1B8ne190107EPPS1_m(ptr noundef nonnull align 8 dereferenceable(24) %7, ptr noundef %13, i64 noundef %14) #13
  br label %16

16:                                               ; preds = %35, %3
  %17 = getelementptr inbounds %"struct.std::__1::__split_buffer<float *, std::__1::allocator<float *> &>::_ConstructTransaction", ptr %7, i32 0, i32 0
  %18 = load ptr, ptr %17, align 8
  %19 = getelementptr inbounds %"struct.std::__1::__split_buffer<float *, std::__1::allocator<float *> &>::_ConstructTransaction", ptr %7, i32 0, i32 1
  %20 = load ptr, ptr %19, align 8
  %21 = icmp ne ptr %18, %20
  br i1 %21, label %22, label %41

22:                                               ; preds = %16
  %23 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %12) #13
  %24 = getelementptr inbounds %"struct.std::__1::__split_buffer<float *, std::__1::allocator<float *> &>::_ConstructTransaction", ptr %7, i32 0, i32 0
  %25 = load ptr, ptr %24, align 8
  %26 = call noundef ptr @_ZNSt3__112__to_addressB8ne190107IPfEEPT_S3_(ptr noundef %25) #13
  %27 = invoke noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__113move_iteratorIPPfEdeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %4)
          to label %28 unwind label %36

28:                                               ; preds = %22
  invoke void @_ZNSt3__116allocator_traitsINS_9allocatorIPfEEE9constructB8ne190107IS2_JS2_ETnNS_9enable_ifIXsr15__has_constructIS3_PT_DpT0_EE5valueEiE4typeELi0EEEvRS3_S8_DpOS9_(ptr noundef nonnull align 1 dereferenceable(1) %23, ptr noundef %26, ptr noundef nonnull align 8 dereferenceable(8) %27)
          to label %29 unwind label %36

29:                                               ; preds = %28
  br label %30

30:                                               ; preds = %29
  %31 = getelementptr inbounds %"struct.std::__1::__split_buffer<float *, std::__1::allocator<float *> &>::_ConstructTransaction", ptr %7, i32 0, i32 0
  %32 = load ptr, ptr %31, align 8
  %33 = getelementptr inbounds ptr, ptr %32, i32 1
  store ptr %33, ptr %31, align 8
  %34 = invoke noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__113move_iteratorIPPfEppB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %4)
          to label %35 unwind label %36

35:                                               ; preds = %30
  br label %16, !llvm.loop !14

36:                                               ; preds = %30, %28, %22
  %37 = landingpad { ptr, i32 }
          cleanup
  %38 = extractvalue { ptr, i32 } %37, 0
  store ptr %38, ptr %8, align 8
  %39 = extractvalue { ptr, i32 } %37, 1
  store i32 %39, ptr %9, align 4
  %40 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE21_ConstructTransactionD1B8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %7) #13
  br label %43

41:                                               ; preds = %16
  %42 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE21_ConstructTransactionD1B8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %7) #13
  ret void

43:                                               ; preds = %36
  %44 = load ptr, ptr %8, align 8
  %45 = load i32, ptr %9, align 4
  %46 = insertvalue { ptr, i32 } poison, ptr %44, 0
  %47 = insertvalue { ptr, i32 } %46, i32 %45, 1
  resume { ptr, i32 } %47
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE21_ConstructTransactionC1B8ne190107EPPS1_m(ptr noundef nonnull returned align 8 dereferenceable(24) %0, ptr noundef %1, i64 noundef %2) unnamed_addr #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i64 %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load i64, ptr %6, align 8
  %10 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE21_ConstructTransactionC2B8ne190107EPPS1_m(ptr noundef nonnull align 8 dereferenceable(24) %7, ptr noundef %8, i64 noundef %9) #13
  ret ptr %7
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__113move_iteratorIPPfEdeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %3, i32 0, i32 0
  %5 = load ptr, ptr %4, align 8
  ret ptr %5
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr void @_ZNSt3__116allocator_traitsINS_9allocatorIPfEEE9constructB8ne190107IS2_JS2_ETnNS_9enable_ifIXsr15__has_constructIS3_PT_DpT0_EE5valueEiE4typeELi0EEEvRS3_S8_DpOS9_(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1, ptr noundef nonnull align 8 dereferenceable(8) %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  call void @_ZNSt3__19allocatorIPfE9constructB8ne190107IS1_JS1_EEEvPT_DpOT0_(ptr noundef nonnull align 1 dereferenceable(1) %7, ptr noundef %8, ptr noundef nonnull align 8 dereferenceable(8) %9)
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__113move_iteratorIPPfEppB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %3, i32 0, i32 0
  %5 = load ptr, ptr %4, align 8
  %6 = getelementptr inbounds ptr, ptr %5, i32 1
  store ptr %6, ptr %4, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE21_ConstructTransactionD1B8ne190107Ev(ptr noundef nonnull returned align 8 dereferenceable(24) %0) unnamed_addr #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE21_ConstructTransactionD2B8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %3) #13
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE21_ConstructTransactionD2B8ne190107Ev(ptr noundef nonnull returned align 8 dereferenceable(24) %0) unnamed_addr #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__split_buffer<float *, std::__1::allocator<float *> &>::_ConstructTransaction", ptr %3, i32 0, i32 0
  %5 = load ptr, ptr %4, align 8
  %6 = getelementptr inbounds %"struct.std::__1::__split_buffer<float *, std::__1::allocator<float *> &>::_ConstructTransaction", ptr %3, i32 0, i32 2
  %7 = load ptr, ptr %6, align 8
  store ptr %5, ptr %7, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr void @_ZNSt3__19allocatorIPfE9constructB8ne190107IS1_JS1_EEEvPT_DpOT0_(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1, ptr noundef nonnull align 8 dereferenceable(8) %2) #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = load ptr, ptr %9, align 8
  store ptr %10, ptr %8, align 8
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE21_ConstructTransactionC2B8ne190107EPPS1_m(ptr noundef nonnull returned align 8 dereferenceable(24) %0, ptr noundef %1, i64 noundef %2) unnamed_addr #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i64 %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = getelementptr inbounds %"struct.std::__1::__split_buffer<float *, std::__1::allocator<float *> &>::_ConstructTransaction", ptr %7, i32 0, i32 0
  %9 = load ptr, ptr %5, align 8
  %10 = load ptr, ptr %9, align 8
  store ptr %10, ptr %8, align 8
  %11 = getelementptr inbounds %"struct.std::__1::__split_buffer<float *, std::__1::allocator<float *> &>::_ConstructTransaction", ptr %7, i32 0, i32 1
  %12 = load ptr, ptr %5, align 8
  %13 = load ptr, ptr %12, align 8
  %14 = load i64, ptr %6, align 8
  %15 = getelementptr inbounds ptr, ptr %13, i64 %14
  store ptr %15, ptr %11, align 8
  %16 = getelementptr inbounds %"struct.std::__1::__split_buffer<float *, std::__1::allocator<float *> &>::_ConstructTransaction", ptr %7, i32 0, i32 2
  %17 = load ptr, ptr %5, align 8
  store ptr %17, ptr %16, align 8
  ret ptr %7
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef i64 @_ZNSt3__110__distanceB8ne190107INS_13move_iteratorIPPfEEEENS_15iterator_traitsIT_E15difference_typeES6_S6_NS_26random_access_iterator_tagE(i64 %0, i64 %1) #0 {
  %3 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  %4 = alloca %"struct.std::__1::__compressed_pair_elem", align 8
  %5 = alloca %"struct.std::__1::integral_constant.7", align 1
  %6 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %3, i32 0, i32 0
  %7 = inttoptr i64 %0 to ptr
  store ptr %7, ptr %6, align 8
  %8 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %4, i32 0, i32 0
  %9 = inttoptr i64 %1 to ptr
  store ptr %9, ptr %8, align 8
  %10 = call noundef i64 @_ZNSt3__1miB8ne190107IPPfS2_EEDTmicldtfp_4baseEcldtfp0_4baseEERKNS_13move_iteratorIT_EERKNS4_IT0_EE(ptr noundef nonnull align 8 dereferenceable(8) %4, ptr noundef nonnull align 8 dereferenceable(8) %3)
  ret i64 %10
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef i64 @_ZNSt3__1miB8ne190107IPPfS2_EEDTmicldtfp_4baseEcldtfp0_4baseEERKNS_13move_iteratorIT_EERKNS4_IT0_EE(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = call noundef ptr @_ZNKSt3__113move_iteratorIPPfE4baseB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %5)
  %7 = load ptr, ptr %4, align 8
  %8 = call noundef ptr @_ZNKSt3__113move_iteratorIPPfE4baseB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %7)
  %9 = ptrtoint ptr %6 to i64
  %10 = ptrtoint ptr %8 to i64
  %11 = sub i64 %9, %10
  %12 = sdiv exact i64 %11, 8
  ret i64 %12
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNKSt3__113move_iteratorIPPfE4baseB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %3, i32 0, i32 0
  %5 = load ptr, ptr %4, align 8
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__113move_iteratorIPPfEC2B8ne190107ES2_(ptr noundef nonnull returned align 8 dereferenceable(8) %0, ptr noundef %1) unnamed_addr #1 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %5, i32 0, i32 0
  %7 = load ptr, ptr %4, align 8
  store ptr %7, ptr %6, align 8
  ret ptr %5
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden [2 x i64] @_ZNSt3__115__move_backwardB8ne190107INS_17_ClassicAlgPolicyEPPfS3_S3_EENS_4pairIT0_T2_EES5_T1_S6_(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca %"class.std::__1::__deque_iterator", align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store ptr %2, ptr %7, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = load ptr, ptr %7, align 8
  %11 = call [2 x i64] @_ZNSt3__124__copy_move_unwrap_itersB8ne190107INS_20__move_backward_implINS_17_ClassicAlgPolicyEEEPPfS5_S5_TnNS_9enable_ifIXsr12__can_rewrapIT0_T2_EE5valueEiE4typeELi0EEENS_4pairIS7_S8_EES7_T1_S8_(ptr noundef %8, ptr noundef %9, ptr noundef %10)
  store [2 x i64] %11, ptr %4, align 8
  %12 = load [2 x i64], ptr %4, align 8
  ret [2 x i64] %12
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden [2 x i64] @_ZNSt3__124__copy_move_unwrap_itersB8ne190107INS_20__move_backward_implINS_17_ClassicAlgPolicyEEEPPfS5_S5_TnNS_9enable_ifIXsr12__can_rewrapIT0_T2_EE5valueEiE4typeELi0EEENS_4pairIS7_S8_EES7_T1_S8_(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca %"class.std::__1::__deque_iterator", align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca %"class.std::__1::__deque_iterator", align 8
  %9 = alloca %"class.std::__1::__deque_iterator", align 8
  %10 = alloca %"struct.std::__1::integral_constant.7", align 1
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store ptr %2, ptr %7, align 8
  %13 = load ptr, ptr %5, align 8
  %14 = load ptr, ptr %6, align 8
  %15 = call [2 x i64] @_ZNSt3__114__unwrap_rangeB8ne190107IPPfS2_EENS_4pairIT0_S4_EET_S6_(ptr noundef %13, ptr noundef %14)
  store [2 x i64] %15, ptr %8, align 8
  %16 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %8, i32 0, i32 0
  %17 = load ptr, ptr %16, align 8
  %18 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %8, i32 0, i32 1
  %19 = load ptr, ptr %18, align 8
  %20 = load ptr, ptr %7, align 8
  %21 = call noundef ptr @_ZNSt3__113__unwrap_iterB8ne190107IPPfNS_18__unwrap_iter_implIS2_Lb1EEETnNS_9enable_ifIXsr21is_copy_constructibleIT_EE5valueEiE4typeELi0EEEDTclsrT0_8__unwrapclsr3stdE7declvalIS6_EEEES6_(ptr noundef %20) #13
  %22 = call [2 x i64] @_ZNKSt3__120__move_backward_implINS_17_ClassicAlgPolicyEEclB8ne190107IPfS4_TnNS_9enable_ifIXsr38__can_lower_move_assignment_to_memmoveIT_T0_EE5valueEiE4typeELi0EEENS_4pairIPS6_PS7_EESB_SB_SC_(ptr noundef nonnull align 1 dereferenceable(1) %10, ptr noundef %17, ptr noundef %19, ptr noundef %21)
  store [2 x i64] %22, ptr %9, align 8
  %23 = load ptr, ptr %5, align 8
  %24 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %9, i32 0, i32 0
  %25 = load ptr, ptr %24, align 8
  %26 = call noundef ptr @_ZNSt3__114__rewrap_rangeB8ne190107IPPfS2_EET_S3_T0_(ptr noundef %23, ptr noundef %25)
  store ptr %26, ptr %11, align 8
  %27 = load ptr, ptr %7, align 8
  %28 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %9, i32 0, i32 1
  %29 = load ptr, ptr %28, align 8
  %30 = call noundef ptr @_ZNSt3__113__rewrap_iterB8ne190107IPPfS2_NS_18__unwrap_iter_implIS2_Lb1EEEEET_S5_T0_(ptr noundef %27, ptr noundef %29) #13
  store ptr %30, ptr %12, align 8
  %31 = call [2 x i64] @_ZNSt3__19make_pairB8ne190107IPPfS2_EENS_4pairINS_18__unwrap_ref_decayIT_E4typeENS4_IT0_E4typeEEEOS5_OS8_(ptr noundef nonnull align 8 dereferenceable(8) %11, ptr noundef nonnull align 8 dereferenceable(8) %12)
  store [2 x i64] %31, ptr %4, align 8
  %32 = load [2 x i64], ptr %4, align 8
  ret [2 x i64] %32
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden [2 x i64] @_ZNSt3__114__unwrap_rangeB8ne190107IPPfS2_EENS_4pairIT0_S4_EET_S6_(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca %"class.std::__1::__deque_iterator", align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %8 = load ptr, ptr %4, align 8
  %9 = call noundef ptr @_ZNSt3__113__unwrap_iterB8ne190107IPPfNS_18__unwrap_iter_implIS2_Lb1EEETnNS_9enable_ifIXsr21is_copy_constructibleIT_EE5valueEiE4typeELi0EEEDTclsrT0_8__unwrapclsr3stdE7declvalIS6_EEEES6_(ptr noundef %8) #13
  store ptr %9, ptr %6, align 8
  %10 = load ptr, ptr %5, align 8
  %11 = call noundef ptr @_ZNSt3__113__unwrap_iterB8ne190107IPPfNS_18__unwrap_iter_implIS2_Lb1EEETnNS_9enable_ifIXsr21is_copy_constructibleIT_EE5valueEiE4typeELi0EEEDTclsrT0_8__unwrapclsr3stdE7declvalIS6_EEEES6_(ptr noundef %10) #13
  store ptr %11, ptr %7, align 8
  %12 = call [2 x i64] @_ZNSt3__19make_pairB8ne190107IPPfS2_EENS_4pairINS_18__unwrap_ref_decayIT_E4typeENS4_IT0_E4typeEEEOS5_OS8_(ptr noundef nonnull align 8 dereferenceable(8) %6, ptr noundef nonnull align 8 dereferenceable(8) %7)
  store [2 x i64] %12, ptr %3, align 8
  %13 = load [2 x i64], ptr %3, align 8
  ret [2 x i64] %13
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__113__unwrap_iterB8ne190107IPPfNS_18__unwrap_iter_implIS2_Lb1EEETnNS_9enable_ifIXsr21is_copy_constructibleIT_EE5valueEiE4typeELi0EEEDTclsrT0_8__unwrapclsr3stdE7declvalIS6_EEEES6_(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZNSt3__118__unwrap_iter_implIPPfLb1EE8__unwrapB8ne190107ES2_(ptr noundef %3) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr [2 x i64] @_ZNKSt3__120__move_backward_implINS_17_ClassicAlgPolicyEEclB8ne190107IPfS4_TnNS_9enable_ifIXsr38__can_lower_move_assignment_to_memmoveIT_T0_EE5valueEiE4typeELi0EEENS_4pairIPS6_PS7_EESB_SB_SC_(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1, ptr noundef %2, ptr noundef %3) #0 {
  %5 = alloca %"class.std::__1::__deque_iterator", align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  store ptr %0, ptr %6, align 8
  store ptr %1, ptr %7, align 8
  store ptr %2, ptr %8, align 8
  store ptr %3, ptr %9, align 8
  %10 = load ptr, ptr %6, align 8
  %11 = load ptr, ptr %7, align 8
  %12 = load ptr, ptr %8, align 8
  %13 = load ptr, ptr %9, align 8
  %14 = call [2 x i64] @_ZNSt3__128__copy_backward_trivial_implB8ne190107IPfS1_EENS_4pairIPT_PT0_EES4_S4_S6_(ptr noundef %11, ptr noundef %12, ptr noundef %13)
  store [2 x i64] %14, ptr %5, align 8
  %15 = load [2 x i64], ptr %5, align 8
  ret [2 x i64] %15
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__114__rewrap_rangeB8ne190107IPPfS2_EET_S3_T0_(ptr noundef %0, ptr noundef %1) #1 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = call noundef ptr @_ZNSt3__113__rewrap_iterB8ne190107IPPfS2_NS_18__unwrap_iter_implIS2_Lb1EEEEET_S5_T0_(ptr noundef %5, ptr noundef %6) #13
  ret ptr %7
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__113__rewrap_iterB8ne190107IPPfS2_NS_18__unwrap_iter_implIS2_Lb1EEEEET_S5_T0_(ptr noundef %0, ptr noundef %1) #1 personality ptr @__gxx_personality_v0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = invoke noundef ptr @_ZNSt3__118__unwrap_iter_implIPPfLb1EE8__rewrapB8ne190107ES2_S2_(ptr noundef %5, ptr noundef %6)
          to label %8 unwind label %9

8:                                                ; preds = %2
  ret ptr %7

9:                                                ; preds = %2
  %10 = landingpad { ptr, i32 }
          catch ptr null
  %11 = extractvalue { ptr, i32 } %10, 0
  call void @__clang_call_terminate(ptr %11) #14
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden [2 x i64] @_ZNSt3__19make_pairB8ne190107IPPfS2_EENS_4pairINS_18__unwrap_ref_decayIT_E4typeENS4_IT0_E4typeEEEOS5_OS8_(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) #1 {
  %3 = alloca %"class.std::__1::__deque_iterator", align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = load ptr, ptr %5, align 8
  %8 = call noundef ptr @_ZNSt3__14pairIPPfS2_EC1B8ne190107IS2_S2_TnNS_9enable_ifIXclsr10_CheckArgsE23__is_pair_constructibleIT_T0_EEEiE4typeELi0EEEOS6_OS7_(ptr noundef nonnull align 8 dereferenceable(16) %3, ptr noundef nonnull align 8 dereferenceable(8) %6, ptr noundef nonnull align 8 dereferenceable(8) %7) #13
  %9 = load [2 x i64], ptr %3, align 8
  ret [2 x i64] %9
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__14pairIPPfS2_EC1B8ne190107IS2_S2_TnNS_9enable_ifIXclsr10_CheckArgsE23__is_pair_constructibleIT_T0_EEEiE4typeELi0EEEOS6_OS7_(ptr noundef nonnull returned align 8 dereferenceable(16) %0, ptr noundef nonnull align 8 dereferenceable(8) %1, ptr noundef nonnull align 8 dereferenceable(8) %2) unnamed_addr #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = call noundef ptr @_ZNSt3__14pairIPPfS2_EC2B8ne190107IS2_S2_TnNS_9enable_ifIXclsr10_CheckArgsE23__is_pair_constructibleIT_T0_EEEiE4typeELi0EEEOS6_OS7_(ptr noundef nonnull align 8 dereferenceable(16) %7, ptr noundef nonnull align 8 dereferenceable(8) %8, ptr noundef nonnull align 8 dereferenceable(8) %9) #13
  ret ptr %7
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__14pairIPPfS2_EC2B8ne190107IS2_S2_TnNS_9enable_ifIXclsr10_CheckArgsE23__is_pair_constructibleIT_T0_EEEiE4typeELi0EEEOS6_OS7_(ptr noundef nonnull returned align 8 dereferenceable(16) %0, ptr noundef nonnull align 8 dereferenceable(8) %1, ptr noundef nonnull align 8 dereferenceable(8) %2) unnamed_addr #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %7, i32 0, i32 0
  %9 = load ptr, ptr %5, align 8
  %10 = load ptr, ptr %9, align 8
  store ptr %10, ptr %8, align 8
  %11 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %7, i32 0, i32 1
  %12 = load ptr, ptr %6, align 8
  %13 = load ptr, ptr %12, align 8
  store ptr %13, ptr %11, align 8
  ret ptr %7
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__118__unwrap_iter_implIPPfLb1EE8__rewrapB8ne190107ES2_S2_(ptr noundef %0, ptr noundef %1) #1 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = load ptr, ptr %3, align 8
  %8 = call noundef ptr @_ZNSt3__112__to_addressB8ne190107IPfEEPT_S3_(ptr noundef %7) #13
  %9 = ptrtoint ptr %6 to i64
  %10 = ptrtoint ptr %8 to i64
  %11 = sub i64 %9, %10
  %12 = sdiv exact i64 %11, 8
  %13 = getelementptr inbounds ptr, ptr %5, i64 %12
  ret ptr %13
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden [2 x i64] @_ZNSt3__128__copy_backward_trivial_implB8ne190107IPfS1_EENS_4pairIPT_PT0_EES4_S4_S6_(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca %"class.std::__1::__deque_iterator", align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i64, align 8
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store ptr %2, ptr %7, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = load ptr, ptr %5, align 8
  %11 = ptrtoint ptr %9 to i64
  %12 = ptrtoint ptr %10 to i64
  %13 = sub i64 %11, %12
  %14 = sdiv exact i64 %13, 8
  store i64 %14, ptr %8, align 8
  %15 = load i64, ptr %8, align 8
  %16 = load ptr, ptr %7, align 8
  %17 = sub i64 0, %15
  %18 = getelementptr inbounds ptr, ptr %16, i64 %17
  store ptr %18, ptr %7, align 8
  %19 = load ptr, ptr %7, align 8
  %20 = load ptr, ptr %5, align 8
  %21 = load i64, ptr %8, align 8
  %22 = call noundef ptr @_ZNSt3__119__constexpr_memmoveB8ne190107IPfS1_TnNS_9enable_ifIXsr23__is_always_bitcastableIT0_T_EE5valueEiE4typeELi0EEEPS4_S7_PS3_NS_15__element_countE(ptr noundef %19, ptr noundef %20, i64 noundef %21)
  %23 = call [2 x i64] @_ZNSt3__19make_pairB8ne190107IRPPfS3_EENS_4pairINS_18__unwrap_ref_decayIT_E4typeENS5_IT0_E4typeEEEOS6_OS9_(ptr noundef nonnull align 8 dereferenceable(8) %6, ptr noundef nonnull align 8 dereferenceable(8) %7)
  store [2 x i64] %23, ptr %4, align 8
  %24 = load [2 x i64], ptr %4, align 8
  ret [2 x i64] %24
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__119__constexpr_memmoveB8ne190107IPfS1_TnNS_9enable_ifIXsr23__is_always_bitcastableIT0_T_EE5valueEiE4typeELi0EEEPS4_S7_PS3_NS_15__element_countE(ptr noundef %0, ptr noundef %1, i64 noundef %2) #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i64 %2, ptr %6, align 8
  %8 = load i64, ptr %6, align 8
  store i64 %8, ptr %7, align 8
  %9 = load i64, ptr %7, align 8
  %10 = icmp ugt i64 %9, 0
  br i1 %10, label %11, label %18

11:                                               ; preds = %3
  %12 = load ptr, ptr %4, align 8
  %13 = load ptr, ptr %5, align 8
  %14 = load i64, ptr %7, align 8
  %15 = sub i64 %14, 1
  %16 = mul i64 %15, 8
  %17 = add i64 %16, 8
  call void @llvm.memmove.p0.p0.i64(ptr align 8 %12, ptr align 8 %13, i64 %17, i1 false)
  br label %18

18:                                               ; preds = %11, %3
  %19 = load ptr, ptr %4, align 8
  ret ptr %19
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden [2 x i64] @_ZNSt3__19make_pairB8ne190107IRPPfS3_EENS_4pairINS_18__unwrap_ref_decayIT_E4typeENS5_IT0_E4typeEEEOS6_OS9_(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) #1 {
  %3 = alloca %"class.std::__1::__deque_iterator", align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = load ptr, ptr %5, align 8
  %8 = call noundef ptr @_ZNSt3__14pairIPPfS2_EC1B8ne190107IRS2_S5_TnNS_9enable_ifIXclsr10_CheckArgsE23__is_pair_constructibleIT_T0_EEEiE4typeELi0EEEOS7_OS8_(ptr noundef nonnull align 8 dereferenceable(16) %3, ptr noundef nonnull align 8 dereferenceable(8) %6, ptr noundef nonnull align 8 dereferenceable(8) %7) #13
  %9 = load [2 x i64], ptr %3, align 8
  ret [2 x i64] %9
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__14pairIPPfS2_EC1B8ne190107IRS2_S5_TnNS_9enable_ifIXclsr10_CheckArgsE23__is_pair_constructibleIT_T0_EEEiE4typeELi0EEEOS7_OS8_(ptr noundef nonnull returned align 8 dereferenceable(16) %0, ptr noundef nonnull align 8 dereferenceable(8) %1, ptr noundef nonnull align 8 dereferenceable(8) %2) unnamed_addr #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = call noundef ptr @_ZNSt3__14pairIPPfS2_EC2B8ne190107IRS2_S5_TnNS_9enable_ifIXclsr10_CheckArgsE23__is_pair_constructibleIT_T0_EEEiE4typeELi0EEEOS7_OS8_(ptr noundef nonnull align 8 dereferenceable(16) %7, ptr noundef nonnull align 8 dereferenceable(8) %8, ptr noundef nonnull align 8 dereferenceable(8) %9) #13
  ret ptr %7
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__14pairIPPfS2_EC2B8ne190107IRS2_S5_TnNS_9enable_ifIXclsr10_CheckArgsE23__is_pair_constructibleIT_T0_EEEiE4typeELi0EEEOS7_OS8_(ptr noundef nonnull returned align 8 dereferenceable(16) %0, ptr noundef nonnull align 8 dereferenceable(8) %1, ptr noundef nonnull align 8 dereferenceable(8) %2) unnamed_addr #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %7, i32 0, i32 0
  %9 = load ptr, ptr %5, align 8
  %10 = load ptr, ptr %9, align 8
  store ptr %10, ptr %8, align 8
  %11 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %7, i32 0, i32 1
  %12 = load ptr, ptr %6, align 8
  %13 = load ptr, ptr %12, align 8
  store ptr %13, ptr %11, align 8
  ret ptr %7
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memmove.p0.p0.i64(ptr nocapture writeonly, ptr nocapture readonly, i64, i1 immarg) #8

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__118__unwrap_iter_implIPPfLb1EE8__unwrapB8ne190107ES2_(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZNSt3__112__to_addressB8ne190107IPfEEPT_S3_(ptr noundef %3) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__14moveB8ne190107IPPfS2_EET0_T_S4_S3_(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca %"class.std::__1::__deque_iterator", align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %8 = load ptr, ptr %4, align 8
  %9 = load ptr, ptr %5, align 8
  %10 = load ptr, ptr %6, align 8
  %11 = call [2 x i64] @_ZNSt3__16__moveB8ne190107INS_17_ClassicAlgPolicyEPPfS3_S3_EENS_4pairIT0_T2_EES5_T1_S6_(ptr noundef %8, ptr noundef %9, ptr noundef %10)
  store [2 x i64] %11, ptr %7, align 8
  %12 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %7, i32 0, i32 1
  %13 = load ptr, ptr %12, align 8
  ret ptr %13
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden [2 x i64] @_ZNSt3__16__moveB8ne190107INS_17_ClassicAlgPolicyEPPfS3_S3_EENS_4pairIT0_T2_EES5_T1_S6_(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca %"class.std::__1::__deque_iterator", align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store ptr %2, ptr %7, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = load ptr, ptr %7, align 8
  %11 = call [2 x i64] @_ZNSt3__124__copy_move_unwrap_itersB8ne190107INS_11__move_implINS_17_ClassicAlgPolicyEEEPPfS5_S5_TnNS_9enable_ifIXsr12__can_rewrapIT0_T2_EE5valueEiE4typeELi0EEENS_4pairIS7_S8_EES7_T1_S8_(ptr noundef %8, ptr noundef %9, ptr noundef %10)
  store [2 x i64] %11, ptr %4, align 8
  %12 = load [2 x i64], ptr %4, align 8
  ret [2 x i64] %12
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden [2 x i64] @_ZNSt3__124__copy_move_unwrap_itersB8ne190107INS_11__move_implINS_17_ClassicAlgPolicyEEEPPfS5_S5_TnNS_9enable_ifIXsr12__can_rewrapIT0_T2_EE5valueEiE4typeELi0EEENS_4pairIS7_S8_EES7_T1_S8_(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca %"class.std::__1::__deque_iterator", align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca %"class.std::__1::__deque_iterator", align 8
  %9 = alloca %"class.std::__1::__deque_iterator", align 8
  %10 = alloca %"struct.std::__1::integral_constant.7", align 1
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store ptr %2, ptr %7, align 8
  %13 = load ptr, ptr %5, align 8
  %14 = load ptr, ptr %6, align 8
  %15 = call [2 x i64] @_ZNSt3__114__unwrap_rangeB8ne190107IPPfS2_EENS_4pairIT0_S4_EET_S6_(ptr noundef %13, ptr noundef %14)
  store [2 x i64] %15, ptr %8, align 8
  %16 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %8, i32 0, i32 0
  %17 = load ptr, ptr %16, align 8
  %18 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %8, i32 0, i32 1
  %19 = load ptr, ptr %18, align 8
  %20 = load ptr, ptr %7, align 8
  %21 = call noundef ptr @_ZNSt3__113__unwrap_iterB8ne190107IPPfNS_18__unwrap_iter_implIS2_Lb1EEETnNS_9enable_ifIXsr21is_copy_constructibleIT_EE5valueEiE4typeELi0EEEDTclsrT0_8__unwrapclsr3stdE7declvalIS6_EEEES6_(ptr noundef %20) #13
  %22 = call [2 x i64] @_ZNKSt3__111__move_implINS_17_ClassicAlgPolicyEEclB8ne190107IPfS4_TnNS_9enable_ifIXsr38__can_lower_move_assignment_to_memmoveIT_T0_EE5valueEiE4typeELi0EEENS_4pairIPS6_PS7_EESB_SB_SC_(ptr noundef nonnull align 1 dereferenceable(1) %10, ptr noundef %17, ptr noundef %19, ptr noundef %21)
  store [2 x i64] %22, ptr %9, align 8
  %23 = load ptr, ptr %5, align 8
  %24 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %9, i32 0, i32 0
  %25 = load ptr, ptr %24, align 8
  %26 = call noundef ptr @_ZNSt3__114__rewrap_rangeB8ne190107IPPfS2_EET_S3_T0_(ptr noundef %23, ptr noundef %25)
  store ptr %26, ptr %11, align 8
  %27 = load ptr, ptr %7, align 8
  %28 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %9, i32 0, i32 1
  %29 = load ptr, ptr %28, align 8
  %30 = call noundef ptr @_ZNSt3__113__rewrap_iterB8ne190107IPPfS2_NS_18__unwrap_iter_implIS2_Lb1EEEEET_S5_T0_(ptr noundef %27, ptr noundef %29) #13
  store ptr %30, ptr %12, align 8
  %31 = call [2 x i64] @_ZNSt3__19make_pairB8ne190107IPPfS2_EENS_4pairINS_18__unwrap_ref_decayIT_E4typeENS4_IT0_E4typeEEEOS5_OS8_(ptr noundef nonnull align 8 dereferenceable(8) %11, ptr noundef nonnull align 8 dereferenceable(8) %12)
  store [2 x i64] %31, ptr %4, align 8
  %32 = load [2 x i64], ptr %4, align 8
  ret [2 x i64] %32
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr [2 x i64] @_ZNKSt3__111__move_implINS_17_ClassicAlgPolicyEEclB8ne190107IPfS4_TnNS_9enable_ifIXsr38__can_lower_move_assignment_to_memmoveIT_T0_EE5valueEiE4typeELi0EEENS_4pairIPS6_PS7_EESB_SB_SC_(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1, ptr noundef %2, ptr noundef %3) #0 {
  %5 = alloca %"class.std::__1::__deque_iterator", align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  store ptr %0, ptr %6, align 8
  store ptr %1, ptr %7, align 8
  store ptr %2, ptr %8, align 8
  store ptr %3, ptr %9, align 8
  %10 = load ptr, ptr %6, align 8
  %11 = load ptr, ptr %7, align 8
  %12 = load ptr, ptr %8, align 8
  %13 = load ptr, ptr %9, align 8
  %14 = call [2 x i64] @_ZNSt3__119__copy_trivial_implB8ne190107IPfS1_EENS_4pairIPT_PT0_EES4_S4_S6_(ptr noundef %11, ptr noundef %12, ptr noundef %13)
  store [2 x i64] %14, ptr %5, align 8
  %15 = load [2 x i64], ptr %5, align 8
  ret [2 x i64] %15
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden [2 x i64] @_ZNSt3__119__copy_trivial_implB8ne190107IPfS1_EENS_4pairIPT_PT0_EES4_S4_S6_(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca %"class.std::__1::__deque_iterator", align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i64, align 8
  %9 = alloca ptr, align 8
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store ptr %2, ptr %7, align 8
  %10 = load ptr, ptr %6, align 8
  %11 = load ptr, ptr %5, align 8
  %12 = ptrtoint ptr %10 to i64
  %13 = ptrtoint ptr %11 to i64
  %14 = sub i64 %12, %13
  %15 = sdiv exact i64 %14, 8
  store i64 %15, ptr %8, align 8
  %16 = load ptr, ptr %7, align 8
  %17 = load ptr, ptr %5, align 8
  %18 = load i64, ptr %8, align 8
  %19 = call noundef ptr @_ZNSt3__119__constexpr_memmoveB8ne190107IPfS1_TnNS_9enable_ifIXsr23__is_always_bitcastableIT0_T_EE5valueEiE4typeELi0EEEPS4_S7_PS3_NS_15__element_countE(ptr noundef %16, ptr noundef %17, i64 noundef %18)
  %20 = load ptr, ptr %7, align 8
  %21 = load i64, ptr %8, align 8
  %22 = getelementptr inbounds ptr, ptr %20, i64 %21
  store ptr %22, ptr %9, align 8
  %23 = call [2 x i64] @_ZNSt3__19make_pairB8ne190107IRPPfS2_EENS_4pairINS_18__unwrap_ref_decayIT_E4typeENS5_IT0_E4typeEEEOS6_OS9_(ptr noundef nonnull align 8 dereferenceable(8) %6, ptr noundef nonnull align 8 dereferenceable(8) %9)
  store [2 x i64] %23, ptr %4, align 8
  %24 = load [2 x i64], ptr %4, align 8
  ret [2 x i64] %24
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden [2 x i64] @_ZNSt3__19make_pairB8ne190107IRPPfS2_EENS_4pairINS_18__unwrap_ref_decayIT_E4typeENS5_IT0_E4typeEEEOS6_OS9_(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) #1 {
  %3 = alloca %"class.std::__1::__deque_iterator", align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = load ptr, ptr %5, align 8
  %8 = call noundef ptr @_ZNSt3__14pairIPPfS2_EC1B8ne190107IRS2_S2_TnNS_9enable_ifIXclsr10_CheckArgsE23__is_pair_constructibleIT_T0_EEEiE4typeELi0EEEOS7_OS8_(ptr noundef nonnull align 8 dereferenceable(16) %3, ptr noundef nonnull align 8 dereferenceable(8) %6, ptr noundef nonnull align 8 dereferenceable(8) %7) #13
  %9 = load [2 x i64], ptr %3, align 8
  ret [2 x i64] %9
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__14pairIPPfS2_EC1B8ne190107IRS2_S2_TnNS_9enable_ifIXclsr10_CheckArgsE23__is_pair_constructibleIT_T0_EEEiE4typeELi0EEEOS7_OS8_(ptr noundef nonnull returned align 8 dereferenceable(16) %0, ptr noundef nonnull align 8 dereferenceable(8) %1, ptr noundef nonnull align 8 dereferenceable(8) %2) unnamed_addr #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = call noundef ptr @_ZNSt3__14pairIPPfS2_EC2B8ne190107IRS2_S2_TnNS_9enable_ifIXclsr10_CheckArgsE23__is_pair_constructibleIT_T0_EEEiE4typeELi0EEEOS7_OS8_(ptr noundef nonnull align 8 dereferenceable(16) %7, ptr noundef nonnull align 8 dereferenceable(8) %8, ptr noundef nonnull align 8 dereferenceable(8) %9) #13
  ret ptr %7
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__14pairIPPfS2_EC2B8ne190107IRS2_S2_TnNS_9enable_ifIXclsr10_CheckArgsE23__is_pair_constructibleIT_T0_EEEiE4typeELi0EEEOS7_OS8_(ptr noundef nonnull returned align 8 dereferenceable(16) %0, ptr noundef nonnull align 8 dereferenceable(8) %1, ptr noundef nonnull align 8 dereferenceable(8) %2) unnamed_addr #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %7, i32 0, i32 0
  %9 = load ptr, ptr %5, align 8
  %10 = load ptr, ptr %9, align 8
  store ptr %10, ptr %8, align 8
  %11 = getelementptr inbounds %"class.std::__1::__deque_iterator", ptr %7, i32 0, i32 1
  %12 = load ptr, ptr %6, align 8
  %13 = load ptr, ptr %12, align 8
  store ptr %13, ptr %11, align 8
  ret ptr %7
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__117__compressed_pairIPfNS_22__allocator_destructorINS_9allocatorIfEEEEE5firstB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(24) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__122__compressed_pair_elemIPfLi0ELb0EE5__getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNKSt3__122__compressed_pair_elemIPfLi0ELb0EE5__getB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %3, i32 0, i32 0
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__110unique_ptrIPfNS_22__allocator_destructorINS_9allocatorIfEEEEEC2B8ne190107ILb1EvEES1_NS_16__dependent_typeINS_27__unique_ptr_deleter_sfinaeIS5_EEXT_EE20__good_rval_ref_typeE(ptr noundef nonnull returned align 8 dereferenceable(24) %0, ptr noundef %1, ptr noundef nonnull align 8 dereferenceable(16) %2) unnamed_addr #1 personality ptr @__gxx_personality_v0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = getelementptr inbounds %"class.std::__1::unique_ptr", ptr %7, i32 0, i32 0
  %9 = load ptr, ptr %6, align 8
  %10 = invoke noundef ptr @_ZNSt3__117__compressed_pairIPfNS_22__allocator_destructorINS_9allocatorIfEEEEEC1B8ne190107IRS1_S5_EEOT_OT0_(ptr noundef nonnull align 8 dereferenceable(24) %8, ptr noundef nonnull align 8 dereferenceable(8) %5, ptr noundef nonnull align 8 dereferenceable(16) %9)
          to label %11 unwind label %12

11:                                               ; preds = %3
  ret ptr %7

12:                                               ; preds = %3
  %13 = landingpad { ptr, i32 }
          catch ptr null
  %14 = extractvalue { ptr, i32 } %13, 0
  call void @__clang_call_terminate(ptr %14) #14
  unreachable
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__117__compressed_pairIPfNS_22__allocator_destructorINS_9allocatorIfEEEEEC1B8ne190107IRS1_S5_EEOT_OT0_(ptr noundef nonnull returned align 8 dereferenceable(24) %0, ptr noundef nonnull align 8 dereferenceable(8) %1, ptr noundef nonnull align 8 dereferenceable(16) %2) unnamed_addr #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = call noundef ptr @_ZNSt3__117__compressed_pairIPfNS_22__allocator_destructorINS_9allocatorIfEEEEEC2B8ne190107IRS1_S5_EEOT_OT0_(ptr noundef nonnull align 8 dereferenceable(24) %7, ptr noundef nonnull align 8 dereferenceable(8) %8, ptr noundef nonnull align 8 dereferenceable(16) %9)
  ret ptr %7
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__117__compressed_pairIPfNS_22__allocator_destructorINS_9allocatorIfEEEEEC2B8ne190107IRS1_S5_EEOT_OT0_(ptr noundef nonnull returned align 8 dereferenceable(24) %0, ptr noundef nonnull align 8 dereferenceable(8) %1, ptr noundef nonnull align 8 dereferenceable(16) %2) unnamed_addr #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = call noundef ptr @_ZNSt3__122__compressed_pair_elemIPfLi0ELb0EEC2B8ne190107IRS1_TnNS_9enable_ifIXntsr7is_sameIS2_u7__decayIT_EEE5valueEiE4typeELi0EEEOS6_(ptr noundef nonnull align 8 dereferenceable(8) %7, ptr noundef nonnull align 8 dereferenceable(8) %8)
  %10 = getelementptr inbounds i8, ptr %7, i64 8
  %11 = load ptr, ptr %6, align 8
  %12 = call noundef ptr @_ZNSt3__122__compressed_pair_elemINS_22__allocator_destructorINS_9allocatorIfEEEELi1ELb0EEC2B8ne190107IS4_TnNS_9enable_ifIXntsr7is_sameIS5_u7__decayIT_EEE5valueEiE4typeELi0EEEOS8_(ptr noundef nonnull align 8 dereferenceable(16) %10, ptr noundef nonnull align 8 dereferenceable(16) %11)
  ret ptr %7
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__122__compressed_pair_elemIPfLi0ELb0EEC2B8ne190107IRS1_TnNS_9enable_ifIXntsr7is_sameIS2_u7__decayIT_EEE5valueEiE4typeELi0EEEOS6_(ptr noundef nonnull returned align 8 dereferenceable(8) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) unnamed_addr #1 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %5, i32 0, i32 0
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %7, align 8
  store ptr %8, ptr %6, align 8
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__122__compressed_pair_elemINS_22__allocator_destructorINS_9allocatorIfEEEELi1ELb0EEC2B8ne190107IS4_TnNS_9enable_ifIXntsr7is_sameIS5_u7__decayIT_EEE5valueEiE4typeELi0EEEOS8_(ptr noundef nonnull returned align 8 dereferenceable(16) %0, ptr noundef nonnull align 8 dereferenceable(16) %1) unnamed_addr #1 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem.13", ptr %5, i32 0, i32 0
  %7 = load ptr, ptr %4, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %6, ptr align 8 %7, i64 16, i1 false)
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__122__allocator_destructorINS_9allocatorIfEEEC2B8ne190107ERS2_m(ptr noundef nonnull returned align 8 dereferenceable(16) %0, ptr noundef nonnull align 1 dereferenceable(1) %1, i64 noundef %2) unnamed_addr #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i64 %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = getelementptr inbounds %"class.std::__1::__allocator_destructor", ptr %7, i32 0, i32 0
  %9 = load ptr, ptr %5, align 8
  store ptr %9, ptr %8, align 8
  %10 = getelementptr inbounds %"class.std::__1::__allocator_destructor", ptr %7, i32 0, i32 1
  %11 = load i64, ptr %6, align 8
  store i64 %11, ptr %10, align 8
  ret ptr %7
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEEC2EmmS4_(ptr noundef nonnull returned align 8 dereferenceable(40) %0, i64 noundef %1, i64 noundef %2, ptr noundef nonnull align 1 dereferenceable(1) %3) unnamed_addr #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca %"class.std::__1::__allocator_destructor", align 8
  store ptr %0, ptr %6, align 8
  store i64 %1, ptr %7, align 8
  store i64 %2, ptr %8, align 8
  store ptr %3, ptr %9, align 8
  %12 = load ptr, ptr %6, align 8
  store ptr %12, ptr %5, align 8
  %13 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %12, i32 0, i32 3
  store ptr null, ptr %10, align 8
  %14 = load ptr, ptr %9, align 8
  %15 = call noundef ptr @_ZNSt3__117__compressed_pairIPPfRNS_9allocatorIS1_EEEC1B8ne190107IDnS5_EEOT_OT0_(ptr noundef nonnull align 8 dereferenceable(16) %13, ptr noundef nonnull align 8 dereferenceable(8) %10, ptr noundef nonnull align 1 dereferenceable(1) %14)
  %16 = load i64, ptr %7, align 8
  %17 = icmp eq i64 %16, 0
  br i1 %17, label %18, label %20

18:                                               ; preds = %4
  %19 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %12, i32 0, i32 0
  store ptr null, ptr %19, align 8
  br label %29

20:                                               ; preds = %4
  %21 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %12) #13
  %22 = load i64, ptr %7, align 8
  %23 = call [2 x i64] @_ZNSt3__119__allocate_at_leastB8ne190107INS_9allocatorIPfEEEENS_19__allocation_resultINS_16allocator_traitsIT_E7pointerEEERS6_m(ptr noundef nonnull align 1 dereferenceable(1) %21, i64 noundef %22)
  store [2 x i64] %23, ptr %11, align 8
  %24 = getelementptr inbounds %"class.std::__1::__allocator_destructor", ptr %11, i32 0, i32 0
  %25 = load ptr, ptr %24, align 8
  %26 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %12, i32 0, i32 0
  store ptr %25, ptr %26, align 8
  %27 = getelementptr inbounds %"class.std::__1::__allocator_destructor", ptr %11, i32 0, i32 1
  %28 = load i64, ptr %27, align 8
  store i64 %28, ptr %7, align 8
  br label %29

29:                                               ; preds = %20, %18
  %30 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %12, i32 0, i32 0
  %31 = load ptr, ptr %30, align 8
  %32 = load i64, ptr %8, align 8
  %33 = getelementptr inbounds ptr, ptr %31, i64 %32
  %34 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %12, i32 0, i32 2
  store ptr %33, ptr %34, align 8
  %35 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %12, i32 0, i32 1
  store ptr %33, ptr %35, align 8
  %36 = getelementptr inbounds %"struct.std::__1::__split_buffer.8", ptr %12, i32 0, i32 0
  %37 = load ptr, ptr %36, align 8
  %38 = load i64, ptr %7, align 8
  %39 = getelementptr inbounds ptr, ptr %37, i64 %38
  %40 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__114__split_bufferIPfRNS_9allocatorIS1_EEE9__end_capB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(40) %12) #13
  store ptr %39, ptr %40, align 8
  %41 = load ptr, ptr %5, align 8
  ret ptr %41
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__117__compressed_pairIPPfRNS_9allocatorIS1_EEEC1B8ne190107IDnS5_EEOT_OT0_(ptr noundef nonnull returned align 8 dereferenceable(16) %0, ptr noundef nonnull align 8 dereferenceable(8) %1, ptr noundef nonnull align 1 dereferenceable(1) %2) unnamed_addr #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = call noundef ptr @_ZNSt3__117__compressed_pairIPPfRNS_9allocatorIS1_EEEC2B8ne190107IDnS5_EEOT_OT0_(ptr noundef nonnull align 8 dereferenceable(16) %7, ptr noundef nonnull align 8 dereferenceable(8) %8, ptr noundef nonnull align 1 dereferenceable(1) %9)
  ret ptr %7
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden [2 x i64] @_ZNSt3__119__allocate_at_leastB8ne190107INS_9allocatorIPfEEEENS_19__allocation_resultINS_16allocator_traitsIT_E7pointerEEERS6_m(ptr noundef nonnull align 1 dereferenceable(1) %0, i64 noundef %1) #0 {
  %3 = alloca %"class.std::__1::__allocator_destructor", align 8
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  %6 = getelementptr inbounds %"class.std::__1::__allocator_destructor", ptr %3, i32 0, i32 0
  %7 = load ptr, ptr %4, align 8
  %8 = load i64, ptr %5, align 8
  %9 = call noundef ptr @_ZNSt3__19allocatorIPfE8allocateB8ne190107Em(ptr noundef nonnull align 1 dereferenceable(1) %7, i64 noundef %8)
  store ptr %9, ptr %6, align 8
  %10 = getelementptr inbounds %"class.std::__1::__allocator_destructor", ptr %3, i32 0, i32 1
  %11 = load i64, ptr %5, align 8
  store i64 %11, ptr %10, align 8
  %12 = load [2 x i64], ptr %3, align 8
  ret [2 x i64] %12
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__19allocatorIPfE8allocateB8ne190107Em(ptr noundef nonnull align 1 dereferenceable(1) %0, i64 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load i64, ptr %4, align 8
  %7 = call noundef i64 @_ZNSt3__116allocator_traitsINS_9allocatorIPfEEE8max_sizeB8ne190107IS3_TnNS_9enable_ifIXsr14__has_max_sizeIKT_EE5valueEiE4typeELi0EEEmRKS3_(ptr noundef nonnull align 1 dereferenceable(1) %5) #13
  %8 = icmp ugt i64 %6, %7
  br i1 %8, label %9, label %10

9:                                                ; preds = %2
  call void @_ZSt28__throw_bad_array_new_lengthB8ne190107v() #17
  unreachable

10:                                               ; preds = %2
  %11 = load i64, ptr %4, align 8
  %12 = mul i64 %11, 8
  %13 = call noundef ptr @_ZNSt3__117__libcpp_allocateB8ne190107Emm(i64 noundef %12, i64 noundef 8)
  ret ptr %13
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef i64 @_ZNSt3__116allocator_traitsINS_9allocatorIPfEEE8max_sizeB8ne190107IS3_TnNS_9enable_ifIXsr14__has_max_sizeIKT_EE5valueEiE4typeELi0EEEmRKS3_(ptr noundef nonnull align 1 dereferenceable(1) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef i64 @_ZNKSt3__19allocatorIPfE8max_sizeB8ne190107Ev(ptr noundef nonnull align 1 dereferenceable(1) %3) #13
  ret i64 %4
}

; Function Attrs: mustprogress noinline noreturn optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZSt28__throw_bad_array_new_lengthB8ne190107v() #9 {
  %1 = call ptr @__cxa_allocate_exception(i64 8) #13
  %2 = call noundef ptr @_ZNSt20bad_array_new_lengthC1Ev(ptr noundef nonnull align 8 dereferenceable(8) %1) #13
  call void @__cxa_throw(ptr %1, ptr @_ZTISt20bad_array_new_length, ptr @_ZNSt20bad_array_new_lengthD1Ev) #17
  unreachable
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__117__libcpp_allocateB8ne190107Emm(i64 noundef %0, i64 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  store i64 %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  %7 = load i64, ptr %5, align 8
  %8 = call noundef zeroext i1 @_ZNSt3__124__is_overaligned_for_newB8ne190107Em(i64 noundef %7) #13
  br i1 %8, label %9, label %14

9:                                                ; preds = %2
  %10 = load i64, ptr %5, align 8
  store i64 %10, ptr %6, align 8
  %11 = load i64, ptr %4, align 8
  %12 = load i64, ptr %6, align 8
  %13 = call noundef ptr @_ZNSt3__121__libcpp_operator_newB8ne190107IJmSt11align_val_tEEEPvDpT_(i64 noundef %11, i64 noundef %12)
  store ptr %13, ptr %3, align 8
  br label %17

14:                                               ; preds = %2
  %15 = load i64, ptr %4, align 8
  %16 = call noundef ptr @_ZNSt3__121__libcpp_operator_newB8ne190107IJmEEEPvDpT_(i64 noundef %15)
  store ptr %16, ptr %3, align 8
  br label %17

17:                                               ; preds = %14, %9
  %18 = load ptr, ptr %3, align 8
  ret ptr %18
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__121__libcpp_operator_newB8ne190107IJmSt11align_val_tEEEPvDpT_(i64 noundef %0, i64 noundef %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  %5 = load i64, ptr %3, align 8
  %6 = load i64, ptr %4, align 8
  %7 = call noalias noundef nonnull ptr @_ZnwmSt11align_val_t(i64 noundef %5, i64 noundef %6) #18
  call void @llvm.assume(i1 true) [ "align"(ptr %7, i64 %6) ]
  ret ptr %7
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__121__libcpp_operator_newB8ne190107IJmEEEPvDpT_(i64 noundef %0) #0 {
  %2 = alloca i64, align 8
  store i64 %0, ptr %2, align 8
  %3 = load i64, ptr %2, align 8
  %4 = call noalias noundef nonnull ptr @_Znwm(i64 noundef %3) #18
  ret ptr %4
}

; Function Attrs: nobuiltin allocsize(0)
declare noundef nonnull ptr @_Znwm(i64 noundef) #10

; Function Attrs: nobuiltin allocsize(0)
declare noundef nonnull ptr @_ZnwmSt11align_val_t(i64 noundef, i64 noundef) #10

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #11

declare ptr @__cxa_allocate_exception(i64)

; Function Attrs: nounwind
declare noundef ptr @_ZNSt20bad_array_new_lengthC1Ev(ptr noundef nonnull returned align 8 dereferenceable(8)) unnamed_addr #6

; Function Attrs: nounwind
declare noundef ptr @_ZNSt20bad_array_new_lengthD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8)) unnamed_addr #6

declare void @__cxa_throw(ptr, ptr, ptr)

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef i64 @_ZNKSt3__19allocatorIPfE8max_sizeB8ne190107Ev(ptr noundef nonnull align 1 dereferenceable(1) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret i64 2305843009213693951
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__117__compressed_pairIPPfRNS_9allocatorIS1_EEEC2B8ne190107IDnS5_EEOT_OT0_(ptr noundef nonnull returned align 8 dereferenceable(16) %0, ptr noundef nonnull align 8 dereferenceable(8) %1, ptr noundef nonnull align 1 dereferenceable(1) %2) unnamed_addr #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = call noundef ptr @_ZNSt3__122__compressed_pair_elemIPPfLi0ELb0EEC2B8ne190107IDnTnNS_9enable_ifIXntsr7is_sameIS3_u7__decayIT_EEE5valueEiE4typeELi0EEEOS6_(ptr noundef nonnull align 8 dereferenceable(8) %7, ptr noundef nonnull align 8 dereferenceable(8) %8)
  %10 = getelementptr inbounds i8, ptr %7, i64 8
  %11 = load ptr, ptr %6, align 8
  %12 = call noundef ptr @_ZNSt3__122__compressed_pair_elemIRNS_9allocatorIPfEELi1ELb0EEC2B8ne190107IS4_TnNS_9enable_ifIXntsr7is_sameIS5_u7__decayIT_EEE5valueEiE4typeELi0EEEOS8_(ptr noundef nonnull align 8 dereferenceable(8) %10, ptr noundef nonnull align 1 dereferenceable(1) %11)
  ret ptr %7
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZNSt3__122__compressed_pair_elemIRNS_9allocatorIPfEELi1ELb0EEC2B8ne190107IS4_TnNS_9enable_ifIXntsr7is_sameIS5_u7__decayIT_EEE5valueEiE4typeELi0EEEOS8_(ptr noundef nonnull returned align 8 dereferenceable(8) %0, ptr noundef nonnull align 1 dereferenceable(1) %1) unnamed_addr #1 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %5, i32 0, i32 0
  %7 = load ptr, ptr %4, align 8
  store ptr %7, ptr %6, align 8
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__13maxB8ne190107ImNS_6__lessIvvEEEERKT_S5_S5_T0_(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) #1 {
  %3 = alloca %"struct.std::__1::integral_constant.7", align 1
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = load ptr, ptr %5, align 8
  %8 = call noundef zeroext i1 @_ZNKSt3__16__lessIvvEclB8ne190107ImmEEbRKT_RKT0_(ptr noundef nonnull align 1 dereferenceable(1) %3, ptr noundef nonnull align 8 dereferenceable(8) %6, ptr noundef nonnull align 8 dereferenceable(8) %7)
  br i1 %8, label %9, label %11

9:                                                ; preds = %2
  %10 = load ptr, ptr %5, align 8
  br label %13

11:                                               ; preds = %2
  %12 = load ptr, ptr %4, align 8
  br label %13

13:                                               ; preds = %11, %9
  %14 = phi ptr [ %10, %9 ], [ %12, %11 ]
  ret ptr %14
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef zeroext i1 @_ZNKSt3__16__lessIvvEclB8ne190107ImmEEbRKT_RKT0_(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef nonnull align 8 dereferenceable(8) %1, ptr noundef nonnull align 8 dereferenceable(8) %2) #1 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load i64, ptr %8, align 8
  %10 = load ptr, ptr %6, align 8
  %11 = load i64, ptr %10, align 8
  %12 = icmp ult i64 %9, %11
  ret i1 %12
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef ptr @_ZNSt3__19allocatorIfE8allocateB8ne190107Em(ptr noundef nonnull align 1 dereferenceable(1) %0, i64 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load i64, ptr %4, align 8
  %7 = call noundef i64 @_ZNSt3__116allocator_traitsINS_9allocatorIfEEE8max_sizeB8ne190107IS2_TnNS_9enable_ifIXsr14__has_max_sizeIKT_EE5valueEiE4typeELi0EEEmRKS2_(ptr noundef nonnull align 1 dereferenceable(1) %5) #13
  %8 = icmp ugt i64 %6, %7
  br i1 %8, label %9, label %10

9:                                                ; preds = %2
  call void @_ZSt28__throw_bad_array_new_lengthB8ne190107v() #17
  unreachable

10:                                               ; preds = %2
  %11 = load i64, ptr %4, align 8
  %12 = mul i64 %11, 4
  %13 = call noundef ptr @_ZNSt3__117__libcpp_allocateB8ne190107Emm(i64 noundef %12, i64 noundef 4)
  ret ptr %13
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr noundef i64 @_ZNSt3__116allocator_traitsINS_9allocatorIfEEE8max_sizeB8ne190107IS2_TnNS_9enable_ifIXsr14__has_max_sizeIKT_EE5valueEiE4typeELi0EEEmRKS2_(ptr noundef nonnull align 1 dereferenceable(1) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef i64 @_ZNKSt3__19allocatorIfE8max_sizeB8ne190107Ev(ptr noundef nonnull align 1 dereferenceable(1) %3) #13
  ret i64 %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef i64 @_ZNKSt3__19allocatorIfE8max_sizeB8ne190107Ev(ptr noundef nonnull align 1 dereferenceable(1) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret i64 4611686018427387903
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef i64 @_ZNKSt3__15dequeIfNS_9allocatorIfEEE10__capacityB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::deque", ptr %3, i32 0, i32 0
  %5 = call noundef i64 @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE4sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %4)
  %6 = icmp eq i64 %5, 0
  br i1 %6, label %7, label %8

7:                                                ; preds = %1
  br label %13

8:                                                ; preds = %1
  %9 = getelementptr inbounds %"class.std::__1::deque", ptr %3, i32 0, i32 0
  %10 = call noundef i64 @_ZNKSt3__114__split_bufferIPfNS_9allocatorIS1_EEE4sizeB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(32) %9)
  %11 = mul i64 %10, 1024
  %12 = sub i64 %11, 1
  br label %13

13:                                               ; preds = %8, %7
  %14 = phi i64 [ 0, %7 ], [ %12, %8 ]
  ret i64 %14
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNKSt3__15dequeIfNS_9allocatorIfEEE7__allocB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(48) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::deque", ptr %3, i32 0, i32 2
  %5 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNKSt3__117__compressed_pairImNS_9allocatorIfEEE6secondB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #13
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef i64 @_ZNSt3__114numeric_limitsIlE3maxB8ne190107Ev() #1 {
  %1 = call noundef i64 @_ZNSt3__123__libcpp_numeric_limitsIlLb1EE3maxB8ne190107Ev() #13
  ret i64 %1
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__13minB8ne190107ImEERKT_S3_S3_(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca %"struct.std::__1::integral_constant.7", align 1
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %6 = load ptr, ptr %3, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__13minB8ne190107ImNS_6__lessIvvEEEERKT_S5_S5_T0_(ptr noundef nonnull align 8 dereferenceable(8) %6, ptr noundef nonnull align 8 dereferenceable(8) %7)
  ret ptr %8
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__13minB8ne190107ImNS_6__lessIvvEEEERKT_S5_S5_T0_(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) #0 {
  %3 = alloca %"struct.std::__1::integral_constant.7", align 1
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %6 = load ptr, ptr %5, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = call noundef zeroext i1 @_ZNKSt3__16__lessIvvEclB8ne190107ImmEEbRKT_RKT0_(ptr noundef nonnull align 1 dereferenceable(1) %3, ptr noundef nonnull align 8 dereferenceable(8) %6, ptr noundef nonnull align 8 dereferenceable(8) %7)
  br i1 %8, label %9, label %11

9:                                                ; preds = %2
  %10 = load ptr, ptr %5, align 8
  br label %13

11:                                               ; preds = %2
  %12 = load ptr, ptr %4, align 8
  br label %13

13:                                               ; preds = %11, %9
  %14 = phi ptr [ %10, %9 ], [ %12, %11 ]
  ret ptr %14
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef i64 @_ZNSt3__123__libcpp_numeric_limitsIlLb1EE3maxB8ne190107Ev() #1 {
  ret i64 9223372036854775807
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNKSt3__117__compressed_pairImNS_9allocatorIfEEE6secondB8ne190107Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNKSt3__122__compressed_pair_elemINS_9allocatorIfEELi1ELb1EE5__getB8ne190107Ev(ptr noundef nonnull align 1 dereferenceable(1) %3) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNKSt3__122__compressed_pair_elemINS_9allocatorIfEELi1ELb1EE5__getB8ne190107Ev(ptr noundef nonnull align 1 dereferenceable(1) %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #12

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #12

attributes #0 = { mustprogress noinline optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #1 = { mustprogress noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #2 = { noinline noreturn nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #3 = { nobuiltin nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #4 = { alwaysinline mustprogress ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #5 = { alwaysinline mustprogress nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #6 = { nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #7 = { cold noreturn "disable-tail-calls"="true" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #8 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #9 = { mustprogress noinline noreturn optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #10 = { nobuiltin allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #11 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }
attributes #12 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #13 = { nounwind }
attributes #14 = { noreturn nounwind }
attributes #15 = { builtin nounwind }
attributes #16 = { cold noreturn }
attributes #17 = { noreturn }
attributes #18 = { builtin allocsize(0) }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5}
!llvm.ident = !{!6}

!0 = !{i32 2, !"Debug Info Version", i32 3}
!1 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 8, !"PIC Level", i32 0}
!4 = !{i32 7, !"uwtable", i32 1}
!5 = !{i32 7, !"frame-pointer", i32 1}
!6 = !{!"Homebrew clang version 19.1.7"}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
!9 = distinct !{!9, !8}
!10 = distinct !{!10, !8}
!11 = distinct !{!11, !8}
!12 = distinct !{!12, !8}
!13 = distinct !{!13, !8}
!14 = distinct !{!14, !8}
