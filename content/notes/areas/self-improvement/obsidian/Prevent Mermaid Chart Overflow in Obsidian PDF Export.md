**Problem:** Mermaid diagrams often spill off the page when using Export to PDF [^1].

## Solution — Add a CSS snippet for print

```css
@media print {
  .mermaid > svg {
    max-width: 100%;
    max-height: 100%;
    page-break-inside: avoid;
  }
}
```

## Bonus — Apply the same scaling in preview mode

```css
.mermaid > svg {
  max-width: 100%;
}
```

## How to Add a CSS Snippet in Obsidian [^2]

**Desktop:**

1. Open **Settings → Appearance → CSS snippets**.
2. Click **Open snippets folder**.
3. Create a new `.css` file (e.g. `mermaid-fit.css`) and paste in the snippet.
4. Back in Obsidian, click **Reload snippets**.
5. Toggle the snippet on to enable it.

**Mobile/Tablet:**

1. Use a file manager to navigate to your vault's configuration folder (check path via _Manage vaults…_).
2. Create a `snippets` folder if it doesn't exist, and add your `.css` file there.
3. In Obsidian, go to **Settings → Appearance → CSS snippets**, tap **Reload snippets**, then toggle it on.

Obsidian auto-detects changes when you save the file — no restart needed (though _Reload Obsidian without saving_ from the Command palette can help if changes don't appear immediately).

## Notes

- The `> svg` selector was needed for the rule to take effect.
- Trade-off: very large charts get scaled down significantly. If you need precise control over large-format printing, PDF export from Markdown may not be the right tool.

## References

[^1]: Jadael, ["Prevent Mermaid charts from overflowing the page in Export to PDF"](https://forum.obsidian.md/t/prevent-mermaid-charts-from-overflowing-the-page-in-export-to-pdf/13381), Obsidian Forum (Feb 2021).

[^2]: ["CSS snippets"](https://obsidian.md/help/snippets), Obsidian Help.
