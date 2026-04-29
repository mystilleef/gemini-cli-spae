# Markdown table optimization

Follow these guidelines to maintain Markdown tables within an
80-character line limit.

## Guidelines

Prioritize table preservation using the following hierarchy:

### Phase 1: Compression (Preserve Table)

- **Reference Links**: Use `[Text][ref]` syntax for all `URLs`. Place
  definitions at the document footer.
- **Header Compression**: Abbreviate column titles (e.g., `Desc`, `Qty`,
  `Ver`, `Attr`).
- **Vertical Stacking**: Insert `<br>` tags within cells to stack
  content vertically.
- **Column Capping**: Limit tables to 3-4 essential columns. Move
  secondary data to bulleted lists.

### Phase 2: Conversion (Fallback Only)

- **Structure Change**: Convert to definition lists or bold prose labels
  only when Phase 1 fails to meet the 80-character limit or severely
  damages readability.
- **Heuristic for Conversion**: If abbreviations become cryptic or the
  table requires more than 4 columns to remain useful, proceed to
  Phase 2.
