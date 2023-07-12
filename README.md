BXjalipsum Package
==================

LaTeX: Dummy text in Japanese

This package enables users to print some Japanese text that can be used
as dummy text. It is a Japanese counterpart of the lipsum package.

Since there is no well-known nonsense text like Lipsum in the Japanese
language, the package uses some real text in public domain.

### System requirement

  * TeX format: LaTeX.
  * TeX engine: pdfTeX / (e-)pTeX / (e-)upTeX / XeTeX / LuaTeX.
      - pdfTeX: v1.40 or later
      - pTeX: v2.0 or later
      - upTeX: v0.10 or later
      - XeTeX: v0.9994 or later
      - LuaTeX: v0.60 or later
  * Dependent packages:
      - intcalc (when using non-e-TeX engines)

### Installation

  - `*.sty` → $TEXMF/tex/latex/BXjalipsum

### License

This package is distributed under the MIT License.

The bxjalipsum Package
----------------------

### Package Loading

    \usepackage{bxjalipsum}

No options are available.

### Usage

  * `\jalipsum[<range>,...]{<key>}`: Prints some paragraphs from the
    text specified by the key.

      - `iroha` (1 paragraph): The iroha sequence (いろはにほへと…).
      - `jugemu` (1 paragraph): The "jugemu" name (寿限無寿限無五劫の…).
      - `jugemuP` (1 paragraph): The "jugemu" name, with some punctuation
        added in ad hoc manner (寿限無・寿限無、五劫の…).
      - `wagahai` (33 paragraphs): The first chapter from the novel
        "吾輩は猫である" (I Am A Cat) written by Natsume Soseki.
      - `preamble` (4 paragraphs): The preamble of the Constitution of
        Japan.
      - `hatsukoi` (4 paragraphs): The whole text of the poem "初恋"
        (First Love) written by Shimazaki Toson.
          + The lines inside a stanza are delimited by '\\' command.
      - `kusamakura` (13 paragraphs): The opening passage from the novel
        "草枕" (Kusamakura) written by Natsume Soseki.

    Ranges are specified in the form `[-3,7-10,5,12-]`. If ranges are not
    given, then `[-]` (all paragraphs) will be assumed.

  * `\jalipsumiroha`: The shorthand for `\jalipsum{iroha}`.
  * `\jalipsumjugemu`: The shorthand for `\jalipsum{jugemu}`.
  * `\jalipsumjugemuP`: The shorthand for `\jalipsum{jugemuP}`.

### Notices on use with pdfTeX

  * When pdfTeX is used, Japanese (non-ASCII) characters are represented
    as UTF-8 byte sequences. Thus there must be some mechanism (such as
    the CJKutf8 package) that will decode such sequences and display the
    Japanese characters properly.

### Notices for TeX programmers

  * All the commands are fully expandable.
  * The `\jalipsum` command is expanded to the actual text in two steps.
  * The shorthand commands such as `\jalipsumiroha` are expanded to the
    actual text in one step.
  * Each of the paragraph texts consists only of character tokens and
    optional `\\` (line-break) tokens.
  * When `\jalipsum` with multiple paragraphs is expanded, each paragraph
    is joined with `\par` tokens.

Revision History
----------------


  * Version 1.0a ‹2023/07/12›
      - Bug fix.
  * Version 1.0  ‹2023/02/22›
      - Supported new version of pLaTeX.
  * Version 0.3a ‹2017/03/01›
      - Added text “kusamakura”.
  * Version 0.3  ‹2016/11/06›
      - Added the support for pdfTeX.
  * Version 0.2  ‹2016/08/15›
      - The first public version.

--------------------
Takayuki YATO (aka. "ZR")  
https://github.com/zr-tex8r
