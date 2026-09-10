-- Rockets Coffee Roasters
-- Σχήμα MySQL / MariaDB για XAMPP (phpMyAdmin)
-- Αυτό το σχήμα είναι προαιρετικό για τον τρέχοντα στατικό ιστότοπο.
-- Το HTML εμφανίζει απευθείας το μενού και τις ώρες και δεν απαιτεί PHP.

CREATE DATABASE IF NOT EXISTS from_another_space
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE from_another_space;

CREATE TABLE IF NOT EXISTS cafe_settings (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  site_name VARCHAR(120) NOT NULL,
  tagline VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  phone VARCHAR(40) NOT NULL,
  instagram_url VARCHAR(255) NULL,
  facebook_url VARCHAR(255) NULL,
  maps_query VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS opening_hours (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  day_name ENUM('Δευτέρα','Τρίτη','Τετάρτη','Πέμπτη','Παρασκευή','Σάββατο','Κυριακή') NOT NULL,
  opens_at TIME NULL,
  closes_at TIME NULL,
  is_closed TINYINT(1) NOT NULL DEFAULT 0,
  sort_order TINYINT UNSIGNED NOT NULL,
  UNIQUE KEY uq_day (day_name)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS menu_categories (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  sort_order TINYINT UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS menu_items (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  category_id INT UNSIGNED NOT NULL,
  name VARCHAR(120) NOT NULL,
  description VARCHAR(255) NULL,
  price DECIMAL(6,2) NOT NULL,
  is_available TINYINT(1) NOT NULL DEFAULT 1,
  sort_order SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  CONSTRAINT fk_menu_category
    FOREIGN KEY (category_id) REFERENCES menu_categories(id)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO cafe_settings
(site_name, tagline, address, phone, instagram_url, facebook_url, maps_query)
VALUES
(
  'Rockets Coffee Roasters',
  'Χειροποίητος καφές, φρέσκα αρτοσκευάσματα και γρήγορη εξυπηρέτηση σε πακέτο στην καρδιά της Πάτρας.',
  'Η ΔΙΕΥΘΥΝΣΗ ΣΑΣ, ΠΑΤΡΑ, ΕΛΛΑΔΑ',
  '+30 2610 000 000',
  'https://instagram.com/',
  'https://facebook.com/',
  'Η ΔΙΕΥΘΥΝΣΗ ΣΑΣ, Πάτρα, Ελλάδα'
);

INSERT INTO opening_hours (day_name, opens_at, closes_at, is_closed, sort_order) VALUES
('Δευτέρα',    '07:00:00', '18:00:00', 0, 1),
('Τρίτη',      '07:00:00', '18:00:00', 0, 2),
('Τετάρτη',    '07:00:00', '18:00:00', 0, 3),
('Πέμπτη',     '07:00:00', '18:00:00', 0, 4),
('Παρασκευή',  '07:00:00', '19:00:00', 0, 5),
('Σάββατο',    '08:00:00', '19:00:00', 0, 6),
('Κυριακή',    '09:00:00', '15:00:00', 0, 7);

INSERT INTO menu_categories (name, sort_order) VALUES
('Καφές & Ροφήματα', 1),
('Αρτοσκευάσματα & Φούρνος', 2),
('Γρήγορα σνακ / Σάντουιτς', 3);

INSERT INTO menu_items (category_id, name, description, price, sort_order) VALUES
(1, 'Εσπρέσο', 'Διπλή δόση · χαρμάνι του καταστήματος', 2.20, 1),
(1, 'Καπουτσίνο', 'Βελούδινο γάλα · διπλός εσπρέσο', 3.40, 2),
(1, 'Παγωμένο λάτε', 'Κρύο γάλα · εσπρέσο · πάγος', 3.60, 3),
(1, 'Καφές φίλτρου', 'Εποχιακή ποικιλία μονοποικιλιακού καφέ', 3.00, 4),
(1, 'Φρέσκος χυμός πορτοκάλι', 'Στυμμένος τη στιγμή της παραγγελίας', 3.50, 5),

(2, 'Κρουασάν βουτύρου', 'Κλασικό · φρεσκοψημένο', 2.40, 1),
(2, 'Κρουασάν σοκολάτας', 'Μαύρη σοκολάτα · τραγανή ζύμη', 2.80, 2),
(2, 'Ρολό κανέλας', 'Αφράτο ψωμάκι · γλάσο κανέλας', 3.20, 3),
(2, 'Κέικ μπανάνας', 'Αφράτο · καβουρδισμένα καρύδια', 2.90, 4),
(2, 'Καθημερινό ψήσιμο', 'Ρωτήστε στον πάγκο', 3.00, 5),

(3, 'Γαλοπούλα & τυρί', 'Φρυγανισμένο ψωμί ολικής · πράσινη σαλάτα', 5.80, 1),
(3, 'Τοστ λαχανικών', 'Τυρί · ντομάτα · πέστο', 5.60, 2),
(3, 'Φοκάτσια με κοτόπουλο', 'Ψητό κοτόπουλο · μαγιονέζα με μυρωδικά', 6.50, 3),
(3, 'Ελληνικό γιαούρτι', 'Μέλι · γκρανόλα · φρούτα', 4.90, 4),
(3, 'Μπουκιές ενέργειας', 'Βρώμη · κακάο · χουρμάδες', 2.80, 5);
