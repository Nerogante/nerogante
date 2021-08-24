(module
 (type $i32_=>_none (func (param i32)))
 (type $i32_i32_=>_none (func (param i32 i32)))
 (type $i32_i32_i32_=>_none (func (param i32 i32 i32)))
 (type $i32_i32_=>_i32 (func (param i32 i32) (result i32)))
 (type $none_=>_none (func))
 (type $none_=>_i32 (func (result i32)))
 (type $i32_i32_i32_i32_=>_none (func (param i32 i32 i32 i32)))
 (type $i32_i32_i32_i32_i32_i32_=>_none (func (param i32 i32 i32 i32 i32 i32)))
 (type $i32_i32_i32_=>_i32 (func (param i32 i32 i32) (result i32)))
 (import "env" "memory" (memory $0 29298))
 (data (i32.const 1920000012) ",\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h\00")
 (data (i32.const 1920000060) "<\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00&\00\00\00~\00l\00i\00b\00/\00s\00t\00a\00t\00i\00c\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00\00\00\00\00")
 (data (i32.const 1920000124) "<\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e\00\00\00\00\00")
 (data (i32.const 1920000188) "<\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data (i32.const 1920000256) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data (i32.const 1920000288) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data (i32.const 1920000316) "<\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\00\00")
 (data (i32.const 1920000380) ",\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (data (i32.const 1920000432) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data (i32.const 1920000460) "<\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data (i32.const 1920000524) "<\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00&\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00b\00u\00f\00f\00e\00r\00.\00t\00s\00\00\00\00\00\00\00")
 (data (i32.const 1920000588) "\1c\08\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\08\00\00\10\10\10\10\10\10\e0?000000\e0?PPPPPP\e0?pppppp\e0?\91\90\90\90\90\90\e0?\b1\b0\b0\b0\b0\b0\e0?\d1\d0\d0\d0\d0\d0\e0?\f1\f0\f0\f0\f0\f0\e0?\11\11\11\11\11\11\e1?111111\e1?QQQQQQ\e1?qqqqqq\e1?\92\91\91\91\91\91\e1?\b2\b1\b1\b1\b1\b1\e1?\d2\d1\d1\d1\d1\d1\e1?\f2\f1\f1\f1\f1\f1\e1?\12\12\12\12\12\12\e2?222222\e2?RRRRRR\e2?rrrrrr\e2?\93\92\92\92\92\92\e2?\b3\b2\b2\b2\b2\b2\e2?\d3\d2\d2\d2\d2\d2\e2?\f3\f2\f2\f2\f2\f2\e2?\13\13\13\13\13\13\e3?333333\e3?SSSSSS\e3?ssssss\e3?\94\93\93\93\93\93\e3?\b4\b3\b3\b3\b3\b3\e3?\d4\d3\d3\d3\d3\d3\e3?\f4\f3\f3\f3\f3\f3\e3?\14\14\14\14\14\14\e4?444444\e4?TTTTTT\e4?tttttt\e4?\95\94\94\94\94\94\e4?\b5\b4\b4\b4\b4\b4\e4?\d5\d4\d4\d4\d4\d4\e4?\f5\f4\f4\f4\f4\f4\e4?\15\15\15\15\15\15\e5?555555\e5?UUUUUU\e5?uuuuuu\e5?\96\95\95\95\95\95\e5?\b6\b5\b5\b5\b5\b5\e5?\d6\d5\d5\d5\d5\d5\e5?\f6\f5\f5\f5\f5\f5\e5?\16\16\16\16\16\16\e6?666666\e6?VVVVVV\e6?vvvvvv\e6?\97\96\96\96\96\96\e6?\b7\b6\b6\b6\b6\b6\e6?\d7\d6\d6\d6\d6\d6\e6?\f7\f6\f6\f6\f6\f6\e6?\17\17\17\17\17\17\e7?777777\e7?WWWWWW\e7?wwwwww\e7?\98\97\97\97\97\97\e7?\b8\b7\b7\b7\b7\b7\e7?\d8\d7\d7\d7\d7\d7\e7?\f8\f7\f7\f7\f7\f7\e7?\18\18\18\18\18\18\e8?888888\e8?XXXXXX\e8?xxxxxx\e8?\99\98\98\98\98\98\e8?\b9\b8\b8\b8\b8\b8\e8?\d9\d8\d8\d8\d8\d8\e8?\f9\f8\f8\f8\f8\f8\e8?\19\19\19\19\19\19\e9?999999\e9?YYYYYY\e9?yyyyyy\e9?\9a\99\99\99\99\99\e9?\ba\b9\b9\b9\b9\b9\e9?\da\d9\d9\d9\d9\d9\e9?\fa\f9\f9\f9\f9\f9\e9?\1a\1a\1a\1a\1a\1a\ea?::::::\ea?ZZZZZZ\ea?zzzzzz\ea?\9b\9a\9a\9a\9a\9a\ea?\bb\ba\ba\ba\ba\ba\ea?\db\da\da\da\da\da\ea?\fb\fa\fa\fa\fa\fa\ea?\1b\1b\1b\1b\1b\1b\eb?;;;;;;\eb?[[[[[[\eb?{{{{{{\eb?\9c\9b\9b\9b\9b\9b\eb?\bc\bb\bb\bb\bb\bb\eb?\dc\db\db\db\db\db\eb?\fc\fb\fb\fb\fb\fb\eb?\1c\1c\1c\1c\1c\1c\ec?<<<<<<\ec?\\\\\\\\\\\\\ec?||||||\ec?\9d\9c\9c\9c\9c\9c\ec?\bd\bc\bc\bc\bc\bc\ec?\dd\dc\dc\dc\dc\dc\ec?\fd\fc\fc\fc\fc\fc\ec?\1d\1d\1d\1d\1d\1d\ed?======\ed?]]]]]]\ed?}}}}}}\ed?\9e\9d\9d\9d\9d\9d\ed?\be\bd\bd\bd\bd\bd\ed?\de\dd\dd\dd\dd\dd\ed?\fe\fd\fd\fd\fd\fd\ed?\1e\1e\1e\1e\1e\1e\ee?>>>>>>\ee?^^^^^^\ee?~~~~~~\ee?\9f\9e\9e\9e\9e\9e\ee?\bf\be\be\be\be\be\ee?\df\de\de\de\de\de\ee?\ff\fe\fe\fe\fe\fe\ee?\1f\1f\1f\1f\1f\1f\ef???????\ef?______\ef?\7f\7f\7f\7f\7f\7f\ef?\a0\9f\9f\9f\9f\9f\ef?\c0\bf\bf\bf\bf\bf\ef?\e0\df\df\df\df\df\ef?\00\00\00\00\00\00\f0?\00\00\00\00\00\00\f0?\e0\df\df\df\df\df\ef?\c0\bf\bf\bf\bf\bf\ef?\a0\9f\9f\9f\9f\9f\ef?\7f\7f\7f\7f\7f\7f\ef?______\ef???????\ef?\1f\1f\1f\1f\1f\1f\ef?\ff\fe\fe\fe\fe\fe\ee?\df\de\de\de\de\de\ee?\bf\be\be\be\be\be\ee?\9f\9e\9e\9e\9e\9e\ee?~~~~~~\ee?^^^^^^\ee?>>>>>>\ee?\1e\1e\1e\1e\1e\1e\ee?\fe\fd\fd\fd\fd\fd\ed?\de\dd\dd\dd\dd\dd\ed?\be\bd\bd\bd\bd\bd\ed?\9e\9d\9d\9d\9d\9d\ed?}}}}}}\ed?]]]]]]\ed?======\ed?\1d\1d\1d\1d\1d\1d\ed?\fd\fc\fc\fc\fc\fc\ec?\dd\dc\dc\dc\dc\dc\ec?\bd\bc\bc\bc\bc\bc\ec?\9d\9c\9c\9c\9c\9c\ec?||||||\ec?\\\\\\\\\\\\\ec?<<<<<<\ec?\1c\1c\1c\1c\1c\1c\ec?\fc\fb\fb\fb\fb\fb\eb?\dc\db\db\db\db\db\eb?\bc\bb\bb\bb\bb\bb\eb?\9c\9b\9b\9b\9b\9b\eb?{{{{{{\eb?[[[[[[\eb?;;;;;;\eb?\1b\1b\1b\1b\1b\1b\eb?\fb\fa\fa\fa\fa\fa\ea?\db\da\da\da\da\da\ea?\bb\ba\ba\ba\ba\ba\ea?\9b\9a\9a\9a\9a\9a\ea?zzzzzz\ea?ZZZZZZ\ea?::::::\ea?\1a\1a\1a\1a\1a\1a\ea?\fa\f9\f9\f9\f9\f9\e9?\da\d9\d9\d9\d9\d9\e9?\ba\b9\b9\b9\b9\b9\e9?\9a\99\99\99\99\99\e9?yyyyyy\e9?YYYYYY\e9?999999\e9?\19\19\19\19\19\19\e9?\f9\f8\f8\f8\f8\f8\e8?\d9\d8\d8\d8\d8\d8\e8?\b9\b8\b8\b8\b8\b8\e8?\99\98\98\98\98\98\e8?xxxxxx\e8?XXXXXX\e8?888888\e8?\18\18\18\18\18\18\e8?\f8\f7\f7\f7\f7\f7\e7?\d8\d7\d7\d7\d7\d7\e7?\b8\b7\b7\b7\b7\b7\e7?\98\97\97\97\97\97\e7?wwwwww\e7?WWWWWW\e7?777777\e7?\17\17\17\17\17\17\e7?\f7\f6\f6\f6\f6\f6\e6?\d7\d6\d6\d6\d6\d6\e6?\b7\b6\b6\b6\b6\b6\e6?\97\96\96\96\96\96\e6?vvvvvv\e6?VVVVVV\e6?666666\e6?\16\16\16\16\16\16\e6?\f6\f5\f5\f5\f5\f5\e5?\d6\d5\d5\d5\d5\d5\e5?\b6\b5\b5\b5\b5\b5\e5?\96\95\95\95\95\95\e5?uuuuuu\e5?UUUUUU\e5?555555\e5?\15\15\15\15\15\15\e5?\f5\f4\f4\f4\f4\f4\e4?\d5\d4\d4\d4\d4\d4\e4?\b5\b4\b4\b4\b4\b4\e4?\95\94\94\94\94\94\e4?tttttt\e4?TTTTTT\e4?444444\e4?\14\14\14\14\14\14\e4?\f4\f3\f3\f3\f3\f3\e3?\d4\d3\d3\d3\d3\d3\e3?\b4\b3\b3\b3\b3\b3\e3?\94\93\93\93\93\93\e3?ssssss\e3?SSSSSS\e3?333333\e3?\13\13\13\13\13\13\e3?\f3\f2\f2\f2\f2\f2\e2?\d3\d2\d2\d2\d2\d2\e2?\b3\b2\b2\b2\b2\b2\e2?\93\92\92\92\92\92\e2?rrrrrr\e2?RRRRRR\e2?222222\e2?\12\12\12\12\12\12\e2?\f2\f1\f1\f1\f1\f1\e1?\d2\d1\d1\d1\d1\d1\e1?\b2\b1\b1\b1\b1\b1\e1?\92\91\91\91\91\91\e1?qqqqqq\e1?QQQQQQ\e1?111111\e1?\11\11\11\11\11\11\e1?\f1\f0\f0\f0\f0\f0\e0?\d1\d0\d0\d0\d0\d0\e0?\b1\b0\b0\b0\b0\b0\e0?\91\90\90\90\90\90\e0?pppppp\e0?PPPPPP\e0?000000\e0?\10\10\10\10\10\10\e0?\00\00\00\00\00\00\00\00\00\00\00\00")
 (data (i32.const 1920002668) ",\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00")
 (data (i32.const 1920002716) "<\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00$\00\00\00~\00l\00i\00b\00/\00t\00y\00p\00e\00d\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (data (i32.const 1920002784) "\08\00\00\00 \00\00\00\00\00\00\00 \00\00\00\00\00\00\00\00\00\00\00\00\00\00\00$\01\00\00\00\00\00\00\01\19\00\00\02\00\00\00\02\1a\00\00\00\00\00\00\02\t\00\00\00\00\00\00A\00\00\00\02\00\00\00")
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $assembly/index/viewLength (mut i32) (i32.const 0))
 (global $assembly/index/channelLength (mut i32) (i32.const 0))
 (global $assembly/index/width (mut i32) (i32.const 0))
 (global $assembly/index/height (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/total (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/threshold (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/state (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/visitCount (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/pinSpace (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/iter (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/toSpace (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/white (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/fromSpace (mut i32) (i32.const 0))
 (global $~lib/rt/tlsf/ROOT (mut i32) (i32.const 0))
 (global $assembly/index/viewOffsets (mut i32) (i32.const 0))
 (global $assembly/index/countOffsets (mut i32) (i32.const 0))
 (global $assembly/index/displayCountOffsets (mut i32) (i32.const 0))
 (global $assembly/index/curve (mut i32) (i32.const 0))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 1920019236))
 (export "initData" (func $assembly/index/initData))
 (export "process" (func $assembly/index/process))
 (export "calculateClips" (func $assembly/index/calculateClips))
 (export "grayWorld" (func $assembly/index/grayWorld))
 (export "calculateCounts" (func $assembly/index/calculateCounts))
 (export "calculateDisplayCounts" (func $assembly/index/calculateDisplayCounts))
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/rt/itcms/visitRoots
  (local $0 i32)
  (local $1 i32)
  global.get $assembly/index/viewOffsets
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $assembly/index/countOffsets
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $assembly/index/displayCountOffsets
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $assembly/index/curve
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  i32.const 1920000336
  call $~lib/rt/itcms/__visit
  i32.const 1920000032
  call $~lib/rt/itcms/__visit
  i32.const 1920000144
  call $~lib/rt/itcms/__visit
  global.get $~lib/rt/itcms/pinSpace
  local.tee $1
  i32.load offset=4
  i32.const -4
  i32.and
  local.set $0
  loop $while-continue|0
   local.get $0
   local.get $1
   i32.ne
   if
    local.get $0
    i32.load offset=4
    i32.const 3
    i32.and
    i32.const 3
    i32.ne
    if
     i32.const 0
     i32.const 1920000208
     i32.const 159
     i32.const 16
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    i32.const 20
    i32.add
    call $~lib/rt/__visit_members
    local.get $0
    i32.load offset=4
    i32.const -4
    i32.and
    local.set $0
    br $while-continue|0
   end
  end
 )
 (func $~lib/rt/itcms/Object#makeGray (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  global.get $~lib/rt/itcms/iter
  i32.eq
  if
   local.get $0
   i32.load offset=8
   local.tee $1
   i32.eqz
   if
    i32.const 0
    i32.const 1920000208
    i32.const 147
    i32.const 30
    call $~lib/builtins/abort
    unreachable
   end
   local.get $1
   global.set $~lib/rt/itcms/iter
  end
  block $__inlined_func$~lib/rt/itcms/Object#unlink
   local.get $0
   i32.load offset=4
   i32.const -4
   i32.and
   local.tee $2
   i32.eqz
   if
    i32.const 0
    local.get $0
    i32.const 1920019236
    i32.lt_u
    local.get $0
    i32.load offset=8
    select
    i32.eqz
    if
     i32.const 0
     i32.const 1920000208
     i32.const 127
     i32.const 18
     call $~lib/builtins/abort
     unreachable
    end
    br $__inlined_func$~lib/rt/itcms/Object#unlink
   end
   local.get $0
   i32.load offset=8
   local.tee $1
   i32.eqz
   if
    i32.const 0
    i32.const 1920000208
    i32.const 131
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
   local.get $2
   local.get $1
   i32.store offset=8
   local.get $1
   local.get $2
   local.get $1
   i32.load offset=4
   i32.const 3
   i32.and
   i32.or
   i32.store offset=4
  end
  global.get $~lib/rt/itcms/toSpace
  local.set $2
  local.get $0
  i32.load offset=12
  local.tee $1
  i32.const 1
  i32.le_u
  if (result i32)
   i32.const 1
  else
   local.get $1
   i32.const 1920002784
   i32.load
   i32.gt_u
   if
    i32.const 1920000336
    i32.const 1920000400
    i32.const 22
    i32.const 28
    call $~lib/builtins/abort
    unreachable
   end
   local.get $1
   i32.const 3
   i32.shl
   i32.const 1920002788
   i32.add
   i32.load
   i32.const 32
   i32.and
  end
  if (result i32)
   global.get $~lib/rt/itcms/white
   i32.eqz
  else
   i32.const 2
  end
  local.set $3
  local.get $2
  i32.load offset=8
  local.set $1
  local.get $0
  local.get $2
  local.get $3
  i32.or
  i32.store offset=4
  local.get $0
  local.get $1
  i32.store offset=8
  local.get $1
  local.get $0
  local.get $1
  i32.load offset=4
  i32.const 3
  i32.and
  i32.or
  i32.store offset=4
  local.get $2
  local.get $0
  i32.store offset=8
 )
 (func $~lib/rt/itcms/__visit (param $0 i32)
  local.get $0
  i32.eqz
  if
   return
  end
  global.get $~lib/rt/itcms/white
  local.get $0
  i32.const 20
  i32.sub
  local.tee $0
  i32.load offset=4
  i32.const 3
  i32.and
  i32.eq
  if
   local.get $0
   call $~lib/rt/itcms/Object#makeGray
   global.get $~lib/rt/itcms/visitCount
   i32.const 1
   i32.add
   global.set $~lib/rt/itcms/visitCount
  end
 )
 (func $~lib/rt/tlsf/removeBlock (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $1
  i32.load
  local.tee $2
  i32.const 1
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 1920000480
   i32.const 268
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  i32.const -4
  i32.and
  local.tee $2
  i32.const 12
  i32.lt_u
  if
   i32.const 0
   i32.const 1920000480
   i32.const 270
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  i32.const 256
  i32.lt_u
  if
   local.get $2
   i32.const 4
   i32.shr_u
   local.set $2
  else
   i32.const 31
   local.get $2
   i32.const 1073741820
   local.get $2
   i32.const 1073741820
   i32.lt_u
   select
   local.tee $2
   i32.clz
   i32.sub
   local.set $3
   local.get $2
   local.get $3
   i32.const 4
   i32.sub
   i32.shr_u
   i32.const 16
   i32.xor
   local.set $2
   local.get $3
   i32.const 7
   i32.sub
   local.set $3
  end
  local.get $2
  i32.const 16
  i32.lt_u
  i32.const 0
  local.get $3
  i32.const 23
  i32.lt_u
  select
  i32.eqz
  if
   i32.const 0
   i32.const 1920000480
   i32.const 284
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.load offset=8
  local.set $4
  local.get $1
  i32.load offset=4
  local.tee $5
  if
   local.get $5
   local.get $4
   i32.store offset=8
  end
  local.get $4
  if
   local.get $4
   local.get $5
   i32.store offset=4
  end
  local.get $1
  local.get $0
  local.get $2
  local.get $3
  i32.const 4
  i32.shl
  i32.add
  i32.const 2
  i32.shl
  i32.add
  i32.load offset=96
  i32.eq
  if
   local.get $0
   local.get $2
   local.get $3
   i32.const 4
   i32.shl
   i32.add
   i32.const 2
   i32.shl
   i32.add
   local.get $4
   i32.store offset=96
   local.get $4
   i32.eqz
   if
    local.get $0
    local.get $3
    i32.const 2
    i32.shl
    i32.add
    local.tee $4
    i32.load offset=4
    i32.const -2
    local.get $2
    i32.rotl
    i32.and
    local.set $1
    local.get $4
    local.get $1
    i32.store offset=4
    local.get $1
    i32.eqz
    if
     local.get $0
     local.get $0
     i32.load
     i32.const -2
     local.get $3
     i32.rotl
     i32.and
     i32.store
    end
   end
  end
 )
 (func $~lib/rt/tlsf/insertBlock (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  local.get $1
  i32.eqz
  if
   i32.const 0
   i32.const 1920000480
   i32.const 201
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.load
  local.tee $3
  i32.const 1
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 1920000480
   i32.const 203
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 4
  i32.add
  local.get $1
  i32.load
  i32.const -4
  i32.and
  i32.add
  local.tee $4
  i32.load
  local.tee $2
  i32.const 1
  i32.and
  if
   local.get $0
   local.get $4
   call $~lib/rt/tlsf/removeBlock
   local.get $1
   local.get $3
   i32.const 4
   i32.add
   local.get $2
   i32.const -4
   i32.and
   i32.add
   local.tee $3
   i32.store
   local.get $1
   i32.const 4
   i32.add
   local.get $1
   i32.load
   i32.const -4
   i32.and
   i32.add
   local.tee $4
   i32.load
   local.set $2
  end
  local.get $3
  i32.const 2
  i32.and
  if
   local.get $1
   i32.const 4
   i32.sub
   i32.load
   local.tee $1
   i32.load
   local.tee $6
   i32.const 1
   i32.and
   i32.eqz
   if
    i32.const 0
    i32.const 1920000480
    i32.const 221
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   local.get $1
   call $~lib/rt/tlsf/removeBlock
   local.get $1
   local.get $6
   i32.const 4
   i32.add
   local.get $3
   i32.const -4
   i32.and
   i32.add
   local.tee $3
   i32.store
  end
  local.get $4
  local.get $2
  i32.const 2
  i32.or
  i32.store
  local.get $3
  i32.const -4
  i32.and
  local.tee $3
  i32.const 12
  i32.lt_u
  if
   i32.const 0
   i32.const 1920000480
   i32.const 233
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $3
  local.get $1
  i32.const 4
  i32.add
  i32.add
  local.get $4
  i32.ne
  if
   i32.const 0
   i32.const 1920000480
   i32.const 234
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  i32.const 4
  i32.sub
  local.get $1
  i32.store
  local.get $3
  i32.const 256
  i32.lt_u
  if (result i32)
   local.get $3
   i32.const 4
   i32.shr_u
  else
   i32.const 31
   local.get $3
   i32.const 1073741820
   local.get $3
   i32.const 1073741820
   i32.lt_u
   select
   local.tee $3
   i32.clz
   i32.sub
   local.tee $4
   i32.const 7
   i32.sub
   local.set $5
   local.get $3
   local.get $4
   i32.const 4
   i32.sub
   i32.shr_u
   i32.const 16
   i32.xor
  end
  local.tee $3
  i32.const 16
  i32.lt_u
  i32.const 0
  local.get $5
  i32.const 23
  i32.lt_u
  select
  i32.eqz
  if
   i32.const 0
   i32.const 1920000480
   i32.const 251
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $3
  local.get $5
  i32.const 4
  i32.shl
  i32.add
  i32.const 2
  i32.shl
  i32.add
  i32.load offset=96
  local.set $4
  local.get $1
  i32.const 0
  i32.store offset=4
  local.get $1
  local.get $4
  i32.store offset=8
  local.get $4
  if
   local.get $4
   local.get $1
   i32.store offset=4
  end
  local.get $0
  local.get $3
  local.get $5
  i32.const 4
  i32.shl
  i32.add
  i32.const 2
  i32.shl
  i32.add
  local.get $1
  i32.store offset=96
  local.get $0
  local.get $0
  i32.load
  i32.const 1
  local.get $5
  i32.shl
  i32.or
  i32.store
  local.get $0
  local.get $5
  i32.const 2
  i32.shl
  i32.add
  local.tee $0
  local.get $0
  i32.load offset=4
  i32.const 1
  local.get $3
  i32.shl
  i32.or
  i32.store offset=4
 )
 (func $~lib/rt/tlsf/addMemory (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $1
  local.get $2
  i32.gt_u
  if
   i32.const 0
   i32.const 1920000480
   i32.const 377
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 19
  i32.add
  i32.const -16
  i32.and
  i32.const 4
  i32.sub
  local.set $1
  local.get $2
  i32.const -16
  i32.and
  local.get $0
  i32.load offset=1568
  local.tee $2
  if
   local.get $1
   local.get $2
   i32.const 4
   i32.add
   i32.lt_u
   if
    i32.const 0
    i32.const 1920000480
    i32.const 384
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
   local.get $2
   local.get $1
   i32.const 16
   i32.sub
   i32.eq
   if
    local.get $2
    i32.load
    local.set $4
    local.get $1
    i32.const 16
    i32.sub
    local.set $1
   end
  else
   local.get $1
   local.get $0
   i32.const 1572
   i32.add
   i32.lt_u
   if
    i32.const 0
    i32.const 1920000480
    i32.const 397
    i32.const 5
    call $~lib/builtins/abort
    unreachable
   end
  end
  local.get $1
  i32.sub
  local.tee $2
  i32.const 20
  i32.lt_u
  if
   return
  end
  local.get $1
  local.get $4
  i32.const 2
  i32.and
  local.get $2
  i32.const 8
  i32.sub
  local.tee $2
  i32.const 1
  i32.or
  i32.or
  i32.store
  local.get $1
  i32.const 0
  i32.store offset=4
  local.get $1
  i32.const 0
  i32.store offset=8
  local.get $2
  local.get $1
  i32.const 4
  i32.add
  i32.add
  local.tee $2
  i32.const 2
  i32.store
  local.get $0
  local.get $2
  i32.store offset=1568
  local.get $0
  local.get $1
  call $~lib/rt/tlsf/insertBlock
 )
 (func $~lib/rt/tlsf/initialize
  (local $0 i32)
  (local $1 i32)
  memory.size
  local.tee $0
  i32.const 29298
  i32.lt_s
  if (result i32)
   i32.const 29298
   local.get $0
   i32.sub
   memory.grow
   i32.const 0
   i32.lt_s
  else
   i32.const 0
  end
  if
   unreachable
  end
  i32.const 1920019248
  i32.const 0
  i32.store
  i32.const 1920020816
  i32.const 0
  i32.store
  loop $for-loop|0
   local.get $1
   i32.const 23
   i32.lt_u
   if
    local.get $1
    i32.const 2
    i32.shl
    i32.const 1920019248
    i32.add
    i32.const 0
    i32.store offset=4
    i32.const 0
    local.set $0
    loop $for-loop|1
     local.get $0
     i32.const 16
     i32.lt_u
     if
      local.get $0
      local.get $1
      i32.const 4
      i32.shl
      i32.add
      i32.const 2
      i32.shl
      i32.const 1920019248
      i32.add
      i32.const 0
      i32.store offset=96
      local.get $0
      i32.const 1
      i32.add
      local.set $0
      br $for-loop|1
     end
    end
    local.get $1
    i32.const 1
    i32.add
    local.set $1
    br $for-loop|0
   end
  end
  i32.const 1920019248
  i32.const 1920020820
  memory.size
  i32.const 16
  i32.shl
  call $~lib/rt/tlsf/addMemory
  i32.const 1920019248
  global.set $~lib/rt/tlsf/ROOT
 )
 (func $~lib/rt/itcms/step (result i32)
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  block $folding-inner0
   block $break|0
    block $case2|0
     block $case1|0
      block $case0|0
       global.get $~lib/rt/itcms/state
       br_table $case0|0 $case1|0 $case2|0 $break|0
      end
      i32.const 1
      global.set $~lib/rt/itcms/state
      i32.const 0
      global.set $~lib/rt/itcms/visitCount
      call $~lib/rt/itcms/visitRoots
      global.get $~lib/rt/itcms/toSpace
      global.set $~lib/rt/itcms/iter
      br $folding-inner0
     end
     global.get $~lib/rt/itcms/white
     i32.eqz
     local.set $1
     global.get $~lib/rt/itcms/iter
     i32.load offset=4
     i32.const -4
     i32.and
     local.set $0
     loop $while-continue|1
      local.get $0
      global.get $~lib/rt/itcms/toSpace
      i32.ne
      if
       local.get $0
       global.set $~lib/rt/itcms/iter
       local.get $1
       local.get $0
       i32.load offset=4
       i32.const 3
       i32.and
       i32.ne
       if
        local.get $0
        local.get $1
        local.get $0
        i32.load offset=4
        i32.const -4
        i32.and
        i32.or
        i32.store offset=4
        i32.const 0
        global.set $~lib/rt/itcms/visitCount
        local.get $0
        i32.const 20
        i32.add
        call $~lib/rt/__visit_members
        br $folding-inner0
       end
       local.get $0
       i32.load offset=4
       i32.const -4
       i32.and
       local.set $0
       br $while-continue|1
      end
     end
     i32.const 0
     global.set $~lib/rt/itcms/visitCount
     call $~lib/rt/itcms/visitRoots
     global.get $~lib/rt/itcms/toSpace
     global.get $~lib/rt/itcms/iter
     i32.load offset=4
     i32.const -4
     i32.and
     i32.eq
     if
      global.get $~lib/memory/__stack_pointer
      local.set $0
      loop $while-continue|0
       local.get $0
       i32.const 1920019236
       i32.lt_u
       if
        local.get $0
        i32.load
        call $~lib/rt/itcms/__visit
        local.get $0
        i32.const 4
        i32.add
        local.set $0
        br $while-continue|0
       end
      end
      global.get $~lib/rt/itcms/iter
      i32.load offset=4
      i32.const -4
      i32.and
      local.set $0
      loop $while-continue|2
       local.get $0
       global.get $~lib/rt/itcms/toSpace
       i32.ne
       if
        local.get $1
        local.get $0
        i32.load offset=4
        i32.const 3
        i32.and
        i32.ne
        if
         local.get $0
         local.get $1
         local.get $0
         i32.load offset=4
         i32.const -4
         i32.and
         i32.or
         i32.store offset=4
         local.get $0
         i32.const 20
         i32.add
         call $~lib/rt/__visit_members
        end
        local.get $0
        i32.load offset=4
        i32.const -4
        i32.and
        local.set $0
        br $while-continue|2
       end
      end
      global.get $~lib/rt/itcms/fromSpace
      local.set $0
      global.get $~lib/rt/itcms/toSpace
      global.set $~lib/rt/itcms/fromSpace
      local.get $0
      global.set $~lib/rt/itcms/toSpace
      local.get $1
      global.set $~lib/rt/itcms/white
      local.get $0
      i32.load offset=4
      i32.const -4
      i32.and
      global.set $~lib/rt/itcms/iter
      i32.const 2
      global.set $~lib/rt/itcms/state
     end
     br $folding-inner0
    end
    global.get $~lib/rt/itcms/iter
    local.tee $0
    global.get $~lib/rt/itcms/toSpace
    i32.ne
    if
     local.get $0
     i32.load offset=4
     i32.const -4
     i32.and
     global.set $~lib/rt/itcms/iter
     global.get $~lib/rt/itcms/white
     i32.eqz
     local.get $0
     i32.load offset=4
     i32.const 3
     i32.and
     i32.ne
     if
      i32.const 0
      i32.const 1920000208
      i32.const 228
      i32.const 20
      call $~lib/builtins/abort
      unreachable
     end
     local.get $0
     i32.const 1920019236
     i32.lt_u
     if
      local.get $0
      i32.const 0
      i32.store offset=4
      local.get $0
      i32.const 0
      i32.store offset=8
     else
      global.get $~lib/rt/itcms/total
      local.get $0
      i32.load
      i32.const -4
      i32.and
      i32.const 4
      i32.add
      i32.sub
      global.set $~lib/rt/itcms/total
      local.get $0
      i32.const 4
      i32.add
      local.tee $0
      i32.const 1920019236
      i32.ge_u
      if
       global.get $~lib/rt/tlsf/ROOT
       i32.eqz
       if
        call $~lib/rt/tlsf/initialize
       end
       global.get $~lib/rt/tlsf/ROOT
       local.get $0
       i32.const 4
       i32.sub
       local.set $1
       local.get $0
       i32.const 15
       i32.and
       i32.const 1
       local.get $0
       select
       if (result i32)
        i32.const 1
       else
        local.get $1
        i32.load
        i32.const 1
        i32.and
       end
       if
        i32.const 0
        i32.const 1920000480
        i32.const 559
        i32.const 3
        call $~lib/builtins/abort
        unreachable
       end
       local.get $1
       local.tee $0
       i32.load
       i32.const 1
       i32.or
       local.set $1
       local.get $0
       local.get $1
       i32.store
       local.get $0
       call $~lib/rt/tlsf/insertBlock
      end
     end
     i32.const 10
     return
    end
    global.get $~lib/rt/itcms/toSpace
    local.tee $0
    local.get $0
    i32.store offset=4
    global.get $~lib/rt/itcms/toSpace
    local.tee $0
    local.get $0
    i32.store offset=8
    i32.const 0
    global.set $~lib/rt/itcms/state
   end
   i32.const 0
   return
  end
  global.get $~lib/rt/itcms/visitCount
 )
 (func $~lib/rt/tlsf/searchBlock (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  local.get $1
  i32.const 256
  i32.lt_u
  if
   local.get $1
   i32.const 4
   i32.shr_u
   local.set $1
  else
   local.get $1
   i32.const 536870910
   i32.lt_u
   if
    local.get $1
    i32.const 1
    i32.const 27
    local.get $1
    i32.clz
    i32.sub
    i32.shl
    i32.add
    i32.const 1
    i32.sub
    local.set $1
   end
   local.get $1
   i32.const 31
   local.get $1
   i32.clz
   i32.sub
   local.tee $2
   i32.const 4
   i32.sub
   i32.shr_u
   i32.const 16
   i32.xor
   local.set $1
   local.get $2
   i32.const 7
   i32.sub
   local.set $2
  end
  local.get $1
  i32.const 16
  i32.lt_u
  i32.const 0
  local.get $2
  i32.const 23
  i32.lt_u
  select
  i32.eqz
  if
   i32.const 0
   i32.const 1920000480
   i32.const 330
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $2
  i32.const 2
  i32.shl
  i32.add
  i32.load offset=4
  i32.const -1
  local.get $1
  i32.shl
  i32.and
  local.tee $1
  if (result i32)
   local.get $0
   local.get $1
   i32.ctz
   local.get $2
   i32.const 4
   i32.shl
   i32.add
   i32.const 2
   i32.shl
   i32.add
   i32.load offset=96
  else
   local.get $0
   i32.load
   i32.const -1
   local.get $2
   i32.const 1
   i32.add
   i32.shl
   i32.and
   local.tee $1
   if (result i32)
    local.get $0
    local.get $1
    i32.ctz
    local.tee $1
    i32.const 2
    i32.shl
    i32.add
    i32.load offset=4
    local.tee $2
    i32.eqz
    if
     i32.const 0
     i32.const 1920000480
     i32.const 343
     i32.const 18
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    local.get $2
    i32.ctz
    local.get $1
    i32.const 4
    i32.shl
    i32.add
    i32.const 2
    i32.shl
    i32.add
    i32.load offset=96
   else
    i32.const 0
   end
  end
 )
 (func $~lib/memory/memory.fill (param $0 i32) (param $1 i32)
  (local $2 i32)
  block $~lib/util/memory/memset|inlined.0
   local.get $1
   i32.eqz
   br_if $~lib/util/memory/memset|inlined.0
   local.get $0
   i32.const 0
   i32.store8
   local.get $0
   local.get $1
   i32.add
   local.tee $2
   i32.const 1
   i32.sub
   i32.const 0
   i32.store8
   local.get $1
   i32.const 2
   i32.le_u
   br_if $~lib/util/memory/memset|inlined.0
   local.get $0
   i32.const 0
   i32.store8 offset=1
   local.get $0
   i32.const 0
   i32.store8 offset=2
   local.get $2
   i32.const 2
   i32.sub
   i32.const 0
   i32.store8
   local.get $2
   i32.const 3
   i32.sub
   i32.const 0
   i32.store8
   local.get $1
   i32.const 6
   i32.le_u
   br_if $~lib/util/memory/memset|inlined.0
   local.get $0
   i32.const 0
   i32.store8 offset=3
   local.get $2
   i32.const 4
   i32.sub
   i32.const 0
   i32.store8
   local.get $1
   i32.const 8
   i32.le_u
   br_if $~lib/util/memory/memset|inlined.0
   local.get $0
   i32.const 0
   local.get $0
   i32.sub
   i32.const 3
   i32.and
   local.tee $2
   i32.add
   local.tee $0
   i32.const 0
   i32.store
   local.get $0
   local.get $1
   local.get $2
   i32.sub
   i32.const -4
   i32.and
   local.tee $2
   i32.add
   local.tee $1
   i32.const 4
   i32.sub
   i32.const 0
   i32.store
   local.get $2
   i32.const 8
   i32.le_u
   br_if $~lib/util/memory/memset|inlined.0
   local.get $0
   i32.const 0
   i32.store offset=4
   local.get $0
   i32.const 0
   i32.store offset=8
   local.get $1
   i32.const 12
   i32.sub
   i32.const 0
   i32.store
   local.get $1
   i32.const 8
   i32.sub
   i32.const 0
   i32.store
   local.get $2
   i32.const 24
   i32.le_u
   br_if $~lib/util/memory/memset|inlined.0
   local.get $0
   i32.const 0
   i32.store offset=12
   local.get $0
   i32.const 0
   i32.store offset=16
   local.get $0
   i32.const 0
   i32.store offset=20
   local.get $0
   i32.const 0
   i32.store offset=24
   local.get $1
   i32.const 28
   i32.sub
   i32.const 0
   i32.store
   local.get $1
   i32.const 24
   i32.sub
   i32.const 0
   i32.store
   local.get $1
   i32.const 20
   i32.sub
   i32.const 0
   i32.store
   local.get $1
   i32.const 16
   i32.sub
   i32.const 0
   i32.store
   local.get $0
   local.get $0
   i32.const 4
   i32.and
   i32.const 24
   i32.add
   local.tee $1
   i32.add
   local.set $0
   local.get $2
   local.get $1
   i32.sub
   local.set $1
   loop $while-continue|0
    local.get $1
    i32.const 32
    i32.ge_u
    if
     local.get $0
     i64.const 0
     i64.store
     local.get $0
     i64.const 0
     i64.store offset=8
     local.get $0
     i64.const 0
     i64.store offset=16
     local.get $0
     i64.const 0
     i64.store offset=24
     local.get $1
     i32.const 32
     i32.sub
     local.set $1
     local.get $0
     i32.const 32
     i32.add
     local.set $0
     br $while-continue|0
    end
   end
  end
 )
 (func $~lib/rt/itcms/__new (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  local.get $0
  i32.const 1073741804
  i32.ge_u
  if
   i32.const 1920000144
   i32.const 1920000208
   i32.const 260
   i32.const 31
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/rt/itcms/total
  global.get $~lib/rt/itcms/threshold
  i32.ge_u
  if
   block $__inlined_func$~lib/rt/itcms/interrupt
    i32.const 2048
    local.set $3
    loop $do-continue|0
     local.get $3
     call $~lib/rt/itcms/step
     i32.sub
     local.set $3
     global.get $~lib/rt/itcms/state
     i32.eqz
     if
      global.get $~lib/rt/itcms/total
      i64.extend_i32_u
      i64.const 200
      i64.mul
      i64.const 100
      i64.div_u
      i32.wrap_i64
      i32.const 1024
      i32.add
      global.set $~lib/rt/itcms/threshold
      br $__inlined_func$~lib/rt/itcms/interrupt
     end
     local.get $3
     i32.const 0
     i32.gt_s
     br_if $do-continue|0
    end
    global.get $~lib/rt/itcms/total
    local.tee $3
    local.get $3
    global.get $~lib/rt/itcms/threshold
    i32.sub
    i32.const 1024
    i32.lt_u
    i32.const 10
    i32.shl
    i32.add
    global.set $~lib/rt/itcms/threshold
   end
  end
  local.get $0
  i32.const 16
  i32.add
  local.set $6
  global.get $~lib/rt/tlsf/ROOT
  i32.eqz
  if
   call $~lib/rt/tlsf/initialize
  end
  global.get $~lib/rt/tlsf/ROOT
  local.get $6
  i32.const 1073741820
  i32.gt_u
  if
   i32.const 1920000144
   i32.const 1920000480
   i32.const 458
   i32.const 29
   call $~lib/builtins/abort
   unreachable
  end
  local.tee $2
  local.get $6
  i32.const 12
  i32.le_u
  if (result i32)
   i32.const 12
  else
   local.get $6
   i32.const 19
   i32.add
   i32.const -16
   i32.and
   i32.const 4
   i32.sub
  end
  local.tee $3
  call $~lib/rt/tlsf/searchBlock
  local.tee $6
  i32.eqz
  if
   local.get $3
   i32.const 536870910
   i32.lt_u
   if (result i32)
    local.get $3
    i32.const 1
    i32.const 27
    local.get $3
    i32.clz
    i32.sub
    i32.shl
    i32.const 1
    i32.sub
    i32.add
   else
    local.get $3
   end
   i32.const 4
   memory.size
   local.tee $6
   i32.const 16
   i32.shl
   i32.const 4
   i32.sub
   local.get $2
   i32.load offset=1568
   i32.ne
   i32.shl
   i32.add
   i32.const 65535
   i32.add
   i32.const -65536
   i32.and
   i32.const 16
   i32.shr_u
   local.set $5
   local.get $6
   local.get $5
   local.get $5
   local.get $6
   i32.lt_s
   select
   memory.grow
   i32.const 0
   i32.lt_s
   if
    local.get $5
    memory.grow
    i32.const 0
    i32.lt_s
    if
     unreachable
    end
   end
   local.get $2
   local.get $6
   i32.const 16
   i32.shl
   memory.size
   i32.const 16
   i32.shl
   call $~lib/rt/tlsf/addMemory
   local.get $2
   local.get $3
   call $~lib/rt/tlsf/searchBlock
   local.tee $6
   i32.eqz
   if
    i32.const 0
    i32.const 1920000480
    i32.const 496
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
  end
  local.get $3
  local.get $6
  i32.load
  i32.const -4
  i32.and
  i32.gt_u
  if
   i32.const 0
   i32.const 1920000480
   i32.const 498
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  local.get $6
  call $~lib/rt/tlsf/removeBlock
  local.get $6
  i32.load
  local.set $5
  local.get $3
  i32.const 4
  i32.add
  i32.const 15
  i32.and
  if
   i32.const 0
   i32.const 1920000480
   i32.const 357
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $5
  i32.const -4
  i32.and
  local.get $3
  i32.sub
  local.tee $4
  i32.const 16
  i32.ge_u
  if
   local.get $6
   local.get $3
   local.get $5
   i32.const 2
   i32.and
   i32.or
   i32.store
   local.get $3
   local.get $6
   i32.const 4
   i32.add
   i32.add
   local.tee $3
   local.get $4
   i32.const 4
   i32.sub
   i32.const 1
   i32.or
   i32.store
   local.get $2
   local.get $3
   call $~lib/rt/tlsf/insertBlock
  else
   local.get $6
   local.get $5
   i32.const -2
   i32.and
   i32.store
   local.get $6
   i32.const 4
   i32.add
   local.tee $3
   local.get $6
   i32.load
   i32.const -4
   i32.and
   i32.add
   local.get $3
   local.get $6
   i32.load
   i32.const -4
   i32.and
   i32.add
   i32.load
   i32.const -3
   i32.and
   i32.store
  end
  local.get $6
  local.get $1
  i32.store offset=12
  local.get $6
  local.get $0
  i32.store offset=16
  global.get $~lib/rt/itcms/fromSpace
  local.tee $3
  i32.load offset=8
  local.set $1
  local.get $6
  local.get $3
  global.get $~lib/rt/itcms/white
  i32.or
  i32.store offset=4
  local.get $6
  local.get $1
  i32.store offset=8
  local.get $1
  local.get $6
  local.get $1
  i32.load offset=4
  i32.const 3
  i32.and
  i32.or
  i32.store offset=4
  local.get $3
  local.get $6
  i32.store offset=8
  global.get $~lib/rt/itcms/total
  local.get $6
  i32.load
  i32.const -4
  i32.and
  i32.const 4
  i32.add
  i32.add
  global.set $~lib/rt/itcms/total
  local.get $6
  i32.const 20
  i32.add
  local.tee $1
  local.get $0
  call $~lib/memory/memory.fill
  local.get $1
 )
 (func $~lib/rt/itcms/__link (param $0 i32) (param $1 i32)
  local.get $1
  i32.eqz
  if
   return
  end
  local.get $0
  i32.eqz
  if
   i32.const 0
   i32.const 1920000208
   i32.const 294
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/rt/itcms/white
  local.get $1
  i32.const 20
  i32.sub
  local.tee $1
  i32.load offset=4
  i32.const 3
  i32.and
  i32.eq
  if
   local.get $0
   i32.const 20
   i32.sub
   i32.load offset=4
   i32.const 3
   i32.and
   local.tee $0
   global.get $~lib/rt/itcms/white
   i32.eqz
   i32.eq
   if
    local.get $1
    call $~lib/rt/itcms/Object#makeGray
   else
    global.get $~lib/rt/itcms/state
    i32.const 1
    i32.eq
    i32.const 0
    local.get $0
    i32.const 3
    i32.eq
    select
    if
     local.get $1
     call $~lib/rt/itcms/Object#makeGray
    end
   end
  end
 )
 (func $~lib/staticarray/StaticArray<u32>#__set (param $0 i32) (param $1 i32) (param $2 i32)
  local.get $1
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.ge_u
  if
   i32.const 1920000336
   i32.const 1920000080
   i32.const 128
   i32.const 41
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $1
  i32.const 2
  i32.shl
  i32.add
  local.get $2
  i32.store
 )
 (func $~lib/util/memory/memcpy (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  i32.const 2048
  local.set $4
  i32.const 1920000608
  local.set $1
  loop $while-continue|0
   local.get $1
   i32.const 3
   i32.and
   i32.const 0
   local.get $4
   select
   if
    local.get $0
    local.tee $2
    i32.const 1
    i32.add
    local.set $0
    local.get $1
    local.tee $3
    i32.const 1
    i32.add
    local.set $1
    local.get $2
    local.get $3
    i32.load8_u
    i32.store8
    local.get $4
    i32.const 1
    i32.sub
    local.set $4
    br $while-continue|0
   end
  end
  local.get $0
  i32.const 3
  i32.and
  i32.eqz
  if
   loop $while-continue|1
    local.get $4
    i32.const 16
    i32.ge_u
    if
     local.get $0
     local.get $1
     i32.load
     i32.store
     local.get $0
     i32.const 4
     i32.add
     local.get $1
     i32.const 4
     i32.add
     i32.load
     i32.store
     local.get $0
     i32.const 8
     i32.add
     local.get $1
     i32.const 8
     i32.add
     i32.load
     i32.store
     local.get $0
     i32.const 12
     i32.add
     local.get $1
     i32.const 12
     i32.add
     i32.load
     i32.store
     local.get $1
     i32.const 16
     i32.add
     local.set $1
     local.get $0
     i32.const 16
     i32.add
     local.set $0
     local.get $4
     i32.const 16
     i32.sub
     local.set $4
     br $while-continue|1
    end
   end
   local.get $4
   i32.const 8
   i32.and
   if
    local.get $0
    local.get $1
    i32.load
    i32.store
    local.get $0
    i32.const 4
    i32.add
    local.get $1
    i32.const 4
    i32.add
    i32.load
    i32.store
    local.get $1
    i32.const 8
    i32.add
    local.set $1
    local.get $0
    i32.const 8
    i32.add
    local.set $0
   end
   local.get $4
   i32.const 4
   i32.and
   if
    local.get $0
    local.get $1
    i32.load
    i32.store
    local.get $1
    i32.const 4
    i32.add
    local.set $1
    local.get $0
    i32.const 4
    i32.add
    local.set $0
   end
   local.get $4
   i32.const 2
   i32.and
   if
    local.get $0
    local.get $1
    i32.load16_u
    i32.store16
    local.get $1
    i32.const 2
    i32.add
    local.set $1
    local.get $0
    i32.const 2
    i32.add
    local.set $0
   end
   local.get $4
   i32.const 1
   i32.and
   if
    local.get $0
    local.get $1
    i32.load8_u
    i32.store8
   end
   return
  end
  local.get $4
  i32.const 32
  i32.ge_u
  if
   block $break|2
    block $case2|2
     block $case1|2
      block $case0|2
       local.get $0
       i32.const 3
       i32.and
       i32.const 1
       i32.sub
       br_table $case0|2 $case1|2 $case2|2 $break|2
      end
      local.get $1
      i32.load
      local.set $5
      local.get $0
      local.get $1
      i32.load8_u
      i32.store8
      local.get $0
      i32.const 1
      i32.add
      local.tee $0
      local.get $1
      i32.const 1
      i32.add
      local.tee $1
      i32.load8_u
      i32.store8
      local.get $0
      i32.const 1
      i32.add
      local.tee $2
      i32.const 1
      i32.add
      local.set $0
      local.get $1
      i32.const 1
      i32.add
      local.tee $3
      i32.const 1
      i32.add
      local.set $1
      local.get $2
      local.get $3
      i32.load8_u
      i32.store8
      local.get $4
      i32.const 3
      i32.sub
      local.set $4
      loop $while-continue|3
       local.get $4
       i32.const 17
       i32.ge_u
       if
        local.get $0
        local.get $1
        i32.const 1
        i32.add
        i32.load
        local.tee $2
        i32.const 8
        i32.shl
        local.get $5
        i32.const 24
        i32.shr_u
        i32.or
        i32.store
        local.get $0
        i32.const 4
        i32.add
        local.get $2
        i32.const 24
        i32.shr_u
        local.get $1
        i32.const 5
        i32.add
        i32.load
        local.tee $2
        i32.const 8
        i32.shl
        i32.or
        i32.store
        local.get $0
        i32.const 8
        i32.add
        local.get $2
        i32.const 24
        i32.shr_u
        local.get $1
        i32.const 9
        i32.add
        i32.load
        local.tee $2
        i32.const 8
        i32.shl
        i32.or
        i32.store
        local.get $0
        i32.const 12
        i32.add
        local.get $1
        i32.const 13
        i32.add
        i32.load
        local.tee $5
        i32.const 8
        i32.shl
        local.get $2
        i32.const 24
        i32.shr_u
        i32.or
        i32.store
        local.get $1
        i32.const 16
        i32.add
        local.set $1
        local.get $0
        i32.const 16
        i32.add
        local.set $0
        local.get $4
        i32.const 16
        i32.sub
        local.set $4
        br $while-continue|3
       end
      end
      br $break|2
     end
     local.get $1
     i32.load
     local.set $5
     local.get $0
     local.get $1
     i32.load8_u
     i32.store8
     local.get $0
     i32.const 1
     i32.add
     local.tee $2
     i32.const 1
     i32.add
     local.set $0
     local.get $1
     i32.const 1
     i32.add
     local.tee $3
     i32.const 1
     i32.add
     local.set $1
     local.get $2
     local.get $3
     i32.load8_u
     i32.store8
     local.get $4
     i32.const 2
     i32.sub
     local.set $4
     loop $while-continue|4
      local.get $4
      i32.const 18
      i32.ge_u
      if
       local.get $0
       local.get $1
       i32.const 2
       i32.add
       i32.load
       local.tee $2
       i32.const 16
       i32.shl
       local.get $5
       i32.const 16
       i32.shr_u
       i32.or
       i32.store
       local.get $0
       i32.const 4
       i32.add
       local.get $2
       i32.const 16
       i32.shr_u
       local.get $1
       i32.const 6
       i32.add
       i32.load
       local.tee $2
       i32.const 16
       i32.shl
       i32.or
       i32.store
       local.get $0
       i32.const 8
       i32.add
       local.get $2
       i32.const 16
       i32.shr_u
       local.get $1
       i32.const 10
       i32.add
       i32.load
       local.tee $2
       i32.const 16
       i32.shl
       i32.or
       i32.store
       local.get $0
       i32.const 12
       i32.add
       local.get $1
       i32.const 14
       i32.add
       i32.load
       local.tee $5
       i32.const 16
       i32.shl
       local.get $2
       i32.const 16
       i32.shr_u
       i32.or
       i32.store
       local.get $1
       i32.const 16
       i32.add
       local.set $1
       local.get $0
       i32.const 16
       i32.add
       local.set $0
       local.get $4
       i32.const 16
       i32.sub
       local.set $4
       br $while-continue|4
      end
     end
     br $break|2
    end
    local.get $1
    i32.load
    local.set $5
    local.get $0
    local.tee $2
    i32.const 1
    i32.add
    local.set $0
    local.get $1
    local.tee $3
    i32.const 1
    i32.add
    local.set $1
    local.get $2
    local.get $3
    i32.load8_u
    i32.store8
    local.get $4
    i32.const 1
    i32.sub
    local.set $4
    loop $while-continue|5
     local.get $4
     i32.const 19
     i32.ge_u
     if
      local.get $0
      local.get $1
      i32.const 3
      i32.add
      i32.load
      local.tee $2
      i32.const 24
      i32.shl
      local.get $5
      i32.const 8
      i32.shr_u
      i32.or
      i32.store
      local.get $0
      i32.const 4
      i32.add
      local.get $2
      i32.const 8
      i32.shr_u
      local.get $1
      i32.const 7
      i32.add
      i32.load
      local.tee $2
      i32.const 24
      i32.shl
      i32.or
      i32.store
      local.get $0
      i32.const 8
      i32.add
      local.get $2
      i32.const 8
      i32.shr_u
      local.get $1
      i32.const 11
      i32.add
      i32.load
      local.tee $2
      i32.const 24
      i32.shl
      i32.or
      i32.store
      local.get $0
      i32.const 12
      i32.add
      local.get $1
      i32.const 15
      i32.add
      i32.load
      local.tee $5
      i32.const 24
      i32.shl
      local.get $2
      i32.const 8
      i32.shr_u
      i32.or
      i32.store
      local.get $1
      i32.const 16
      i32.add
      local.set $1
      local.get $0
      i32.const 16
      i32.add
      local.set $0
      local.get $4
      i32.const 16
      i32.sub
      local.set $4
      br $while-continue|5
     end
    end
   end
  end
  local.get $4
  i32.const 16
  i32.and
  if
   local.get $0
   local.get $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $2
   i32.const 1
   i32.add
   local.set $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $3
   i32.const 1
   i32.add
   local.set $1
   local.get $2
   local.get $3
   i32.load8_u
   i32.store8
  end
  local.get $4
  i32.const 8
  i32.and
  if
   local.get $0
   local.get $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $2
   i32.const 1
   i32.add
   local.set $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $3
   i32.const 1
   i32.add
   local.set $1
   local.get $2
   local.get $3
   i32.load8_u
   i32.store8
  end
  local.get $4
  i32.const 4
  i32.and
  if
   local.get $0
   local.get $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $2
   i32.const 1
   i32.add
   local.set $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $3
   i32.const 1
   i32.add
   local.set $1
   local.get $2
   local.get $3
   i32.load8_u
   i32.store8
  end
  local.get $4
  i32.const 2
  i32.and
  if
   local.get $0
   local.get $1
   i32.load8_u
   i32.store8
   local.get $0
   i32.const 1
   i32.add
   local.tee $2
   i32.const 1
   i32.add
   local.set $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $3
   i32.const 1
   i32.add
   local.set $1
   local.get $2
   local.get $3
   i32.load8_u
   i32.store8
  end
  local.get $4
  i32.const 1
  i32.and
  if
   local.get $0
   local.get $1
   i32.load8_u
   i32.store8
  end
 )
 (func $~lib/typedarray/Uint8ClampedArray#__set (param $0 i32) (param $1 i32) (param $2 i32)
  local.get $1
  local.get $0
  i32.load offset=8
  i32.ge_u
  if
   i32.const 1920000336
   i32.const 1920002736
   i32.const 315
   i32.const 45
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  local.get $0
  i32.load offset=4
  i32.add
  local.get $2
  i32.const 255
  local.get $2
  i32.sub
  i32.const 31
  i32.shr_s
  i32.or
  local.get $2
  i32.const 31
  i32.shr_s
  i32.const -1
  i32.xor
  i32.and
  i32.store8
 )
 (func $~lib/staticarray/StaticArray<u32>#__get (param $0 i32) (param $1 i32) (result i32)
  local.get $1
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.ge_u
  if
   i32.const 1920000336
   i32.const 1920000080
   i32.const 113
   i32.const 41
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $1
  i32.const 2
  i32.shl
  i32.add
  i32.load
 )
 (func $~lib/typedarray/Uint8ClampedArray#__get (param $0 i32) (param $1 i32) (result i32)
  local.get $1
  local.get $0
  i32.load offset=8
  i32.ge_u
  if
   i32.const 1920000336
   i32.const 1920002736
   i32.const 304
   i32.const 45
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  local.get $0
  i32.load offset=4
  i32.add
  i32.load8_u
 )
 (func $assembly/index/calculateClips (param $0 i32) (param $1 i32)
  nop
 )
 (func $assembly/index/grayWorld (param $0 i32)
  (local $1 f32)
  (local $2 f32)
  (local $3 f32)
  (local $4 i32)
  (local $5 i32)
  (local $6 f32)
  (local $7 i32)
  (local $8 f32)
  (local $9 f32)
  (local $10 f32)
  global.get $assembly/index/viewLength
  local.tee $7
  i32.const 1
  i32.shl
  local.tee $5
  local.get $7
  i32.add
  local.set $7
  loop $for-loop|0
   local.get $5
   local.get $7
   i32.lt_s
   if
    local.get $1
    local.get $5
    i32.load8_u
    f32.convert_i32_u
    f32.add
    local.set $1
    local.get $3
    local.get $5
    i32.const 1
    i32.add
    i32.load8_u
    f32.convert_i32_u
    f32.add
    local.set $3
    local.get $6
    local.get $5
    i32.const 2
    i32.add
    i32.load8_u
    f32.convert_i32_u
    f32.add
    local.set $6
    local.get $5
    i32.const 4
    i32.add
    local.set $5
    br $for-loop|0
   end
  end
  f32.const 1
  local.get $0
  f32.convert_i32_s
  f32.const 0.10000000149011612
  f32.mul
  local.tee $2
  f32.sub
  local.set $8
  f32.const 128
  local.get $1
  global.get $assembly/index/channelLength
  f32.convert_i32_s
  local.tee $1
  f32.div
  i32.trunc_f32_u
  f32.convert_i32_u
  f32.div
  local.get $2
  f32.mul
  local.set $9
  f32.const 128
  local.get $3
  local.get $1
  f32.div
  i32.trunc_f32_u
  f32.convert_i32_u
  f32.div
  local.get $2
  f32.mul
  local.set $10
  f32.const 128
  local.get $6
  local.get $1
  f32.div
  i32.trunc_f32_u
  f32.convert_i32_u
  f32.div
  local.get $2
  f32.mul
  local.set $6
  loop $for-loop|1
   local.get $4
   global.get $assembly/index/viewLength
   i32.lt_s
   if
    local.get $4
    i32.const 1
    i32.add
    i32.load8_u
    f32.convert_i32_u
    local.tee $2
    local.get $8
    f32.mul
    local.get $2
    local.get $10
    f32.mul
    f32.add
    local.set $2
    i32.const 3
    i32.load8_u
    f32.convert_i32_u
    local.tee $1
    local.get $8
    f32.mul
    local.get $1
    local.get $6
    f32.mul
    f32.add
    local.set $1
    local.get $4
    local.get $4
    i32.load8_u
    f32.convert_i32_u
    local.tee $3
    local.get $8
    f32.mul
    local.get $3
    local.get $9
    f32.mul
    f32.add
    local.tee $3
    f32.const 255
    f32.gt
    if (result f32)
     f32.const 255
    else
     f32.const 0
     local.get $3
     local.get $3
     f32.const 0
     f32.lt
     select
    end
    i32.trunc_f32_u
    i32.store8
    local.get $4
    i32.const 1
    i32.add
    f32.const 255
    f32.const 0
    local.get $2
    local.get $2
    f32.const 0
    f32.lt
    select
    local.get $2
    f32.const 255
    f32.gt
    select
    i32.trunc_f32_u
    i32.store8
    local.get $4
    i32.const 2
    i32.add
    f32.const 255
    f32.const 0
    local.get $1
    local.get $1
    f32.const 0
    f32.lt
    select
    local.get $1
    f32.const 255
    f32.gt
    select
    i32.trunc_f32_u
    i32.store8
    local.get $4
    i32.const 4
    i32.add
    local.set $4
    br $for-loop|1
   end
  end
 )
 (func $~lib/rt/__visit_members (param $0 i32)
  block $folding-inner2
   block $folding-inner1
    block $invalid
     block $~lib/staticarray/StaticArray<u32>
      block $~lib/string/String
       block $~lib/arraybuffer/ArrayBuffer
        local.get $0
        i32.const 8
        i32.sub
        i32.load
        br_table $~lib/arraybuffer/ArrayBuffer $~lib/string/String $folding-inner2 $~lib/staticarray/StaticArray<u32> $folding-inner2 $folding-inner1 $folding-inner1 $folding-inner2 $invalid
       end
       return
      end
      return
     end
     return
    end
    unreachable
   end
   local.get $0
   i32.load
   call $~lib/rt/itcms/__visit
   return
  end
  local.get $0
  i32.load
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
 )
 (func $~start
  (local $0 i32)
  memory.size
  i32.const 16
  i32.shl
  i32.const 1920019236
  i32.sub
  i32.const 1
  i32.shr_u
  global.set $~lib/rt/itcms/threshold
  i32.const 1920000260
  i32.const 1920000256
  i32.store
  i32.const 1920000264
  i32.const 1920000256
  i32.store
  i32.const 1920000256
  global.set $~lib/rt/itcms/pinSpace
  i32.const 1920000292
  i32.const 1920000288
  i32.store
  i32.const 1920000296
  i32.const 1920000288
  i32.store
  i32.const 1920000288
  global.set $~lib/rt/itcms/toSpace
  i32.const 1920000436
  i32.const 1920000432
  i32.store
  i32.const 1920000440
  i32.const 1920000432
  i32.store
  i32.const 1920000432
  global.set $~lib/rt/itcms/fromSpace
  call $~lib/staticarray/StaticArray<u32>#constructor
  global.set $assembly/index/viewOffsets
  call $~lib/staticarray/StaticArray<u32>#constructor
  global.set $assembly/index/countOffsets
  call $~lib/staticarray/StaticArray<u32>#constructor
  global.set $assembly/index/displayCountOffsets
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.sub
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i32.const 1920002852
  i32.lt_s
  if
   i32.const 1920019264
   i32.const 1920019312
   i32.const 1
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  local.tee $0
  i32.const 0
  i32.store
  local.get $0
  i32.const 12
  i32.const 4
  call $~lib/rt/itcms/__new
  local.tee $0
  i32.store
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.const 256
  i32.const 2
  call $~lib/arraybuffer/ArrayBufferView#constructor
  local.tee $0
  i32.store
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  global.set $assembly/index/curve
 )
 (func $assembly/index/initData (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 f32)
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.sub
  global.set $~lib/memory/__stack_pointer
  block $folding-inner0
   global.get $~lib/memory/__stack_pointer
   i32.const 1920002852
   i32.lt_s
   br_if $folding-inner0
   global.get $~lib/memory/__stack_pointer
   i64.const 0
   i64.store
   local.get $0
   global.set $assembly/index/width
   local.get $1
   global.set $assembly/index/height
   global.get $assembly/index/width
   global.get $assembly/index/height
   i32.mul
   global.set $assembly/index/channelLength
   global.get $assembly/index/channelLength
   i32.const 2
   i32.shl
   global.set $assembly/index/viewLength
   loop $for-loop|0
    local.get $2
    local.get $3
    i32.gt_u
    if
     global.get $~lib/memory/__stack_pointer
     global.get $assembly/index/viewOffsets
     local.tee $0
     i32.store
     local.get $0
     local.get $3
     local.get $5
     call $~lib/staticarray/StaticArray<u32>#__set
     local.get $5
     global.get $assembly/index/viewLength
     i32.add
     local.set $5
     local.get $3
     i32.const 1
     i32.add
     local.set $3
     br $for-loop|0
    end
   end
   i32.const 0
   local.set $3
   loop $for-loop|1
    local.get $2
    local.get $3
    i32.gt_u
    if
     global.get $~lib/memory/__stack_pointer
     global.get $assembly/index/countOffsets
     local.tee $0
     i32.store
     local.get $0
     local.get $3
     local.get $5
     call $~lib/staticarray/StaticArray<u32>#__set
     local.get $5
     i32.const 3072
     i32.add
     local.set $5
     local.get $3
     i32.const 1
     i32.add
     local.set $3
     br $for-loop|1
    end
   end
   i32.const 0
   local.set $3
   loop $for-loop|2
    local.get $2
    local.get $3
    i32.gt_u
    if
     global.get $~lib/memory/__stack_pointer
     global.get $assembly/index/displayCountOffsets
     local.tee $0
     i32.store
     local.get $0
     local.get $3
     local.get $5
     call $~lib/staticarray/StaticArray<u32>#__set
     local.get $5
     i32.const 768
     i32.add
     local.set $5
     local.get $3
     i32.const 1
     i32.add
     local.set $3
     br $for-loop|2
    end
   end
   global.get $~lib/memory/__stack_pointer
   local.tee $7
   i32.const 4
   i32.sub
   global.set $~lib/memory/__stack_pointer
   global.get $~lib/memory/__stack_pointer
   i32.const 1920002852
   i32.lt_s
   br_if $folding-inner0
   global.get $~lib/memory/__stack_pointer
   local.tee $5
   i32.const 0
   i32.store
   i32.const 1920000608
   local.set $0
   i32.const 2048
   local.set $4
   block $~lib/util/memory/memmove|inlined.0
    i32.const 2048
    i32.const 0
    call $~lib/rt/itcms/__new
    local.tee $6
    local.tee $1
    i32.const 1920000608
    i32.eq
    br_if $~lib/util/memory/memmove|inlined.0
    i32.const 1919998560
    local.get $1
    i32.sub
    i32.const -4096
    i32.le_u
    if
     local.get $1
     call $~lib/util/memory/memcpy
     br $~lib/util/memory/memmove|inlined.0
    end
    local.get $1
    i32.const 1920000608
    i32.lt_u
    if
     local.get $1
     i32.const 7
     i32.and
     i32.eqz
     if
      loop $while-continue|0
       local.get $1
       i32.const 7
       i32.and
       if
        local.get $4
        i32.eqz
        br_if $~lib/util/memory/memmove|inlined.0
        local.get $4
        i32.const 1
        i32.sub
        local.set $4
        local.get $1
        local.tee $3
        i32.const 1
        i32.add
        local.set $1
        local.get $0
        local.tee $2
        i32.const 1
        i32.add
        local.set $0
        local.get $3
        local.get $2
        i32.load8_u
        i32.store8
        br $while-continue|0
       end
      end
      loop $while-continue|1
       local.get $4
       i32.const 8
       i32.ge_u
       if
        local.get $1
        local.get $0
        i64.load
        i64.store
        local.get $4
        i32.const 8
        i32.sub
        local.set $4
        local.get $1
        i32.const 8
        i32.add
        local.set $1
        local.get $0
        i32.const 8
        i32.add
        local.set $0
        br $while-continue|1
       end
      end
     end
     loop $while-continue|2
      local.get $4
      if
       local.get $1
       local.tee $3
       i32.const 1
       i32.add
       local.set $1
       local.get $0
       local.tee $2
       i32.const 1
       i32.add
       local.set $0
       local.get $3
       local.get $2
       i32.load8_u
       i32.store8
       local.get $4
       i32.const 1
       i32.sub
       local.set $4
       br $while-continue|2
      end
     end
    else
     local.get $1
     i32.const 7
     i32.and
     i32.eqz
     if
      loop $while-continue|3
       local.get $1
       local.get $4
       i32.add
       i32.const 7
       i32.and
       if
        local.get $4
        i32.eqz
        br_if $~lib/util/memory/memmove|inlined.0
        local.get $1
        local.get $4
        i32.const 1
        i32.sub
        local.tee $4
        i32.add
        local.get $4
        i32.const 1920000608
        i32.add
        i32.load8_u
        i32.store8
        br $while-continue|3
       end
      end
      loop $while-continue|4
       local.get $4
       i32.const 8
       i32.ge_u
       if
        local.get $1
        local.get $4
        i32.const 8
        i32.sub
        local.tee $4
        i32.add
        local.get $4
        i32.const 1920000608
        i32.add
        i64.load
        i64.store
        br $while-continue|4
       end
      end
     end
     loop $while-continue|5
      local.get $4
      if
       local.get $1
       local.get $4
       i32.const 1
       i32.sub
       local.tee $4
       i32.add
       local.get $4
       i32.const 1920000608
       i32.add
       i32.load8_u
       i32.store8
       br $while-continue|5
      end
     end
    end
   end
   local.get $5
   local.get $6
   i32.store
   i32.const 16
   i32.const 5
   call $~lib/rt/itcms/__new
   local.tee $5
   local.get $6
   i32.store
   local.get $5
   local.get $6
   call $~lib/rt/itcms/__link
   local.get $5
   local.get $6
   i32.store offset=4
   local.get $5
   i32.const 2048
   i32.store offset=8
   local.get $5
   i32.const 256
   i32.store offset=12
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $7
   local.get $5
   i32.store offset=4
   i32.const 0
   local.set $3
   loop $for-loop|3
    local.get $3
    i32.const 256
    i32.lt_s
    if
     global.get $~lib/memory/__stack_pointer
     global.get $assembly/index/curve
     local.tee $2
     i32.store
     local.get $3
     local.tee $0
     local.tee $1
     local.get $5
     i32.load offset=12
     i32.ge_u
     if
      i32.const 1920000336
      i32.const 1920002688
      i32.const 106
      i32.const 42
      call $~lib/builtins/abort
      unreachable
     end
     local.get $5
     i32.load offset=4
     local.get $1
     i32.const 3
     i32.shl
     i32.add
     f64.load
     f32.demote_f64
     local.set $8
     local.get $0
     local.get $2
     i32.load offset=8
     i32.const 2
     i32.shr_u
     i32.ge_u
     if
      i32.const 1920000336
      i32.const 1920002736
      i32.const 1295
      i32.const 64
      call $~lib/builtins/abort
      unreachable
     end
     local.get $2
     i32.load offset=4
     local.get $0
     i32.const 2
     i32.shl
     i32.add
     local.get $8
     f32.store
     local.get $1
     i32.const 1
     i32.add
     local.set $3
     br $for-loop|3
    end
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 8
   i32.add
   global.set $~lib/memory/__stack_pointer
   return
  end
  i32.const 1920019264
  i32.const 1920019312
  i32.const 1
  i32.const 1
  call $~lib/builtins/abort
  unreachable
 )
 (func $assembly/index/calculateCounts (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.sub
  global.set $~lib/memory/__stack_pointer
  block $folding-inner0
   global.get $~lib/memory/__stack_pointer
   i32.const 1920002852
   i32.lt_s
   br_if $folding-inner0
   global.get $~lib/memory/__stack_pointer
   local.tee $1
   i32.const 0
   i32.store
   local.get $1
   i32.const 4
   i32.sub
   global.set $~lib/memory/__stack_pointer
   global.get $~lib/memory/__stack_pointer
   i32.const 1920002852
   i32.lt_s
   br_if $folding-inner0
   global.get $~lib/memory/__stack_pointer
   local.tee $1
   i32.const 0
   i32.store
   local.get $1
   global.get $assembly/index/countOffsets
   local.tee $1
   i32.store
   local.get $1
   local.get $0
   call $~lib/staticarray/StaticArray<u32>#__get
   local.tee $1
   i32.const 3072
   i32.add
   local.set $2
   loop $for-loop|0
    local.get $1
    local.get $2
    i32.lt_u
    if
     local.get $1
     i32.const 0
     i32.store
     local.get $1
     i32.const 4
     i32.add
     local.set $1
     br $for-loop|0
    end
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   global.get $~lib/memory/__stack_pointer
   global.get $assembly/index/viewOffsets
   local.tee $1
   i32.store
   local.get $1
   local.get $0
   call $~lib/staticarray/StaticArray<u32>#__get
   local.set $1
   global.get $~lib/memory/__stack_pointer
   global.get $assembly/index/countOffsets
   local.tee $2
   i32.store
   local.get $2
   local.get $0
   call $~lib/staticarray/StaticArray<u32>#__get
   local.set $0
   local.get $1
   global.get $assembly/index/viewLength
   i32.add
   local.set $4
   loop $for-loop|00
    local.get $1
    local.get $4
    i32.lt_u
    if
     local.get $0
     local.get $1
     i32.const 1
     i32.add
     i32.load8_u
     i32.const 2
     i32.shl
     i32.add
     i32.const 1024
     i32.add
     local.set $2
     local.get $0
     local.get $1
     i32.const 2
     i32.add
     i32.load8_u
     i32.const 2
     i32.shl
     i32.add
     i32.const 2048
     i32.add
     local.set $3
     local.get $0
     local.get $1
     i32.load8_u
     i32.const 2
     i32.shl
     i32.add
     local.tee $5
     local.get $5
     i32.load
     i32.const 1
     i32.add
     i32.store
     local.get $2
     local.get $2
     i32.load
     i32.const 1
     i32.add
     i32.store
     local.get $3
     local.get $3
     i32.load
     i32.const 1
     i32.add
     i32.store
     local.get $1
     i32.const 4
     i32.add
     local.set $1
     br $for-loop|00
    end
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   return
  end
  i32.const 1920019264
  i32.const 1920019312
  i32.const 1
  i32.const 1
  call $~lib/builtins/abort
  unreachable
 )
 (func $assembly/index/calculateDisplayCounts (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 f32)
  (local $11 f32)
  (local $12 f32)
  (local $13 f32)
  (local $14 f32)
  (local $15 f32)
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.sub
  global.set $~lib/memory/__stack_pointer
  block $folding-inner0
   global.get $~lib/memory/__stack_pointer
   i32.const 1920002852
   i32.lt_s
   br_if $folding-inner0
   global.get $~lib/memory/__stack_pointer
   local.tee $1
   i32.const 0
   i32.store
   local.get $1
   i32.const 4
   i32.sub
   global.set $~lib/memory/__stack_pointer
   global.get $~lib/memory/__stack_pointer
   i32.const 1920002852
   i32.lt_s
   br_if $folding-inner0
   global.get $~lib/memory/__stack_pointer
   local.tee $1
   i32.const 0
   i32.store
   local.get $1
   global.get $assembly/index/displayCountOffsets
   local.tee $1
   i32.store
   local.get $1
   local.get $0
   call $~lib/staticarray/StaticArray<u32>#__get
   local.tee $1
   i32.const 768
   i32.add
   local.set $3
   loop $for-loop|0
    local.get $1
    local.get $3
    i32.lt_u
    if
     local.get $1
     i32.const 0
     i32.store8
     local.get $1
     i32.const 1
     i32.add
     local.set $1
     br $for-loop|0
    end
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   global.get $~lib/memory/__stack_pointer
   global.get $assembly/index/countOffsets
   local.tee $1
   i32.store
   local.get $1
   local.get $0
   call $~lib/staticarray/StaticArray<u32>#__get
   local.set $1
   global.get $~lib/memory/__stack_pointer
   global.get $assembly/index/displayCountOffsets
   local.tee $3
   i32.store
   local.get $3
   local.get $0
   call $~lib/staticarray/StaticArray<u32>#__get
   local.set $5
   local.get $1
   i32.const 1024
   i32.add
   local.set $7
   local.get $1
   local.set $0
   loop $for-loop|00
    local.get $0
    local.get $7
    i32.lt_u
    if
     local.get $0
     i32.const 1024
     i32.add
     i32.load
     local.set $8
     local.get $0
     i32.const 2048
     i32.add
     i32.load
     local.set $9
     local.get $2
     local.get $0
     i32.load
     local.tee $3
     i32.lt_s
     if
      local.get $3
      local.set $2
     end
     local.get $8
     local.get $6
     local.get $6
     local.get $8
     i32.lt_s
     select
     local.set $6
     local.get $9
     local.get $4
     local.get $4
     local.get $9
     i32.lt_s
     select
     local.set $4
     local.get $0
     i32.const 4
     i32.add
     local.set $0
     br $for-loop|00
    end
   end
   f32.const 100
   local.get $2
   f32.convert_i32_s
   f32.div
   local.set $12
   f32.const 100
   local.get $6
   f32.convert_i32_s
   f32.div
   local.set $13
   f32.const 100
   local.get $4
   f32.convert_i32_s
   f32.div
   local.set $14
   local.get $1
   local.set $0
   loop $for-loop|1
    local.get $0
    local.get $7
    i32.lt_u
    if
     local.get $0
     i32.load
     f32.convert_i32_s
     local.set $15
     local.get $0
     i32.const 2048
     i32.add
     i32.load
     f32.convert_i32_s
     local.set $10
     local.get $0
     i32.const 1024
     i32.add
     i32.load
     f32.convert_i32_s
     local.tee $11
     f32.const 0
     f32.gt
     if (result i32)
      local.get $12
      local.get $15
      f32.mul
      i32.trunc_f32_s
      local.tee $4
      i32.const 1
      i32.lt_s
      if (result i32)
       i32.const 1
      else
       i32.const 100
       local.get $4
       local.get $4
       i32.const 100
       i32.gt_s
       select
      end
     else
      i32.const 0
     end
     local.set $4
     local.get $11
     f32.const 0
     f32.gt
     if (result i32)
      local.get $13
      local.get $11
      f32.mul
      i32.trunc_f32_s
      local.tee $2
      i32.const 1
      i32.lt_s
      if (result i32)
       i32.const 1
      else
       i32.const 100
       local.get $2
       local.get $2
       i32.const 100
       i32.gt_s
       select
      end
     else
      i32.const 0
     end
     local.set $2
     local.get $10
     f32.const 0
     f32.gt
     if (result i32)
      local.get $14
      local.get $10
      f32.mul
      i32.trunc_f32_s
      local.tee $1
      i32.const 1
      i32.lt_s
      if (result i32)
       i32.const 1
      else
       i32.const 100
       local.get $1
       local.get $1
       i32.const 100
       i32.gt_s
       select
      end
     else
      i32.const 0
     end
     local.set $1
     local.get $5
     local.get $4
     i32.store8
     local.get $5
     i32.const 256
     i32.add
     local.get $2
     i32.store8
     local.get $5
     i32.const 512
     i32.add
     local.get $1
     i32.store8
     local.get $0
     i32.const 4
     i32.add
     local.set $0
     local.get $5
     i32.const 1
     i32.add
     local.set $5
     br $for-loop|1
    end
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   return
  end
  i32.const 1920019264
  i32.const 1920019312
  i32.const 1
  i32.const 1
  call $~lib/builtins/abort
  unreachable
 )
 (func $assembly/index/process (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (param $4 i32) (param $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 f32)
  (local $11 f32)
  (local $12 i32)
  (local $13 i32)
  (local $14 f32)
  (local $15 f32)
  (local $16 f32)
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.sub
  global.set $~lib/memory/__stack_pointer
  block $folding-inner0
   global.get $~lib/memory/__stack_pointer
   i32.const 1920002852
   i32.lt_s
   br_if $folding-inner0
   global.get $~lib/memory/__stack_pointer
   i64.const 0
   i64.store
   local.get $0
   if
    global.get $~lib/memory/__stack_pointer
    local.tee $0
    i32.const 4
    i32.sub
    global.set $~lib/memory/__stack_pointer
    global.get $~lib/memory/__stack_pointer
    i32.const 1920002852
    i32.lt_s
    br_if $folding-inner0
    global.get $~lib/memory/__stack_pointer
    local.tee $1
    i32.const 0
    i32.store
    local.get $1
    i32.const 12
    i32.const 7
    call $~lib/rt/itcms/__new
    local.tee $1
    i32.store
    global.get $~lib/memory/__stack_pointer
    local.get $1
    i32.const 6
    i32.const 0
    call $~lib/arraybuffer/ArrayBufferView#constructor
    local.tee $5
    i32.store
    global.get $~lib/memory/__stack_pointer
    i32.const 4
    i32.add
    global.set $~lib/memory/__stack_pointer
    local.get $0
    local.get $5
    i32.store
    local.get $5
    i32.const 1
    i32.const 255
    call $~lib/typedarray/Uint8ClampedArray#__set
    local.get $5
    i32.const 3
    i32.const 255
    call $~lib/typedarray/Uint8ClampedArray#__set
    local.get $5
    i32.const 5
    i32.const 255
    call $~lib/typedarray/Uint8ClampedArray#__set
    local.get $4
    i32.const 0
    i32.ge_s
    if
     global.get $~lib/memory/__stack_pointer
     global.get $assembly/index/countOffsets
     local.tee $0
     i32.store offset=4
     local.get $0
     i32.const 0
     call $~lib/staticarray/StaticArray<u32>#__get
     local.set $6
     loop $for-loop|0
      local.get $7
      i32.const 3
      i32.lt_s
      if
       local.get $3
       local.get $6
       i32.load
       i32.add
       local.set $12
       local.get $3
       local.get $6
       i32.const 1020
       i32.add
       i32.load
       i32.add
       local.set $13
       i32.const 0
       local.set $8
       i32.const 0
       local.set $9
       i32.const 0
       local.set $4
       i32.const 255
       local.set $1
       i32.const 0
       local.set $0
       loop $for-loop|2
        local.get $0
        i32.const 255
        i32.le_s
        if
         local.get $8
         local.get $6
         local.get $0
         i32.const 2
         i32.shl
         i32.add
         i32.load
         i32.add
         local.tee $8
         local.get $12
         i32.le_u
         if
          local.get $0
          local.tee $4
          i32.const 1
          i32.add
          local.set $0
          br $for-loop|2
         end
        end
       end
       i32.const 255
       local.set $0
       loop $for-loop|4
        local.get $0
        i32.const 0
        i32.ge_s
        if
         local.get $9
         local.get $6
         local.get $0
         i32.const 2
         i32.shl
         i32.add
         i32.load
         i32.add
         local.tee $9
         local.get $13
         i32.le_u
         if
          local.get $0
          local.tee $1
          i32.const 1
          i32.sub
          local.set $0
          br $for-loop|4
         end
        end
       end
       local.get $5
       local.get $7
       i32.const 1
       i32.shl
       local.tee $0
       local.get $4
       i32.const 255
       i32.and
       call $~lib/typedarray/Uint8ClampedArray#__set
       local.get $5
       local.get $0
       i32.const 1
       i32.add
       local.get $1
       i32.const 255
       i32.and
       call $~lib/typedarray/Uint8ClampedArray#__set
       local.get $6
       i32.const 1024
       i32.add
       local.set $6
       local.get $7
       i32.const 1
       i32.add
       local.set $7
       br $for-loop|0
      end
     end
    end
    local.get $2
    if
     local.get $5
     i32.const 0
     local.get $5
     i32.const 0
     call $~lib/typedarray/Uint8ClampedArray#__get
     local.tee $0
     local.get $5
     i32.const 2
     call $~lib/typedarray/Uint8ClampedArray#__get
     i32.gt_u
     if
      local.get $5
      i32.const 2
      call $~lib/typedarray/Uint8ClampedArray#__get
      local.set $0
     end
     local.get $5
     i32.const 4
     call $~lib/typedarray/Uint8ClampedArray#__get
     local.get $0
     i32.lt_u
     if
      local.get $5
      i32.const 4
      call $~lib/typedarray/Uint8ClampedArray#__get
      local.set $0
     end
     local.get $0
     call $~lib/typedarray/Uint8ClampedArray#__set
     local.get $5
     i32.const 2
     local.get $0
     call $~lib/typedarray/Uint8ClampedArray#__set
     local.get $5
     i32.const 4
     local.get $0
     call $~lib/typedarray/Uint8ClampedArray#__set
     local.get $5
     i32.const 1
     local.get $5
     i32.const 1
     call $~lib/typedarray/Uint8ClampedArray#__get
     local.tee $0
     local.get $5
     i32.const 3
     call $~lib/typedarray/Uint8ClampedArray#__get
     i32.lt_u
     if
      local.get $5
      i32.const 3
      call $~lib/typedarray/Uint8ClampedArray#__get
      local.set $0
     end
     local.get $5
     i32.const 5
     call $~lib/typedarray/Uint8ClampedArray#__get
     local.get $0
     i32.gt_u
     if
      local.get $5
      i32.const 5
      call $~lib/typedarray/Uint8ClampedArray#__get
      local.set $0
     end
     local.get $0
     call $~lib/typedarray/Uint8ClampedArray#__set
     local.get $5
     i32.const 3
     local.get $0
     call $~lib/typedarray/Uint8ClampedArray#__set
     local.get $5
     i32.const 5
     local.get $0
     call $~lib/typedarray/Uint8ClampedArray#__set
    end
    f32.const 1
    local.get $5
    i32.load offset=4
    i32.const 1
    i32.add
    i32.load8_u
    local.get $5
    i32.load offset=4
    i32.load8_u
    i32.sub
    f32.convert_i32_u
    f32.div
    f32.const 255
    f32.mul
    local.set $14
    f32.const 1
    local.get $5
    i32.load offset=4
    i32.const 3
    i32.add
    i32.load8_u
    local.get $5
    i32.load offset=4
    i32.const 2
    i32.add
    i32.load8_u
    i32.sub
    f32.convert_i32_u
    f32.div
    f32.const 255
    f32.mul
    local.set $15
    f32.const 1
    local.get $5
    i32.load offset=4
    i32.const 5
    i32.add
    i32.load8_u
    local.get $5
    i32.load offset=4
    i32.const 4
    i32.add
    i32.load8_u
    i32.sub
    f32.convert_i32_u
    f32.div
    f32.const 255
    f32.mul
    local.set $16
    local.get $5
    i32.load offset=4
    i32.load8_u
    local.set $6
    local.get $5
    i32.load offset=4
    i32.const 2
    i32.add
    i32.load8_u
    local.set $7
    local.get $5
    i32.load offset=4
    i32.const 4
    i32.add
    i32.load8_u
    local.set $8
    global.get $~lib/memory/__stack_pointer
    global.get $assembly/index/viewOffsets
    local.tee $0
    i32.store offset=4
    local.get $0
    i32.const 1
    call $~lib/staticarray/StaticArray<u32>#__get
    local.set $9
    i32.const 0
    local.set $0
    loop $for-loop|6
     local.get $0
     global.get $assembly/index/viewLength
     i32.lt_s
     if
      local.get $0
      i32.load8_u
      local.set $2
      local.get $0
      i32.const 1
      i32.add
      i32.load8_u
      local.set $3
      local.get $0
      i32.const 2
      i32.add
      i32.load8_u
      local.set $4
      global.get $~lib/memory/__stack_pointer
      local.tee $5
      global.get $assembly/index/curve
      local.tee $1
      i32.store offset=4
      local.get $1
      i32.load offset=4
      local.get $2
      i32.extend16_s
      i32.const 2
      i32.shl
      i32.add
      f32.load
      local.set $11
      local.get $5
      local.get $1
      i32.store offset=4
      local.get $1
      i32.load offset=4
      local.get $3
      i32.extend16_s
      i32.const 2
      i32.shl
      i32.add
      f32.load
      local.set $10
      local.get $5
      local.get $1
      i32.store offset=4
      local.get $3
      f64.convert_i32_s
      f64.const 1
      local.get $10
      f64.promote_f32
      f64.sub
      f64.mul
      local.get $3
      local.get $7
      i32.sub
      f32.convert_i32_s
      local.get $15
      f32.mul
      local.get $10
      f32.mul
      f64.promote_f32
      f64.add
      i32.trunc_f64_s
      local.set $3
      local.get $4
      f64.convert_i32_s
      f64.const 1
      local.get $1
      i32.load offset=4
      local.get $4
      i32.extend16_s
      i32.const 2
      i32.shl
      i32.add
      f32.load
      local.tee $10
      f64.promote_f32
      f64.sub
      f64.mul
      local.get $4
      local.get $8
      i32.sub
      f32.convert_i32_s
      local.get $16
      f32.mul
      local.get $10
      f32.mul
      f64.promote_f32
      f64.add
      i32.trunc_f64_s
      local.set $1
      local.get $0
      local.get $9
      i32.add
      local.tee $4
      local.get $2
      f64.convert_i32_s
      f64.const 1
      local.get $11
      f64.promote_f32
      f64.sub
      f64.mul
      local.get $2
      local.get $6
      i32.sub
      f32.convert_i32_s
      local.get $14
      f32.mul
      local.get $11
      f32.mul
      f64.promote_f32
      f64.add
      i32.trunc_f64_s
      local.tee $2
      i32.extend16_s
      i32.const 255
      i32.gt_s
      if (result i32)
       i32.const 255
      else
       i32.const 0
       local.get $2
       local.get $2
       i32.extend16_s
       i32.const 0
       i32.lt_s
       select
      end
      i32.store8
      local.get $4
      i32.const 1
      i32.add
      i32.const 255
      i32.const 0
      local.get $3
      local.get $3
      i32.extend16_s
      local.tee $2
      i32.const 0
      i32.lt_s
      select
      local.get $2
      i32.const 255
      i32.gt_s
      select
      i32.store8
      local.get $4
      i32.const 2
      i32.add
      i32.const 255
      i32.const 0
      local.get $1
      local.get $1
      i32.extend16_s
      local.tee $1
      i32.const 0
      i32.lt_s
      select
      local.get $1
      i32.const 255
      i32.gt_s
      select
      i32.store8
      local.get $0
      i32.const 4
      i32.add
      local.set $0
      br $for-loop|6
     end
    end
    i32.const 1
    call $assembly/index/calculateCounts
    i32.const 1
    call $assembly/index/calculateDisplayCounts
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 8
   i32.add
   global.set $~lib/memory/__stack_pointer
   return
  end
  i32.const 1920019264
  i32.const 1920019312
  i32.const 1
  i32.const 1
  call $~lib/builtins/abort
  unreachable
 )
 (func $~lib/staticarray/StaticArray<u32>#constructor (result i32)
  (local $0 i32)
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.sub
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i32.const 1920002852
  i32.lt_s
  if
   i32.const 1920019264
   i32.const 1920019312
   i32.const 1
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  local.tee $0
  i32.const 0
  i32.store
  local.get $0
  i32.const 16
  i32.const 3
  call $~lib/rt/itcms/__new
  local.tee $0
  i32.store
  local.get $0
  i32.const 16
  call $~lib/memory/memory.fill
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
 )
 (func $~lib/arraybuffer/ArrayBufferView#constructor (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.sub
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i32.const 1920002852
  i32.lt_s
  if
   i32.const 1920019264
   i32.const 1920019312
   i32.const 1
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  i64.const 0
  i64.store
  local.get $0
  i32.eqz
  if
   global.get $~lib/memory/__stack_pointer
   i32.const 12
   i32.const 2
   call $~lib/rt/itcms/__new
   local.tee $0
   i32.store
  end
  local.get $0
  i32.const 0
  i32.store
  local.get $0
  i32.const 0
  call $~lib/rt/itcms/__link
  local.get $0
  i32.const 0
  i32.store offset=4
  local.get $0
  i32.const 0
  i32.store offset=8
  local.get $1
  i32.const 1073741820
  local.get $2
  i32.shr_u
  i32.gt_u
  if
   i32.const 1920000032
   i32.const 1920000544
   i32.const 18
   i32.const 57
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  local.get $1
  local.get $2
  i32.shl
  local.tee $2
  i32.const 0
  call $~lib/rt/itcms/__new
  local.tee $1
  i32.store offset=4
  local.get $1
  local.get $2
  call $~lib/memory/memory.fill
  local.get $0
  local.get $1
  i32.store
  local.get $0
  local.get $1
  call $~lib/rt/itcms/__link
  local.get $0
  local.get $1
  i32.store offset=4
  local.get $0
  local.get $2
  i32.store offset=8
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
 )
)
