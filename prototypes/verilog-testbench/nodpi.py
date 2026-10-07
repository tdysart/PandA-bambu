#!/usr/bin/env python3
"""Rewrite a Bambu-generated testbench so it needs no DPI/libmdpi host."""
import re, sys
src, dst = sys.argv[1], sys.argv[2]
text = open(src).read()
n = 0
def repl(m):
    global n
    n += 1
    return "import tb_shim_pkg::%s;" % m.group(1)
text = re.sub(r'import\s+"DPI-C"\s+function\s+[^;]*?\b(m_\w+)\s*\([^;]*\)\s*;', repl, text)
open(dst, "w").write(text)
print("replaced %d DPI imports" % n)
