#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#import "@preview/ctheorems:1.1.3": *
#import "@preview/physica:0.9.5": *

#let result = thmbox.with(padding: (top: 0em, bottom: 0em))(
        "theorem",
              "Result",
              base_level:1,
              separator:[*.* ],
              stroke: rgb("#435965")+1pt,
              radius:0pt,
              breakable:true)
#let theorem = thmbox.with(padding: (top: 0em, bottom: 0em))(
        "theorem",
              "Theorem",
              base_level:1,
              separator:[*.* ],
              stroke: rgb("#435965")+1pt,
              radius:0pt,
              breakable:true)
#let notation = thmbox.with(padding: (top: 0em, bottom: 0em))(
        "theorem",
              "Notation",
              base_level:1,
              separator:[*.* ],
              stroke: rgb("#435965")+1pt,
              radius:0pt,
              breakable:true)
#let remark = thmplain.with(inset: (left:0pt,right:0pt))(
              "theorem",
              "Remark",
              base_level:1,
              separator:". ")
#let definition = thmplain.with(inset: (left:0pt,right:0pt))(
              "theorem",
              "Definition",
              base_level:1,
              separator:". ")
#let motivation = thmplain.with(inset: (left:0pt,right:0pt))(
              "theorem",
              "Motivation",
              base_level:1,
              separator:". ")
#let example = thmplain.with(inset: (left:0pt,right:0pt,top:0pt))(
              "theorem",
              "Example",
              base_level:1,
              separator:". ")

// Custom `graybox` environment.
#let graybox(x)= pad(top: 0.5em,bottom: 0.5em)[#block(
      fill: rgb("#eeecec"),  // Light grey background
      // stroke: rgb("#cccccc"), // Grey border
      radius: 0.3em,           // Rounded corners
      inset: 1.2em,           // Padding inside the box
      width: 100%,           // Full width
      [#x]
)]

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
// main.typ: `#import preamble.typ: *`,
// `#show: template-touying`, `#show: bib-main-touying`,
// CONTENTS, [`#include "child.typ"`]
//
// [child.typ]: `#import preamble.typ: *`,
// `#show: bib-child`, CONTENTS
//
// Fun fact: to switch between a doc and a touying,
// simply replace the words `touying` in the show rules of `main.typ` with `doc`,
// and there is no need to alter child files!
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
      neutral-dark: rgb("#658594"), // dragonBlue
      neutral-darkest: rgb("#0d0c0c"), // dragonBlack0
    ),
    // config-common(handout: true)
    // uncomment the above line to remove all animation sub-slides
    )
    #show: thmrules
    #set heading(numbering: "1.1.")
    #set math.equation(numbering: "(1)")
    #set text(size: 18pt, font: "Lato")
    #set par(justify: true)
    #show heading.where(level:1): set text(weight: "regular")
    
    #title-slide()
    
    #doc
    
    // #bib-slide(main:false)
]

// Document template for main file.
//
// Usage:
//
// preamble.typ: same as this file `Typst_templates.typ`, providing
// custom functions and templates.
//
// main.typ: `#import preamble.typ: *`,
// `#show: template-doc`, `#show: bib-main-doc`,
// CONTENTS, [`#include "child.typ"`]
//
// [child.typ]: `#import preamble.typ: *`,
// `#show: bib-child`, CONTENTS
//
// Fun fact: to switch between a doc and a touying,
// simply replace the words `doc` in the show rules of `main.typ` with `touying`,
// and there is no need to alter child files!
#let template-doc(doc)= [
    #show: thmrules
    #set page(paper: "a4", numbering: "1 of 1")
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
    #set par(
            leading: 0.5em, 
            spacing: 1em, 
            first-line-indent: 2em, 
            justify: true)
    #show heading: set block(above: 1em, below: 1em)
    
    // Color for links, disable for printing in black&white.
    #show link: set text(fill: maroon)
    #show ref: set text(fill: maroon)
    
    // Gray box and font setting for code blocks.
    #show raw: set text(font: "Fira Code")
    #show raw.where(block: true): block.with(
      fill: rgb("#f5f5f5"),     // Light gray background
      inset: 1.2em,               // Padding inside
      width: 100%,              // Full width
      radius: 0pt,               // Rounded corners (optional)
    )


    // Set document title and its appearance
    #set document(title: [Representation Quadric], date: auto)
    #show title: it => [#align(center,it)]
    #title()

    // Add date after the title
    #align(center)[
    #datetime.today().display("[month repr:short] [day padding:none], [year]")
    ]
    #block(height: 0.5em)
    #doc
 
    // #load-bib(main: false)
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
