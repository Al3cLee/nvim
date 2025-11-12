#import "@preview/ctheorems:1.1.3": *
#show: thmrules
#let result = thmbox(
        "theorem",
              "Result",
              base_level:1,
              separator:[*.* ],
              fill: rgb("#eeecec"))
#let theorem = thmbox(
        "theorem",
              "Theorem",
              base_level:1,
              separator:[*.* ],
              fill: rgb("#eeecec"))
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
#import "@preview/physica:0.9.5": *
#set page(paper: "a4", numbering: "1")
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

// No indent script for ad-hoc tweaks
#let noindent(x) = [#block[#x]]

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

// Here begins our document.

#set document(title: [Title], date: auto)
#show title: it => {align(center,it)}
#title()

#align(center)[
#datetime.today().display("[month repr:short] [day padding:none], [year]")
]
#block(height: 0.5em)
This is a playground note.
Equations before the first section are numbered `(0.x)`.

$ x=1 $

// #outline()

= First Section

Text starts here. Every proclamation-like figure is numbered as
`<heading>.<theorem-counter>`
such that, for two such figures A and B,
if A's number is larger than B, then
A appears later than B.

#motivation[Consider a model where...]

Some random discussions... #lorem(40)

#definition[We define the quantity...
#lorem(45)]

#example("Strong coupling")[In the strong-coupling regime,...]

#graybox[Hahaha.]

#figure(
```txt
some code
some other code
```
,
caption: [some random listing]
)

#theorem[haha]
#result[haha?]


// #bibliography(style: "american-physics-society", "ref.bib")
