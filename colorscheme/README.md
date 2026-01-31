# Colorscheme

Colorschemes are sourced from here and applied consistently across systems. It makes use of the [Base16](https://github.com/chriskempson/base16) format.

## Base16 Schema

Base16 defines a standardized 16-color palette. Colors `base00` to `base07` are typically variations of a shade (darkest to lightest for dark themes, lightest to darkest for light themes), while `base08` to `base0F` are individual accent colors.

**Background & Foreground (base00-base07):**
- `base00` - Default Background
- `base01` - Lighter Background (status bars, line numbers, folding marks)
- `base02` - Selection Background
- `base03` - Comments, Invisibles, Line Highlighting
- `base04` - Dark Foreground (status bars)
- `base05` - Default Foreground, Caret, Delimiters, Operators
- `base06` - Light Foreground (not often used)
- `base07` - Light Background (not often used)

**Syntax Colors (base08-base0F):**
- `base08` - Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
- `base09` - Integers, Boolean, Constants, XML Attributes, Markup Link Url
- `base0A` - Classes, Markup Bold, Search Text Background
- `base0B` - Strings, Inherited Class, Markup Code, Diff Inserted
- `base0C` - Support, Regular Expressions, Escape Characters, Markup Quotes
- `base0D` - Functions, Methods, Attribute IDs, Headings
- `base0E` - Keywords, Storage, Selector, Markup Italic, Diff Changed
- `base0F` - Deprecated, Opening/Closing Embedded Language Tags

Each colorscheme can define both `dark` and `light` variants for system-wide theming.

*Reference: [Base16 Styling Guidelines](https://github.com/chriskempson/base16/blob/main/styling.md)*
