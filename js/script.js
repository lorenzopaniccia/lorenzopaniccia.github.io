// Comportamenti minimi condivisi da tutte le pagine: anno nel footer e menu mobile.
// Ogni blocco controlla che gli elementi esistano, così lo script può essere
// incluso anche nelle pagine dei case study senza modifiche.

const yearEl = document.getElementById('year');
if (yearEl) {
  yearEl.textContent = new Date().getFullYear();
}

const navToggle = document.getElementById('navToggle');
const navLinks = document.getElementById('navLinks');

if (navToggle && navLinks) {
  const setOpen = (open) => {
    navLinks.classList.toggle('open', open);
    navToggle.setAttribute('aria-expanded', String(open));
    navToggle.setAttribute('aria-label', open ? 'Chiudi menu' : 'Apri menu');
  };

  navToggle.addEventListener('click', () => {
    setOpen(!navLinks.classList.contains('open'));
  });

  navLinks.querySelectorAll('a').forEach((link) => {
    link.addEventListener('click', () => setOpen(false));
  });

  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && navLinks.classList.contains('open')) {
      setOpen(false);
      navToggle.focus();
    }
  });

  document.addEventListener('click', (e) => {
    if (
      navLinks.classList.contains('open') &&
      !navLinks.contains(e.target) &&
      !navToggle.contains(e.target)
    ) {
      setOpen(false);
    }
  });
}
