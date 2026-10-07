// Image-capture runtime for the Verilog testbench style.
//
// The generated mdpi_wrapper.cpp normally drives a live simulation through libmdpi. This header
// is a drop-in replacement for <mdpi/mdpi_wrapper.h> that records instead: when the user's
// testbench calls the top function, the wrapper registers every parameter (m_interface_*), runs
// the original C function on copies (the "gold" model) and compares (m_argcmp). Here the
// registration writes the input memory image and m_argcmp writes the gold output image, so the
// natively run testbench produces the files the DPI-free Verilog testbench replays:
//
//   tb_init.mem      <run> <interface id> <element address, hex> <data, hex>
//   tb_expected.mem  same format, the memory contents after the call
//
// Only array and scalar-port interfaces are supported; others stop with an error.
#ifndef BAMBU_VERILOG_CAPTURE_WRAPPER_H
#define BAMBU_VERILOG_CAPTURE_WRAPPER_H

#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define typeof __typeof__

typedef uint64_t ptr_t;
typedef uint64_t bptr_t;

#define info(...) ((void)0)
#define error(...) fprintf(stderr, "capture: " __VA_ARGS__)

#define MDPI_MEMMAP_DEVICE 0
#define MDPI_MEMMAP_SHARED 1
#define __m_memmap_init(mode) ((void)(mode))
// Internal (global) memory variables are not supported yet: refuse rather than miss them.
#define __m_memmap(addr, ptr, size) (fprintf(stderr, "capture: memory-mapped variables are not supported\n"), 4)
#define __m_abort() (fprintf(stderr, "capture: aborted\n"), exit(2))

#define __M_MAX_PARAMS 256
static size_t __m_param_sizes[__M_MAX_PARAMS];
static size_t __m_call_count = 0;
static FILE* __m_init_file = NULL;
static FILE* __m_expected_file = NULL;

static inline void __m_param_alloc(unsigned idx, size_t size)
{
   if(idx < __M_MAX_PARAMS)
   {
      __m_param_sizes[idx] = size;
   }
}
static inline size_t __m_param_size(unsigned idx)
{
   return idx < __M_MAX_PARAMS ? __m_param_sizes[idx] : 0;
}

static inline void __m_unsupported(const char* what)
{
   fprintf(stderr, "capture: %s is not supported by the verilog testbench style\n", what);
   exit(2);
}

static inline FILE* __m_image(FILE** f, const char* name)
{
   if(!*f)
   {
      *f = fopen(name, "w");
      if(!*f)
      {
         perror(name);
         exit(2);
      }
   }
   return *f;
}

// Write `nelems` elements of `bitsize` bits, stored every `align` bytes (little endian host),
// as one "<run> <id> <addr> <hex>" line each.
static inline void __m_dump_words(FILE* f, unsigned id, const void* base, size_t nelems, unsigned bitsize,
                                  size_t align)
{
   const size_t nbytes = (bitsize + 7) / 8;
   size_t e, b;
   for(e = 0; e < nelems; ++e)
   {
      const unsigned char* p = (const unsigned char*)base + e * align;
      fprintf(f, "%zu %u %zx ", __m_call_count, id, e);
      for(b = nbytes; b-- > 0;)
      {
         unsigned v = p[b];
         if(b == nbytes - 1 && (bitsize % 8))
         {
            v &= (1u << (bitsize % 8)) - 1u;
         }
         fprintf(f, "%02x", v);
      }
      fputc('\n', f);
   }
}

static inline void __m_capture_input(unsigned id, const void* ptr, unsigned bitsize, size_t align, size_t nelems)
{
   __m_dump_words(__m_image(&__m_init_file, "tb_init.mem"), id, ptr, nelems, bitsize, align);
}
static inline void __m_capture_output(unsigned id, const void* ptr, unsigned bitsize, size_t align, size_t nelems)
{
   __m_dump_words(__m_image(&__m_expected_file, "tb_expected.mem"), id, ptr, nelems, bitsize, align);
}

// The gold copy of parameter `idx` after the reference run is the expected output image. Elements
// are described by the m_interface_* call, so remember them per parameter.
static unsigned __m_if_bitsize[__M_MAX_PARAMS];
static size_t __m_if_align[__M_MAX_PARAMS];
static size_t __m_if_nelems[__M_MAX_PARAMS];

#define _m_capture_if(idx, ptr, bitsize, align, nelems)             \
   do                                                               \
   {                                                                \
      __m_if_bitsize[idx] = (bitsize);                              \
      __m_if_align[idx] = (align);                                  \
      __m_if_nelems[idx] = (nelems);                                \
      __m_capture_input(idx, ptr, (bitsize), (align), (nelems));    \
   } while(0)

#define _ms_setargptr(suffix, idx, ptr)                       \
   const size_t P##idx##_size_##suffix = __m_param_size(idx); \
   void* P##idx##_##suffix = malloc(P##idx##_size_##suffix);  \
   memcpy(P##idx##_##suffix, ptr, P##idx##_size_##suffix)

#define m_map_default(ptr) NULL
#define m_map_array(...) m_map_default(__VA_ARGS__)
#define m_map_none(...) m_map_default(__VA_ARGS__)
#define m_map_valid(...) m_map_default(__VA_ARGS__)
#define m_map_ovalid(...) m_map_default(__VA_ARGS__)
#define m_map_acknowledge(...) m_map_default(__VA_ARGS__)
#define m_map_handshake(...) m_map_default(__VA_ARGS__)

#define m_interface_array(idx, ptr, bitsize, align)                              \
   _m_capture_if(idx, ptr, bitsize, align, __m_param_size(idx) / (align));       \
   _ms_setargptr(gold, idx, ptr)
// A pointer to a single scalar behind a none/valid/ovalid/acknowledge/handshake port.
#define m_interface_default(idx, ptr, bitsize, align) \
   _m_capture_if(idx, ptr, bitsize, align, 1);        \
   _ms_setargptr(gold, idx, ptr)
#define m_interface_none(...) m_interface_default(__VA_ARGS__)
#define m_interface_valid(...) m_interface_default(__VA_ARGS__)
#define m_interface_ovalid(...) m_interface_default(__VA_ARGS__)
#define m_interface_acknowledge(...) m_interface_default(__VA_ARGS__)
#define m_interface_handshake(...) m_interface_default(__VA_ARGS__)

#define m_map_fifo(...) NULL
#define m_map_axis(...) NULL
#define m_map_channel(...) NULL
#define m_map_ptr(...) NULL
#define m_map_m_axi(...) NULL
#define m_map_array_csroa(...) NULL
#define m_interface_fifo(...) __m_unsupported("fifo interface")
#define m_interface_axis(...) __m_unsupported("axis interface")
#define m_interface_channel(...) __m_unsupported("channel interface")
#define m_interface_ptr(...) __m_unsupported("pointer (m_axi) interface")
#define m_interface_m_axi(...) __m_unsupported("m_axi interface")
#define m_interface_array_csroa(...) __m_unsupported("csroa array interface")
#define m_interface_banked(...) __m_unsupported("banked interface")
#define m_interface_bank_offset(...) __m_unsupported("banked interface")

// Nothing to simulate here: the hardware runs later, in the Verilog testbench.
#define __m_interface_mem() ((void)0)
#define __m_sim_start() ((void)0)
#define __m_sim_end() ((void)0)
#define __m_interface_fini() ((void)0)

// Instead of comparing against a hardware result, record the gold output as the expected image,
// and hand it back to the user's testbench as if the hardware had produced it: its own checks
// after the call, and later calls that read earlier outputs, then see correct data.
#define m_argcmp(idx, cmp)                                                                                   \
   do                                                                                                        \
   {                                                                                                         \
      __m_capture_output(idx, P##idx##_gold, __m_if_bitsize[idx], __m_if_align[idx], __m_if_nelems[idx]);    \
      memcpy((void*)P##idx, P##idx##_gold, P##idx##_size_gold);                                              \
      free(P##idx##_gold);                                                                                   \
   } while(0)
#define m_channelcmp(...) __m_unsupported("channel interface")
#define m_retvalcmp(...) __m_unsupported("return value")
#define m_call_next(...) ++__m_call_count

#endif // BAMBU_VERILOG_CAPTURE_WRAPPER_H
