/*
  Rockets Coffee Roasters — ρυθμίσεις ιστοτόπου
  Επεξεργαστείτε μόνο αυτό το αντικείμενο για τα πραγματικά στοιχεία του καφέ.
*/
const cafeConfig = {
  address: "Ακρωτηρίου 341, ΠΑΤΡΑ, ΕΛΛΑΔΑ",
  mapQuery: "Ακρωτηρίου 341, Πάτρα, Ελλάδα",
  phoneDisplay: "+30 2610 521 888",
  phoneHref: "+302610521888",
  instagram: "@rockets.coffeeroasters",
  instagramUrl: "https://www.instagram.com/rockets.coffeeroasters?stkn=MWd4MXA5eHAxcDNsMg%3D%3D&utm_source=qr",
  facebook: "Rockets Coffee Roasters",
  facebookUrl: "https://www.facebook.com/share/1DfRjhBqK2/?mibextid=wwXIfr",
  hours: [
    ["Δευτέρα", "05:30–22:00"],
    ["Τρίτη", "05:30–22:00"],
    ["Τετάρτη", "05:30–22:00"],
    ["Πέμπτη", "05:30–22:00"],
    ["Παρασκευή", "05:30–22:00"],
    ["Σάββατο", "05:30–22:00"],
    ["Κυριακή", "06:00–22:00"]
  ]
};

document.addEventListener("DOMContentLoaded", () => {
  // Πλοήγηση σε κινητό
  const toggle = document.querySelector(".menu-toggle");
  const nav = document.querySelector(".site-nav");

  toggle?.addEventListener("click", () => {
    const open = nav.classList.toggle("open");
    toggle.setAttribute("aria-expanded", String(open));
    document.body.classList.toggle("menu-open", open);
  });

  nav?.querySelectorAll("a").forEach(link => {
    link.addEventListener("click", () => {
      nav.classList.remove("open");
      toggle?.setAttribute("aria-expanded", "false");
      document.body.classList.remove("menu-open");
    });
  });

  // Στοιχεία καφέ από τις ρυθμίσεις
  const setText = (id, value) => {
    const el = document.getElementById(id);
    if (el) el.textContent = value;
  };

  setText("address-display", cafeConfig.address);
  setText("footer-address", cafeConfig.address.replace(", GREECE", ""));

  setText("phone-display", cafeConfig.phoneDisplay);
  const phone = document.getElementById("phone-link");
  if (phone) phone.href = `tel:${cafeConfig.phoneHref}`;

  setText("instagram-display", cafeConfig.instagram);
  const instagram = document.getElementById("instagram-link");
  if (instagram) instagram.href = cafeConfig.instagramUrl;

  setText("facebook-display", cafeConfig.facebook);
  const facebook = document.getElementById("facebook-link");
  if (facebook) facebook.href = cafeConfig.facebookUrl;

  const hours = document.getElementById("hours-list");
  if (hours) {
    hours.innerHTML = cafeConfig.hours.map(([day, time]) =>
      `<div class="hours-row"><strong>${day}</strong><span>${time}</span></div>`
    ).join("");
  }

  const week = cafeConfig.hours;
  if (week?.length) {
    setText("footer-hours", `${week[0][1]} τις καθημερινές · Οι ώρες του Σαββατοκύριακου αναγράφονται παραπάνω`);
  }

  // Χάρτες Google
  const encodedQuery = encodeURIComponent(cafeConfig.mapQuery);
  const mapFrame = document.getElementById("map-frame");
  const mapOpen = document.getElementById("map-open");
  if (mapFrame) mapFrame.src = `https://www.google.com/maps?q=${encodedQuery}&output=embed`;
  if (mapOpen) mapOpen.href = `https://www.google.com/maps/search/?api=1&query=${encodedQuery}`;

  // Έτος υποσέλιδου
  setText("year", new Date().getFullYear());
});
