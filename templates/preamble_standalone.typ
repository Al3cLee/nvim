#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#import "@preview/ctheorems:1.1.3": *
#import "@preview/physica:0.9.7": *
#let df(x) = dd(x) + sym.space.thin
#let uid = [\u{1d7d9}] // use Unicode for the id operator 𝟙

#let text_size_doc = 11pt

#let font_config = (
  (name: "Libertinus Serif", covers: "latin-in-cjk"),
  "Libertinus Serif",
  "Source Han Serif SC",
)

#let font_config_touying = (
  (name: "Lato", covers: "latin-in-cjk"),
  "Lato",
  "Source Han Serif SC",
)

#let abstract(body) = block(inset: (x: 4em))[#par(justify: true)[*Abstract.* #body]]

#let result = thmbox.with(padding: (top: 0em, bottom: 0em))(
  "theorem",
  "Result",
  separator: [*.*#h(0.5em)],
  fill: luma(240), // Light gray background
  base: none,
  radius: 0pt,
  breakable: true,
)

#let theorem = thmbox.with(padding: (top: 0em, bottom: 0em))(
  "theorem",
  "Theorem",
  separator: [*.*#h(0.5em)],
  radius: 0pt,
  fill: luma(240), // Light gray background
  base: none,
  breakable: true,
)

#let example = thmbox.with(padding: (top: 0em, bottom: 0em))(
  "theorem",
  "Example",
  separator: [*.*#h(0.5em)],
  radius: 0pt,
  breakable: true,
  // stroke: (top: 1pt + luma(200), bottom: 1pt + luma(200)),
  inset: (top: 0pt, bottom: 0pt, left: 2em, right: 2em),
  base: none,
)

#let sideline(name) = thmbox.with(padding: (top: 0em, bottom: 0em))(
  "theorem",
  upper(str.first(name)) + str.slice(name, 1),
  inset: (top: 0.5em, bottom: 0.5em, left: 1em, right: 0pt),
  separator: [.#h(0.5em)],
  base: none,
  radius: 0pt,
  stroke: (left: 2pt + luma(200)),
  breakable: true,
  titlefmt: emph,
)

#let definition = sideline("definition")
#let remark = sideline("remark")
#let motivation = sideline("motivation")
#let lemma = sideline("lemma")
#let notation = sideline("notation")
#let corollary = sideline("corollary")

#let glossary-state = state("glossary-entries", ())

#let gloss(term, desc) = context {
  let page-num = counter(page).get().first()
  glossary-state.update(arr => {
    arr.push((key: term, value: desc) + (page: page-num))
    arr
  })
}

#let make-glossary() = context {
  for item in glossary-state.final() [
    - #item.key means: #item.value (see page #item.page)
  ]
}

// Custom `graybox` environment.
#let graybox(x) = block(
  fill: rgb("#ecece8"), // Light grey background
  // stroke: rgb("#cccccc"), // Grey border
  radius: 0pt, // Rounded corners
  inset: 1.2em, // Padding inside the box
  width: 100%, // Full width
  breakable: true,
  [#x],
)


// Custom solution environment for homework.
#let solution(x) = [
  #graybox[*Solution.* #x]
]

#let load-bib(main: false, title: "Bibliography") = {
  context if main {
    [#bibliography("ref.bib", title: title) <main-bib>]
  } else if query(<main-bib>) == () {
    bibliography("ref.bib", title: title)
  }
}

// Bibliography slide for metropolis-theme
#let bib-slide(main: true) = [
  #slide(align: top, title: "Bibliography")[
    #load-bib(main: main, title: "")]
]

// Touying template for main file.

#let template-touying-main(doc) = [#doc] // this is trivial, just to align with template-doc structure
#let template-touying(doc) = [
  #show: metropolis-theme.with(
    footer-progress: false,
    aspect-ratio: "16-9",
    config-info(
      title: par(text(size: 1.5em)[Title of this Talk]),
      subtitle: [...and some subtitle where you can write
        a long bunch of words],
      author: [Wentao Li #footnote[al3c.wentao.lee\u{0040}gmail.com,
          homepage: #link("https://wentaoli.xyz")]],
      date: datetime.today(),
      institution: [Institution],
    ),
    config-colors(
      // Taken from https://github.com/thesimonho/kanagawa-paper.nvim/blob/master/palette_colors.md
      primary: rgb("#cc6d00"), // lotusOrange
      primary-light: rgb("#f2ecbc"), // lotusWhite3
      secondary: rgb("#435965"), // dragonBlue5
      neutral-lightest: rgb("#fafafa"),
      neutral-dark: black,
      neutral-darkest: black,
    ),
    // config-common(handout: true)
    // uncomment the above line to remove all animation sub-slides
  )
  #show link: underline
  #show: thmrules
  #set heading(numbering: "1.1.")
  #set footnote(numbering: "*")
  #show raw: set text(font: "JetBrains Mono")
  #show raw.where(block: true): block.with(
    fill: rgb("#f5f5f5"), // Light gray background
    inset: 1.2em, // Padding inside
    width: 100%, // Full width
    radius: 0pt, // Rounded corners (optional)
  )
  #set math.equation(numbering: "(1)")
  #set text(size: 18pt, font: font_config_touying)
  #set par(justify: true)
  #show heading.where(level: 1): set text(weight: "regular")
  // Color for links, disable for printing in black&white.
  // #show link: set text(fill: rgb("#cc6d00"))
  // #show ref: set text(fill: rgb("#cc6d00"))

  // #title-slide()

  #doc

  // #bib-slide(main:false)
]

// Document template for main file.

#let template-doc(doc) = [
  #show link: underline
  #show: thmrules

  // Left align the body of listings while
  // their caption stay center aligned.
  #show figure.where(kind: raw): it => {
    align(left)[#it.body]
    v(1em, weak: true)
    it.caption
  }
  #set math.equation(numbering: "(1)")
  #set heading(numbering: "1.1.1.1.1. ")
  // Number equations under 1st-level sections.

  // Mimic LaTeX look.
  // #set text(font: "New Computer Modern")
  #let leading_spacing = 0.5em
  #set text(size: text_size_doc, font: font_config)
  #set par(
    leading: leading_spacing, // Line spacing
    spacing: 2 * leading_spacing, // Paragraph spacing
    first-line-indent: (amount: 2em, all: false),
    justify: true,
  )
  #show heading: set block(
    above: 2.4 * leading_spacing,
    below: 2.4 * leading_spacing,
  )

  // Color for links, disable for printing in black&white.
  // #show link: set text(fill: rgb("#cc6d00"))
  // #show ref: set text(fill: rgb("#cc6d00"))

  // Gray box and font setting for code blocks.
  #show raw: set text(font: "JetBrains Mono")
  #show raw.where(block: true): block.with(
    fill: luma(240), // Light gray background
    inset: 1.2em, // Padding inside
    width: 100%, // Full width
    radius: 0pt, // Rounded corners (optional)
  )

  #doc

  // #load-bib(main: false)
]

#let template-doc-main(main-doc) = [
  #set page(paper: "a4", numbering: "1 of 1", margin: (x: 2cm))
  // Set document title and its appearance
  #set document(title: [Title], date: auto)
  #show title: it => [#align(center, it)]
  #title()

  // Add date after the title
  #align(center)[
    #datetime.today().display("[month repr:short] [day padding:none], [year]")
  ]
  #block(height: 0.5em)
  #set text(size: text_size_doc)
  #main-doc
]

#let bib-child(child-doc) = [
  #child-doc
  #load-bib(main: false)
]

#let bib-main-doc(main-doc) = [
  #main-doc
  #load-bib(main: true)
]

// bib slides for the main touying file.
// This is reserved for single-file setup;
// in multiple-file setup, use a dedicated bib.typ
// child file.
#let bib-main-touying(main-slide) = [
  #main-slide
  #bib-slide()
]
