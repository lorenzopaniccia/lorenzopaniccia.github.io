# Lorenzo Paniccia — Portfolio

Sito personale pubblicato su GitHub Pages: https://lorenzopaniccia.github.io

Sito statico in HTML/CSS/JS puro, nessuna build step richiesta.

## Struttura

- `index.html` — home: hero, progetti, esperienza, skills, formazione, chi sono, contatti
- `progetti/<slug>/index.html` — una pagina per ogni case study (oggi: `calcio-in-ciociaria`)
- `css/style.css` — stili condivisi (tema scuro terminal-inspired)
- `js/script.js` — menu mobile e anno nel footer
- `assets/` — screenshot dei progetti, immagine per la social preview (`og-image.png`)
- `404.html`, `robots.txt`, `sitemap.xml`

## Aggiungere un progetto

1. In `index.html`, sezione `#projects`, copia il template commentato di `<article class="card">` e compila testo, tag e link.
2. Se il progetto ha un case study, copia `progetti/calcio-in-ciociaria/index.html` in `progetti/<slug>/index.html`, aggiorna meta tag, canonical e contenuti.
3. Aggiungi l'URL della nuova pagina a `sitemap.xml`.

Solo progetti personali o comunque pubblicabili: niente dettagli di progetti aziendali o clienti.

## Sviluppo locale

Servi la cartella con un server statico qualsiasi, ad esempio:

```bash
npx serve .
```

oppure, senza dipendenze, con lo script PowerShell incluso:

```powershell
.\serve.ps1
```

## Deploy

Il sito è pubblicato tramite GitHub Pages, servendo direttamente il branch `main` (nessuna GitHub Action necessaria). Basta fare push su `main` e la pagina si aggiorna in automatico.
