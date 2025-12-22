#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#import "@preview/ctheorems:1.1.3": *
#import "@preview/physica:0.9.7": *
#let df(x) = dd(x) + sym.space.thin

#let result = thmbox.with(padding: (top: 0em, bottom: 0em))(
        "theorem",
              "Result",
              base_level:1,
              separator:[*.* ],
              fill: rgb("#ecece8"),
              radius:0pt,
              breakable:true,
              )
#let theorem = thmbox.with(padding: (top: 0em, bottom: 0em))(
        "theorem",
              "Theorem",
              base_level:1,
              separator:[*.* ],
              fill: rgb("#ecece8"),
              radius:0pt,
              breakable:true,
              )
#let notation = thmplain.with(inset: (left:0pt,right:0pt))(
              "theorem",
              "Notation",
              base_level:1,
              separator:". ",
              )
#let remark = thmplain.with(inset: (left:0pt,right:0pt))(
              "theorem",
              "Remark",
              base_level:1,
              separator:". ",
              )
#let definition = thmplain.with(inset: (left:0pt,right:0pt))(
              "theorem",
              "Definition",
              base_level:1,
              separator:". ",
              )
#let motivation = thmplain.with(inset: (left:0pt,right:0pt))(
              "theorem",
              "Motivation",
              base_level:1,
              separator:". ",
              )
#let example = thmplain.with(inset: (left:0pt,right:0pt,top:0pt))(
              "theorem",
              "Example",
              base_level:1,
              separator:". ",
              )

// Custom `graybox` environment.
#let graybox(x)= block(
      fill: rgb("#ecece8"),  // Light grey background
      // stroke: rgb("#cccccc"), // Grey border
      radius: 0pt,           // Rounded corners
      inset: 1.2em,           // Padding inside the box
      width: 100%,           // Full width
      breakable: true,
      [#x]
)


// Custom solution environment for homework.
#let solution(x)= [
    #graybox[*Solution.* #x]
]

#let load-bib(main: false, title: "Bibliography") = {
  counter("bibs").step()

  context if main {
    [#bibliography("ref.bib",title:title) <main-bib>]
  } else if query(<main-bib>) == () {
    // This is the first bibliography, and there is no main bibliography
    bibliography("ref.bib",title:title)
  }
}

// Bibliography slide for metropolis-theme
#let bib-slide(main:true) = [
#slide(align:top,title:"Bibliography")[
#load-bib(main:main,title:"")]
]

// Touying template for main file.
//
// Usage:
//
// preamble.typ: same as this file `Typst_templates.typ`, providing
// custom functions and templates.
//
// main.typ:
// #import "preamble.typ": *
// [#show: bib-main-touying]
// [#show: template-touying] // show this if you insist on writing contents in main.typ
// #include "cover.typ"
// #include "child.typ"
//
// cover.typ:
// #import "preamble.typ": *
// #show: template-touying
// [#show: bib-child]
// #title-slide()
//
// child.typ:
// #import "preamble.typ": *
// #show: template-touying
// [#show: bib-child]
// CONTENTS

#let template-touying-main(doc) = [#doc] // this is trivial, just to align with template-doc structure
#let template-touying(doc) = [
    #show: metropolis-theme.with(footer-progress: false, aspect-ratio: "16-9", 
    config-info(title: par(text(size: 1.5em)[Title of this Talk]),
        subtitle: [...and some subtitle where you can write 
        a long bunch of words],
        author: [Wentao Li #footnote[al3c.wentao.lee\u{0040}gmail.com, 
        homepage: #link("https://wentaoli.xyz")]],
        date: datetime.today(),
        institution: [Institution]
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
    #show: thmrules
    #set heading(numbering: "1.1.")
    #set footnote(numbering: "*")
    #show raw: set text(font: "Fira Code")
    #show raw.where(block: true): block.with(
      fill: rgb("#f5f5f5"),     // Light gray background
      inset: 1.2em,               // Padding inside
      width: 100%,              // Full width
      radius: 0pt,               // Rounded corners (optional)
    )
    #set math.equation(numbering: "(1)")
    #set text(size: 18pt, font: "Lato")
    #set par(justify: true)
    #show heading.where(level:1): set text(weight: "regular")
    // Color for links, disable for printing in black&white.
    #show link: set text(fill: rgb("#cc6d00"))
    #show ref: set text(fill: rgb("#cc6d00"))
    
    // #title-slide()
    
    #doc
    
    // #bib-slide(main:false)
]

// Document template for main file.
//
// Usage:
//
// preamble.typ:
// same as this file `Typst_templates.typ`, providing
// custom functions and templates.
//
// main.typ:
// #import "preamble.typ": *
// [#show: template-doc] // only show this if you have contents in main.typ
// #show: template-doc-main // go to this function's definition to change document title
// [#show: bib-main-doc]
// [CONTENTS]
// [#include "child.typ"]
//
// [child.typ]:
// #import "preamble.typ": *
// #show: template-doc
// [#show: bib-child]
// CONTENTS
//
#let template-doc(doc)= [
    #show: thmrules
    #show heading.where(level: 1): it => {
      counter(math.equation).update(0)
      it
    }
    
    // Left align the body of listings while
    // their caption stay center aligned.
    #show figure.where(kind:raw): it => {
      align(left)[#it.body]
      v(1em,weak:true)
      it.caption
    }
    // Number equations under 1st-level sections.
    #set math.equation(numbering: (..nums) => {
      let section = counter(heading).get().first()
      numbering("(1.1)", section, ..nums)
    })
    #set heading(numbering: "1.1. ")
    
    // Mimic LaTeX look.
    // #set text(font: "New Computer Modern")
    #set text(size:10pt)
    #set par(
            leading: 0.5em, 
            spacing: 1.2em, 
            first-line-indent: 2em, 
            justify: true)
    #show heading: set block(above: 1em, below: 1em)
    
    // Color for links, disable for printing in black&white.
    #show link: set text(fill: rgb("#cc6d00"))
    #show ref: set text(fill: rgb("#cc6d00"))
    
    // Gray box and font setting for code blocks.
    #show raw: set text(font: "Fira Code")
    #show raw.where(block: true): block.with(
      fill: luma(240),     // Light gray background
      inset: 1.2em,               // Padding inside
      width: 100%,              // Full width
      radius: 0pt,               // Rounded corners (optional)
    )

    #show raw.where(block: false): it => {
    let code_text = text(font:"Fira Code", it.text)
      box(
        fill: luma(235),          // light grey background
        inset: (x: 0.2em, y: 0em), // tiny vertical padding to avoid line height change
        outset: (y:0.3em),
        radius: 0em,               // no rounded corners
      )[#code_text]
    }


    #doc
 
    // #load-bib(main: false)
]

#let template-doc-main(main-doc) = [
    #set page(paper: "a4", numbering: "1 of 1")
    // Set document title and its appearance
    #set document(title: [Title], date: auto)
    #show title: it => [#align(center,it)]
    #title()

    // Add date after the title
    #align(center)[
    #datetime.today().display("[month repr:short] [day padding:none], [year]")
    ]
    #block(height: 0.5em)
    #main-doc
]

#let bib-child(child-doc) = [
    #child-doc
    #load-bib(main:false) 
]

#let bib-main-doc(main-doc) = [
    #main-doc
    #load-bib(main:true)
]

#let bib-main-touying(main-slide) = [
    #main-slide
    #bib-slide()
]
