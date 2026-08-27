# Datasheet — the Khmer translation corpus (`translation_of` the BI edition)

*Companion to `DATASHEET.md`, which specifies the `ed="K"` **Pāli witness**. This one specifies the
**Khmer translation** that the same edition carries on its facing pages. Founder-agreed 2026-08-27
after the two were found conflated. **Specification only; nothing built.***

> ⭐ **These are two corpora in one book.** The Cambodian Buddhist Institute edition is a
> **facing-page bilingual**: Pāli (in Khmer script) on one leaf, Khmer translation on the facing
> leaf. Neither datasheet can be executed without respecting the other, because a single extraction
> pass produces both and **mislabelling one produces the other.**

---

## 1 · The structure, verified

Sampled `tipitaka/taiwan/CA101.pdf`, consecutive pages 58–69:

| PDF page | Khmer-particle count | Chars | Content | Running head |
|---|---|---|---|---|
| 58, 60, 62 … | **0** | ~480–550 | **Pāli** | Pāli locus — `វិនយបិដេក មហាវិភង្គេ` |
| 59, 61, 63 … | **4–20** | ~840–990 | **Khmer** | Khmer descriptive — `… សែមងអំពី` (*showing about…*) |

⭐⭐ **Both members of a pair carry the SAME printed page number** (`១៩`,`១៩` · `២០`,`២០` · `២១`,`២១`).
**The edition numbers the opening, not the leaf.** Therefore:

> **The printed page number is a ready-made 1:1 alignment key between the Pāli and its Khmer
> translation. The parallel corpus is aligned by the edition's own typography, and no alignment work
> is required at page granularity.**

⭐ The Khmer side runs roughly **twice the length** of the Pāli, as a translation with explanatory
expansion should.

---

## 2 · ⛔⛔ The parity hazard — and why the `+1` offset is now a correctness landmine

`DATASHEET.md` §1.8 recorded that `japan/` and `5000/` scan the same printing with a **constant one-page
offset**. Before the facing-page structure was known, that was a curiosity.

**It is not a curiosity. In a strictly alternating bilingual edition an off-by-one FLIPS THE PARITY** —
every Pāli page is labelled Khmer and every Khmer page Pāli, silently, across an entire volume. The
text still extracts, the pipeline still runs, and every record is wrong.

⛔ **THE RULE: never derive language from page index. Classify every page from its own content.**
Two independent cheap signals, and they should both be required to agree:

1. **Running head** — the Pāli leaf carries a Pāli locus; the Khmer leaf carries a Khmer descriptive
   head containing `សែមងអំពី`.
2. **Khmer-particle density** — `ែដល · េនះ · គឺ · និង · ជា · ែត` and similar appear **0** times on a
   Pāli page and **4–20** times on a Khmer one in the sample above. A wide, robust margin.

⚠️ **Disagreement between the two signals is an error to raise, never to resolve by majority.**

---

## 3 · What this corpus is, and is not

**IS:** the Buddhist Institute's **Khmer translation** of the Pāli canon, with its commentarial
material — a 20th-century scholarly translation by named Cambodian monastics, and *the* reference
rendering of the canon into Khmer.

⛔ **IS NOT a witness to the Pāli text.** It attests **how the Pāli was understood in Khmer**, which
is a different claim and belongs in a different field. It must never appear in the `ed="K"`
apparatus.

**Relation: `translation_of`** — the fifth member of `DATASHEET.md` §3.1's taxonomy, with its own
error class: **interpretive choice.** A translation's divergence from its source is not an error to
be corrected but **evidence about the translator's reading**, and the record must be able to say so.

---

## 4 · Why it may matter more than the witness

Stated plainly because it is easy to treat this as the lesser artifact:

- ⭐ **It is the only vernacular gloss of the canon this project has.** The `ed="K"` witness adds one
  more attestation to an apparatus with 17,868 entries. **This adds the tradition's own
  understanding**, which nothing else in the tree carries.
- ⭐⭐ **Aligned Pāli↔Khmer is a rare parallel corpus** — and §1 shows it arrives already aligned. For
  the Buddha-AI surface, a citation a Khmer speaker can *read* is worth more than one they can only
  verify.
- ⚠️ **And it is the half most exposed to loss of meaning in a bad pipeline**, because a
  mis-transcribed Pāli word is detectable against four other editions while a mis-transcribed Khmer
  sentence is detectable against nothing.

---

## 5 · Provenance and schema

Inherits `DATASHEET.md` §3 unchanged, with three additions:

```yaml
relation:        translation_of
source_locus:    K/vin/01/0019          # the facing Pāli page — SAME printed number
translator:      { edition: "Buddhist Institute", named: null }   # ⏳ unrecorded
page_parity:
  classified_by: [running_head, particle_density]   # ⛔ never page index
  signals_agree: true
```

⚠️ **`translator.named` is unrecorded and should not stay that way.** The BI translation was made by
identifiable monastics over four decades; **attributing it is both scholarly practice and part of
the case for the blessing L22 seeks.** The founder's father is the right first source.

---

## 6 · Open questions

1. ⏳ **Are the 82 `commentaries/khmer/` volumes the same translation, or a different series?** Their
   title (*ព្រះត្រៃបិដក **ប្រែ**រួមនឹងអដ្ឋកថា*) says *translated with the aṭṭhakathā*, and they are
   **82 where the canonical edition is 110** — so either a different series, an incomplete set, or a
   translation-only reissue. ⛔ **Do not merge them into this corpus before it is known.**
2. ⏳ Which volumes carry commentary alongside the canonical translation, and is it typographically
   distinguishable?
3. ⏳ Does `taiwan/` transcribe **both** sides, or only the Pāli? §1 shows both present in CA101 —
   **confirm across volumes before relying on it.**
4. ⏳ Licensing sits with **L22** and is *not* separable from the witness: they are the same book.

---

## 7 · ⛔⛔ IDENTIFIED (2026-08-27) — `commentaries/khmer/` is a 2009 series, NOT the BI edition

**Founder: *"different series — the PDFs are text-based so you can extract some text to find out."* Done. The title pages decode cleanly from the legacy encoding and settle it.**

| Vol | Series title (decoded) | Commentary | Printing |
|---|---|---|---|
| 17 | *Suttantapiṭaka + **បប្បញ្ចសូទនី** aṭṭhakathā, translated into Khmer* — Majjhimanikāya, Majjhima- & Uparipaṇṇāsaka | **Papañcasūdanī** (MN aṭṭhakathā) | **1st printing, BE 2553 = 2009 CE** |
| 32 | *Suttantapiṭaka + **បរមត្ថជោតិកា** aṭṭhakathā, translated into Khmer* — Khuddakanikāya: Khuddakapāṭha, Dhammapada, Udāna | **Paramatthajotikā** | **1st printing, BE 2553 = 2009 CE** |

⭐ **What it is: the canon WITH ITS COMMENTARIES, translated into Khmer, published 2009.** The 1927–69 Buddhist Institute edition did **not** carry the aṭṭhakathā; this series does, which is the substantive difference and explains the different volume count (82 vs 110).

⭐⭐ **A concordance key, offered as a HYPOTHESIS not a finding: each title page carries `បាលីប្រែ NN`** (*Pāli-translation no. NN*) — vol 17 = `25-26`, vol 32 = `52`. **These look like the ORIGINAL BI edition's translation-volume numbers**, i.e. the 2009 series re-issuing the BI translation with commentary added and cross-referencing the old numbering. **If true it is a ready-made concordance from this series back to the BI edition** — exactly the provenance link the project needs. ⏳ **Verify against a BI volume before relying on it.**

### 7.1 · ⚠️⚠️ THE RIGHTS POSITION IS COMPLETELY DIFFERENT, AND L22 DOES NOT COVER IT

**L22 reasons about a 1927–69 edition: ancient underlying text, a faithful transcription attracting no new copyright, an editorial right long expired.** ⛔ **None of that applies to a work first printed in 2009.** A 2009 translation-with-commentary is **squarely within copyright in any jurisdiction**, the translators and commentators are plausibly living, and the publisher is a live party.

⛔ **Do not transcribe, extract, redistribute or train on this series pending a separate rights answer.** ⚠️ **And the substrate's earlier framing conflated the two — this datasheet's own §3 called the material "a 20th-century scholarly translation by named Cambodian monastics", which describes the BI edition, not this.** The BI translation remains the corpus this datasheet specifies; **the 82 volumes are a different, modern, protected work that happens to sit in the same directory.**
