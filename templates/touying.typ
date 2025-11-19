
#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#set heading(numbering: "1.1.")
#import "@preview/ctheorems:1.1.3": *
#show: thmrules

#let result = thmbox.with(padding: (top: 0em, bottom: 0em))(
        "theorem",
              "Result",
              base_level:1,
              separator:[*.* ],
              fill: rgb("#eeecec"))
#let theorem = thmbox.with(padding: (top: 0em, bottom: 0em))(
        "theorem",
              "Theorem",
              base_level:1,
              separator:[*.* ],
              fill: rgb("#eeecec"))
#let notation = thmbox.with(padding: (top: 0em, bottom: 0em))(
        "theorem",
              "Notation",
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
#show: metropolis-theme.with(footer-progress: false, aspect-ratio: "16-9", 
config-info(title: par(text(size: 1.5em)[Title of this Talk]),
    subtitle: [...and some subtitle where you can write a long bunch of words],
    author: [Wentao Li #footnote[al3c.wentao.lee\u{0040}gmail.com, homepage: #link("https://wentaoli.xyz")]],
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
  neutral-darkest: rgb("#393836"), // dragonBlack5
),
// config-common(handout: true)
// uncomment the above line to remove all animation sub-slides
)



#set math.equation(numbering: "(1)")
#set text(size: 18pt, font: "Lato")
#set par(justify: true)
#show heading.where(level:1): set text(weight: "regular")

#title-slide()

= First section


== First subsection

Hello, *Touying*!



// #slide(align:top,title:"Bibliography")[
// #bibliography(title:none,style: "american-physics-society", "ref.bib")
// ]

