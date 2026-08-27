# Datasheet — the Khmer witness to the Pāli canon (`ed="K"`)

*Specification, not data. Drafted 2026-08-27 for roadmap item **A64**, the first act of the
Cambodian alignment house (`siliconwat.dev`). Nothing described here has been built. Every factual
claim below about existing material was verified against the files in this tree on the date of
drafting; the method is stated so each can be re-run.*

> ⛔ **This document exists because a paper already committed to it.** `the-referee-not-the-governor`
> §5 requires that every judgment emitted by the values model resolve to a citation carrying
> **work, edition, locus, and transmission lineage**, and that a judgment which cannot so resolve
> be **withheld rather than hedged**. That is a constraint on a dataset that did not have a schema.
> **This datasheet is the check that the constraint is satisfiable.** It concludes that it is, but
> not by the route the roadmap item assumed.

---

## 0 · The one-paragraph summary

A machine-readable Pāli canon **already exists** in this tree, in both Khmer script and Roman, with
a page-level concordance across four print editions. **The Khmer-script copy is a mechanical
transliteration of the Burmese Sixth-Council text, not a Cambodian witness**, and the concordance
has no Cambodian edition in it. Separately, **82 PDF volumes of the Cambodian edition** are present.
The deliverable is therefore not *a Tipiṭaka* — it is **the missing witness, `ed="K"`, plus the
document-level provenance that the existing files entirely lack.** The hard part is not alignment
and it is not OCR: it is that the Cambodian volumes are typeset in **at least five different legacy
Khmer font encodings**, and the transcoding from those encodings to Unicode is lossy in
font-dependent ways.

---

## 1 · What is already here (verified 2026-08-27)

### 1.1 · The structured canon — `SW/Tipiṭaka/`

| Directory | Contents | Script |
|---|---|---|
| `pali/` | 218 TEI XML files, UTF-16, CST (**Chaṭṭha Saṅgāyana Tipiṭaka** — the Sixth Council recension, Yangon 1954–56, published digitally by the Vipassana Research Institute) filenames (`abh01m.mul.xml`, `.att`, `.tik`) | **Khmer** |
| `roman/` | 217 files, same names and structure | **Roman Pāli** |
| `tipitaka-xml/` | 13 further script renderings (`deva`, `mymr`, `sinh`, `thai`, …) | various |

**Upstream: `github.com/VipassanaTech/tipitaka-xml`** (founder-supplied, 2026-08-27) — the Vipassana Research Institute distribution. ⚠️ **The local copy is in no git repository and has no remote**, so it records no upstream revision; since the master is versioned upstream, ⭐ **the fix is to pin and record the upstream commit SHA as the CST-side provenance anchor**, which is exactly the `lineage` field §3.2 needs and currently cannot fill.

⚠️⚠️ **Two divergences from upstream, both introduced locally, and both hazards:**

1. ⛔ **`pali/` is a LOCAL RENAME OF UPSTREAM `khmr/`.** Upstream ships script folders (`beng cyrl deva gujr guru khmr knda mlym mymr romn sinh taml telu thai tibt`); this tree pulled two out and renamed them — `khmr` → **`pali/`**, `romn` → **`roman/`** — leaving the other thirteen under `tipitaka-xml/`. ⛔ **A directory named `pali` that contains Khmer script is the exact misnomer that manufactures the §1.2 error.** *This is very likely how "the Khmer Tipiṭaka is already here" becomes a belief.* ✅ **RENAMED to `khmr/` 2026-08-27**, after verifying nothing references the path; provenance recorded at `SW/Tipiṭaka/PROVENANCE.md`.
2. ⚠️ **`deva_master/` is ABSENT.** Upstream's authoritative source is Devanagari; this tree holds **only generated derivatives**. Any correction, and any question about what a rendering is a rendering *of*, has to go back upstream.

### 1.2 · ⛔ The Khmer-script files are a TRANSLITERATION, not a witness

**Method:** extract every `<pb ed="…" n="…"/>` page-break marker from `pali/abh01m.mul.xml` and
from `roman/abh01m.mul.xml` and compare the sequences.

**Result:** **1,270 markers in each file, sequences identical.**

⭐⭐ **And upstream states this in its own documentation, so it is now a citable fact rather than an inference from page markers:**

> *"Primary content of the Tipitaka sourcefiles are captured in Devanagari script and stored in `deva_master` folder… A C# conversion script is then run to generate the transliterated text for all other supported scripts."*

**The Khmer script is machine-generated from a Devanagari master by a conversion script.** The page-marker test (§1.2) inferred it; upstream documents it. Two renderings of one source, differing only in letters. The Khmer-script copy carries the
**Burmese Sixth-Council transmission lineage** wearing Khmer script. ⛔ **Shipping it as "the Khmer
Tipiṭaka" would place a lineage error inside an artifact intended for permanent etching, which is a
one-way door.** The file is correct Khmer script, it is right there, and it looks exactly like what
A64 asked for. **That is what makes it dangerous rather than merely wrong.**

### 1.3 · The concordance exists, and Cambodia is not in it

Page-break markers across the first 25 files of `roman/`:

| `ed=` | Edition | Markers |
|---|---|---|
| `V` | VRI | 10,585 |
| `M` | Myanmar / Sixth Council | 9,922 |
| `T` | Thai (Siamese) | 6,424 |
| `P` | Pali Text Society (Roman) | 2,974 |
| **`K`** | **Cambodian** | ⛔ **absent — 0** |

⭐ **The citation machinery §5 needs is already in the markup and already multi-witness.** What is
missing is one column. *The deliverable is a column, not a corpus.*

### 1.4 · Every `teiHeader` is empty

`<teiHeader></teiHeader>`, throughout. **No edition statement, no date, no source description, no
responsibility statement, no lineage.** The corpus the referee paper depends on currently asserts
**nothing** about where it came from. This is the second half of the gap and the cheaper half to close.

### 1.5 · The Cambodian witness — 82 PDF volumes

`bedok.siliconwat.dev/commentaries/`:

| Set | Count | Description |
|---|---|---|
| `khmer/` | **82** | *ព្រះត្រៃបិដក ប្រែរួមនឹងអដ្ឋកថា ភាគ N* — "Tipiṭaka translated together with the Aṭṭhakathā, vol. N" |
| `pali/` | 47 | Pāli commentarial volumes in Khmer script |
| `khmer2/` | **0** | empty; purpose unrecorded |

⚠️ **`khmer2/` is an empty directory whose intent nobody wrote down.** Resolve or delete it before
it is mistaken for a second witness.

### 1.6 · ⭐⭐ The real difficulty: five legacy font encodings, not OCR

**Method:** `pdffonts` on a sample volume; `pdftotext` on a sample page range.

**Text extracts as Latin characters** — `brmtßeCatika Gdækfa kfaBN'naéRtsrN³` — because the volumes
are typeset in **legacy Khmer fonts that map Khmer glyphs onto Latin codepoints.** Embedded fonts in
a *single* volume:

`LmnTTFantBig` (Limon family) · `APSARA` · `ThoeunA1` · `TacteingA` · **`Bidokk1`** · `TimesNewRomanPSMT`

⭐ **This is the best possible bad news.** It is **not an OCR problem** — Khmer OCR is genuinely hard
and would likely have made A64 infeasible for years. The text is present and machine-readable. But
it is **not plain extraction either**: recovering Unicode requires a **per-font transcoding table**,
and the mapping is lossy in known, font-specific ways for subscript consonants (*coeng*) and
vowel-reordering.

⚠️⚠️ **`Bidokk1` appears to be a custom font cut for this edition** (*bidok* = បិដក, *piṭaka*).
**There may be no published transcoding table for it at all**, in which case one must be derived and
that derivation becomes a primary artifact of this project in its own right.

### 1.7 · ⭐⭐ SIX collections exist, not one — and the two that matter were not in the plan

Found 2026-08-27 at `bedok.siliconwat.dev/tipitaka/`, on the founder's pointer. **This is more and
better material than §1.5 assumed.**

| Set | n | Size | Text layer | What it is |
|---|---|---|---|---|
| **`japan/`** | **110** | 2.0 G | ⛔ none | ⭐ **page SCANS** of a printed Khmer edition (760 pp vol 1, 453×690 pt) |
| **`5000/`** | **107** | 2.0 G | ⛔ none | ⭐ **page SCANS**, a *different* printing (930 pp, 484×665 pt) |
| **`taiwan/`** | **110** | 422 M | ✅ **Khmer Unicode** | **digital RE-SETTING** — `/Title: "Microsoft Word - bedok number 1 sary.docx"`, Distiller 6.0 (~2003–05), letter-size |
| `india/khmer/` | 220 | 474 M | (XML) | ⛔ **VRI transliteration again** — `tipitaka-khmr.xsl`, empty headers, `ed="M"`/`ed="V"`. **Not a witness** |
| `australia/`, `germany/` | — | 19 M | HTML | web editions / translations; triage separately |
| `commentaries/khmer/` | 82 | — | legacy Latin | §1.5–1.6; re-typeset, five legacy fonts |

⭐⭐ **The pairing A64 needs is present and neither half was planned for: `taiwan/` is machine-readable
copy-text, and `japan/` + `5000/` are the page images that let any disputed reading be checked
against the printed page.** That is the standing arrangement of a critical edition, and it is
already on disk.

⚠️ **`japan/` and `5000/` differ in page count and page size, so they are plausibly TWO DIFFERENT
PRINTINGS — possibly two different editions.** If that survives checking, there may be more than one
Khmer witness, and `ed="K"` would need disambiguation (`K1`/`K2`) rather than being one column.
**Do not collapse them before someone has compared them.**

⚠️ **`taiwan/`'s Unicode extracts DAMAGED**, and differently from §1.6's problem: subscript *coeng*
clusters are dropped (`ពះៃ តបដក` for `ព្រះត្រៃបិដក`), combining vowels detach from their base, and
**Private Use Area codepoints appear** (`U+F155`) where glyphs are unmapped. **This is a
glyph-reordering and PUA-recovery problem, not a font-transcoding one** — a different repair from
the 82-volume set, and it must not be assumed to be the same pipeline.

### 1.8 · ⭐⭐ The apparatus already exists, and Cambodia is the one line missing from it

Founder-confirmed and verified 2026-08-27. **`japan/` and `5000/` are the SAME Cambodian Buddhist Institute edition** — Japan printed the physical volumes, `5000-years.org` scanned them. §1.7's `K1`/`K2` caution is **withdrawn**: it rested on comparing volume 1 against volume 12. Same volume, both sets: **vol 12 = 929 vs 930 pp; vol 20 = 940 vs 941 pp.** ⭐ **A constant +1 offset — one set carries an extra leading page — which any page-mapping between them must encode.** `ed="K"` is one column.

**And the CST distribution carries a variant apparatus: 17,868 `<note>` elements** across the `.mul.` and `.att.` files, each a variant with an edition siglum — `sī.` 8,390 (Sinhalese) · `syā.` 8,087 (Siamese) · `ka.` 6,202 (*kesuci*, "in some manuscripts") · `pī.` 5,698 (⏳ **very likely PTS — confirm against upstream's abbreviation key**) · ⛔ **Khmer: none.**

⭐⭐ **This is A64's contribution stated exactly: the apparatus records where the Burmese line differs from the Sinhalese and Siamese lines, and Cambodia is absent from it exactly as it is absent from the `ed=` concordance. The deliverable adds the missing siglum to an apparatus that already holds 17,868 entries.**

⚠️⚠️ **Consequence for the collation plan, and it removes most of the work: Burmese↔Sinhalese and Burmese↔Siamese are NOT tasks — they were done by VRI's editors and need only extraction.** ⛔ **And Burmese↔`romn/` is a NULL comparison** — same Devanagari master, different script (§1.2), so it can only ever return zero. **Collation effort belongs where the apparatus is silent, which is Khmer, and nowhere else.**

### 1.9 · Double-keying: why a second transcription is the method, not duplication

`taiwan/` transcribed the BI edition into **Word documents and published only PDFs** (founder, 2026-08-27). The founder's father is doing **the same work independently.**

⭐⭐ **That is not redundancy — it is double-keying, the standard validation method for archival transcription.** Two independent re-keyings of the same printing, aligned and diffed, **locate the errors in both** and yield a measurable error rate. **The pipeline must therefore align the two rather than choose between them**, and the disagreement set is a first-class output rather than a by-product.

⏳ **The `.docx` sources remain the better input and are not available.** Requested from `mahapanna.org` by email c. 2024 and **declined**. ⛔ **Do not re-ask by email.** The founder's stated plan is to ask **in person, once his father's transcription is substantive enough to signal good faith** — which gives the father's work a third function beyond text and validation: **it is the credential that reopens the request.**

### 1.10 · The oral corpus — a checksum, not a witness

⚠️ **The substrate's earlier "transmission emergency" flag is WITHDRAWN.** Chanting and teachers' recitation take the **BI edition as authoritative** (founder, 2026-08-27), so the oral line is *downstream* of the printed text and is not an independent witness. **There is no oral-transmission race here.**

⭐ **What it is good for is real and narrower: forced alignment of recorded recitation against the transcribed text is a CHECKSUM.** Where audio and text disagree, either the transcription is wrong or the reciter departed from the page — and both are worth knowing. `5000-years.org` and YouTube hold many recordings (founder). *This operationalises the corpus's existing chant-as-checksum idea, which until now was a concept without a mechanism.* ⚠️ **Honest cost: forced alignment for chanted Pāli in Khmer script is not off-the-shelf** — recitation is slow, elongated and tonal, unlike the speech such models are trained on. **Treat as research, not as a tool to pick up.**

---

## 2 · What the dataset is

> **`ed="K"` — the Cambodian witness to the Pāli canon, aligned to the existing CST locus grid,
> with per-unit provenance sufficient to satisfy a citation of the form
> `work · edition · locus · lineage`.**

**It is NOT:** a new Tipiṭaka · a translation · a critical edition · a claim that the Cambodian
reading is correct where witnesses differ. **The dataset records what a witness says and where;
adjudication is out of scope and must stay out of scope.**

---

## 3 · Schema

### 3.1 · The distinction that must be structural, not documentary

⛔ **These four relations are distinct and must never be collapsed. The schema forces exactly one.**

```
  witness_to         an independent line of transmission this unit attests
                     (a printing set from manuscripts, carrying its own errors)
                       └─ error class: scribal / editorial, and EVIDENTIAL

  scan_of            a photographic reproduction of a printing
                     (adds no textual error at all; only legibility loss)
                       └─ error class: none textual — this is the PRIMARY EVIDENCE

  resetting_of       a HUMAN RE-KEYING of a printing into digital type
                     (attests the same witness; introduces NEW human error)
                       └─ error class: typos, silent normalisation, dropped diacritics

  transliteration_of a MECHANICAL re-scripting of another digital text
                     (adds nothing; inherits the source's lineage entirely)
                       └─ error class: deterministic, inherited, no new authority


  variant_record_of  a recorded DISAGREEMENT between two witnesses at a locus
                     (*K reads X where M reads Y at Z* — states the difference, NEVER adjudicates it)
                       └─ error class: n/a — this is EVIDENCE ABOUT witnesses, not a witness
```

⛔ **`variant_record_of` records disagreement and never resolves it** (§2: adjudication is out of scope). *That restraint is what makes the record citable by people who would disagree with us about which reading is right.*

⭐⭐ **`resetting_of` was added 2026-08-27 in answer to a direct question — *can the `taiwan/` PDFs be
a witness?*** They cannot, and the two-field schema had no way to say so: a Word re-typesetting is
neither an independent witness nor a mechanical transliteration. **It attests the same witness the
scans do, while introducing a class of error neither of the other two has** — which is precisely why
it needs its own field and its own review discipline. *A question about one artifact exposed a gap
in the schema rather than in the artifact.*

§1.2 is the reason the fourth relation exists at all: a schema in which the machine-generated
Khmer-script CST files can be labelled `witness_to: K` permits the exact error this project exists
to avoid. **Make it unrepresentable.**

### 3.2 · Unit record

```yaml
unit_id:            K/vin/01/0042/03        # witness / piṭaka / volume / page / block
witness:            K                        # the ed= code this unit supplies
work:               Vinayapiṭaka/Pārājikapāḷi
locus:
  cst_anchor:       vin01m.mul.xml#pb-V-0.0042   # anchor into the existing grid
  concordant:       {V: "0.0042", M: "0.0051", T: "0.0038", P: "1.0031"}
  k_page:           "ភាគ១៧ p.412"            # this witness's own pagination
lineage:
  edition:          Buddhist Institute, Phnom Penh
  volume_title:     "ព្រះត្រៃបិដក ប្រែរួមនឹងអដ្ឋកថា ភាគ១៧"
  printing:         { year: null, run: null }   # ⚠️ UNRECORDED — see §5.1
  witness_to:       K
  transliteration_of: null
provenance:
  source_file:      "commentaries/khmer/…ភាគ១៧.pdf"
  source_sha256:    "…"
  pdf_page:         412
  extractor:        "pdftotext 24.x"
  font_runs:        [{font: "Bidokk1", span: [0,318]},
                     {font: "LmnTTFantBig", span: [318,402]}]
  transcode_map:    "bidokk1→unicode v0.1"      # ⛔ REQUIRED, never inferred at read time
  transcode_lossy:  true
  transcode_notes:  "coeng cluster at offset 211 ambiguous; two candidates recorded"
  human_checked:    false
text:
  unicode:          "…"
  raw_legacy:       "…"                          # ⛔ ALWAYS RETAINED — see §3.3
```

### 3.3 · ⛔ Retain the raw legacy bytes, permanently

The transcoding is lossy and the maps will improve. **A unit that discards its pre-transcode bytes
can never be re-derived under a better map.** Keeping `raw_legacy` costs storage and buys the
ability to correct the entire corpus later without returning to the PDFs. *This is the same move as
etching the source rather than the render, and as continuous export removing the hostage: never hold
the only copy of the thing a later decision depends on.*

### 3.4 · teiHeader template

Every emitted file carries a populated header — edition, source, responsibility, and an explicit
statement of whether the file is a witness or a transliteration. **An empty `teiHeader` is a defect,
not a default** (§1.4).

---

## 4 · Pipeline, and exactly where provenance dies

```
  PDF volume
      │  (1) extract text runs WITH FONT ATTRIBUTION
      ▼
  legacy runs  ──── ⛔ PROVENANCE DIES HERE IF FONT IS NOT RECORDED ────┐
      │  (2) per-font transcode → Unicode                              │
      ▼                                                                │
  Unicode text  ──── ⛔ AND HERE IF THE MAP VERSION IS NOT RECORDED ────┤
      │  (3) normalise (NFC, coeng ordering)                           │
      ▼                                                                │
  normalised  ──── ⛔ AND HERE IF raw_legacy IS DISCARDED ─────────────┘
      │  (4) align to CST locus grid → emit ed="K" markers
      ▼
  unit records + <pb ed="K"/> patches
```

⚠️⚠️ **All three death-points are in steps 1–3, before any alignment happens.** They are cheap to
record at the moment of processing and **unrecoverable afterwards** — which is the entire argument
for drafting this schema before more text is processed rather than after.

---

## 5 · Open questions — none blocking the schema, all blocking the data

1. **Which printing are these 82 volumes?** The Buddhist Institute edition ran 1927–69 across 110
   volumes; 82 of a *translated-with-commentary* series is a different series or an incomplete set.
   ⚠️ **Answer before alignment, and record per volume.** The founder's father is the right source.
2. **Is there a published `Bidokk1` transcoding table, or must one be derived?** Determines whether
   step 2 is a week or a season.
3. **What is `khmer2/` for?**
4. ✅ **CST provenance is answered** (upstream + terms, §1.1/§7); ⏳ **pin the commit SHA.** **Where does the dataset repo live?** This datasheet currently sits inside the reader app's repo
   because that is where the PDFs are and it is tracked. **That is a placement of convenience and a
   structural decision is owed** — the dataset is not the app.
5. ⭐ **Are `japan/` and `5000/` the same printing?** Page counts and page sizes differ. **If they are two editions, `ed="K"` becomes `K1`/`K2`.** Decide before alignment; it is a schema question, not a data one.
6. **Which printing does `taiwan/` re-set, and from what?** Its provenance chain — printed edition → someone's Word re-keying (~2003–05) → PDF — is undocumented at every step, and `resetting_of` cannot be filled until it is known.
7. **Do the 47 `pali/` volumes constitute a separate witness** to the commentaries, and does the CST
   grid even cover them?

---

## 6 · Coverage, as a registered prediction

⭐ **The fraction of the canon this witness can be aligned to is a number to pre-register, not to
report afterwards.** Once measured it is trivially rationalisable in either direction. It should be
committed before the corpus is processed, in the same register as the alignment house's other
predictions, and published whether or not it is embarrassing.

## 7 · Licensing and distribution

CC0 1.0 for the alignment, schema and provenance records — **which this project produces**.

⛔⛔ **THE CST TEXT IS NOT CC0 AND CANNOT BE MADE CC0 BY US.** Upstream's stated terms: *"These files are made freely available for **non-commericial use**. Please **attribute Vipassana Research Institute** when incorporating these files into your projects."* ⚠️ **A non-commercial restriction is incompatible with CC0**, and it collides directly with the alignment house's **exclusion 3** (no closed data, everything published) and with the standing property that the artifact is *published on creation*. ⚠️ **There is also no formal LICENSE file** — a usage statement in documentation is vaguer and weaker than a licence, which makes the position harder to rely on rather than easier.

⭐⭐ **The reframe of §2 resolves this, and that is a second and independent reason to hold it.** The deliverable is **the `ed="K"` column, the alignment records and the provenance** — *our* work, publishable CC0 — which **references CST loci without redistributing CST text**. A corpus deliverable would have inherited a non-commercial encumbrance into the centre of a CC0 institution; **a column does not.** *The framing that was chosen for accuracy turns out to be the one that is licensable.*

⚠️ **Still to resolve, and it belongs to counsel rather than to us (legal item L21):** whether the Cambodian volumes may be redistributed at all, whether *quoting* CST loci in emitted citations is use or incorporation, and whether attribution is discharged by the `lineage` field. **Resolve before redistribution, not before use.**

---

## 8 · ⛔⛔ CORRECTION (2026-08-27) — the tree holds TWO different corpora and §§1.5–1.6 conflated them

**Founder asked whether the collation is *Khmer translation vs Pāli source in Khmer script*. Checking it exposed an error in this datasheet's own §1.5.**

| Material | Language | Relation to the Pāli canon |
|---|---|---|
| `japan/` · `5000/` (scans) · `taiwan/` (re-set) | ⭐ **PĀLI, in Khmer script** | **the `ed="K"` WITNESS** |
| `commentaries/khmer/` — 82 vols, *ព្រះត្រៃបិដក **ប្រែ**រួមនឹងអដ្ឋកថា* | ⛔ **KHMER — a TRANSLATION** | ⛔ **NOT a witness to the Pāli at all** |

**Verified by sampling body text, not by title.** `taiwan/CA101.pdf` p.60/300 reads `វិនយបិដេក មហាវិភង្គេ … អថេខា … ភគវា … ឯកមន្តំ និសីទិ` — *vinayapiṭake mahāvibhaṅge … atha kho … bhagavā … ekamantaṃ nisīdi*: **Pāli**. The 82-volume set at the same depth reads *"even if one must kill only one person who must be killed, by many means…"* — **Khmer prose**, and its title carries **ប្រែ** (*translated*).

### 8.1 · What this corrects

⛔ **§1.5 called the 82 volumes "the Cambodian witness". They are not.** They are a **Khmer translation-with-commentary series** — a different corpus with a different use. The witness is the canonical text in `japan/`/`5000/`/`taiwan/`.

### 8.2 · What the collation actually is

⛔ **NOT translation-vs-source. BOTH SIDES ARE PĀLI.**

```
   Pāli, CAMBODIAN recension        ↔        Pāli, BURMESE recension
   (BI edition, Khmer script)                (Sixth Council / CST)
        the ed="K" witness                    ed="M", already in the apparatus
```

⭐ **Script is not the variable — RECENSION is.** The collation is an ordinary textual comparison of two recensions of one Pāli text, which is exactly what a variant apparatus is built to hold, and it is why `ed="K"` slots into the existing 17,868-entry structure rather than needing a new one.

⭐⭐ **Practical consequence, and it is cheap: script must be normalised BEFORE collation** (Khmer-script Pāli → Roman or Devanagari), and **that transliterator is the MIRROR of the engine VRI already ships** — upstream converts Devanagari→Khmer with a C# script (§1.2). **The tool exists in one direction and needs inverting, not writing.** ⚠️ Round-tripping is not guaranteed to be lossless, but Pāli orthography in Khmer script is far more constrained than Khmer-language orthography, so the risk is small and testable — **test it on a chapter before trusting it on a canon.**

### 8.3 · So A64 delivers TWO artifacts, and they must not be merged

1. ⭐ **The `ed="K"` Pāli witness** — this datasheet's subject.
2. **A Khmer translation corpus** (the 82 volumes) — *not* a witness, and **arguably more valuable to the Buddha-AI surface than to A64**, since it carries the doctrinal understanding in the vernacular rather than another attestation of the Pāli. ⏳ **It deserves its own datasheet and its own relation (`translation_of`), and it is out of scope here.**

### 8.4 · ⭐⭐ The two corpora are INTERLEAVED — facing-page bilingual (founder, 2026-08-27)

**The Buddhist Institute edition is a facing-page bilingual: Pāli (Khmer script) on one leaf, Khmer translation on the facing leaf.** Verified across `taiwan/CA101.pdf` pp.58–69 — even pages carry **zero** Khmer particles at ~480–550 chars (Pāli), odd pages carry **4–20** at ~840–990 (Khmer), and the Pāli running head is a Pāli locus while the Khmer head reads `… សែមងអំពី` (*showing about…*).

⭐⭐ **Both members of a pair carry the SAME printed page number** (`១៩`,`១៩` · `២០`,`២០`): the edition numbers the **opening**, not the leaf. **So the printed page number is a ready-made 1:1 Pāli↔Khmer alignment key — the parallel corpus arrives aligned by the edition's own typography.**

⛔⛔ **AND THIS PROMOTES §1.8's `+1` PAGE OFFSET FROM CURIOSITY TO CORRECTNESS LANDMINE.** In a strictly alternating bilingual edition **an off-by-one FLIPS THE PARITY** — every Pāli page is labelled Khmer and every Khmer page Pāli, silently, across a whole volume. The text still extracts; the pipeline still runs; every record is wrong. ⛔ **RULE: never derive language from page index. Classify each page from its own content, requiring TWO signals to agree — running head and Khmer-particle density — and raise disagreement rather than resolving it by majority.**

⭐ **Consequence for §8.3: the two artifacts cannot be produced by separate projects.** One extraction pass yields both, and **mislabelling one produces the other.** Companion spec: `DATASHEET-KHMER-TRANSLATION.md`.

### 8.5 · `japan/` is a DERIVATIVE of `5000/`, and the stripped pages were the provenance

**Founder, 2026-08-27: *"japan/ is basically 5000/ minus all the disclaimers and such."*** That explains §1.8's constant `+1` exactly — one extra front page per volume — and it means **they are not two independent scan sets.**

⛔⛔ **Schema consequence: only ONE of them is `scan_of`. `5000/` is the master; `japan/` is a REDACTED DERIVATIVE of it** and must not be recorded as a second attestation.

⭐⭐ **And the counter-intuitive consequence, which matters: the DISCLAIMERS ARE THE PROVENANCE.** They carry the scan attribution — who scanned, when, under what terms — which is the precise class of information this entire project exists to preserve. **`japan/` is the cleaner copy and the LESS archival one**, and adopting it as the working master because it is tidier would discard the provenance record while looking like a simplification. **Work from `5000/`.**

⭐ **A second reason to prefer `5000/`: its front matter is the likeliest place the BI edition's individual translators are named** — see `DATASHEET-KHMER-TRANSLATION.md` §5, where `translator.named` is currently empty.
